using System;
using EPiServer.Common;
using EPiServer.Common.Queries;
using EPiServer.Community.Blog;
using EPiServer.Community.Blog.Security;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class CreateBlogEntry : RelateUserControlBase<Model.BasePage>
    {
        private Blog _blog;
        public Blog Blog 
        {
            get
            {
                if (_blog == null && ViewState["blogId"] != null)
                {
                    _blog = BlogHandler.Instance.GetBlog(int.Parse(ViewState["blogId"].ToString()));
                }
                return _blog;
            }
            set
            {
                _blog = value;
                ViewState["blogId"] = (value != null) ? (object)value.ID : null;
            }
        }
        protected string ValGroup
        {
            get { return string.Format("createEntryValidationGroup{0}", Blog.ID); }
        }
        private string _redirectUrl;
        public string RedirectUrl
        {
            get
            {
                if (_redirectUrl == null && ViewState["redirectUrl"] != null)
                {
                    _redirectUrl = ViewState["redirectUrl"].ToString();
                }
                return _redirectUrl;
            }
            set
            {
                _redirectUrl = value;
                ViewState["redirectUrl"] = value;
            }
        }

        protected void btnCreateNewEntry_OnClick(object sender, EventArgs e)
        {
            if(Page.IsValid && Blog != null)
            {
                var accessRights = new BlogAccessRights { CreateEntry = true };

                if(CurrentUser.CheckAccess(Blog, accessRights))
                {
                    var currentAuthor = AuthorHandler.Instance.ChangeAuthor(null, new UserAuthor(CurrentUser));
                    
                    // Add the new entry
                    var entry = new Entry(Blog, txtTitle.Text.FormatContentTextNoHtml(), tinyTextEditor.Text, currentAuthor)
                    {
                        PublicationStart = DateTime.Now,
                        SenderIP = Request.UserHostAddress,
                        Status = EntityStatus.Approved
                    };
                    var entryClone = (Entry)BlogHandler.Instance.AddEntry(entry).Clone();
                    entryClone.Header = txtTitle.Text.FormatContentTextNoHtml();
                    BlogHandler.Instance.UpdateEntry(entryClone);
                    //QueryHandler.RemoveQueryResultCache()
                }
            }
            Response.Redirect(!string.IsNullOrWhiteSpace(RedirectUrl) ? RedirectUrl : Request.RawUrl);
        }
    }
}