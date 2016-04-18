using System;
using System.Web.UI.WebControls;
using EPiServer.Common;
using EPiServer.Common.Comments;
using EPiServer.Common.Data;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class CMSPageEntityComments : RelateUserControlBase<Model.BasePage>
    {
        private static bool? _isCMSPageEntitySupported;

        /// <summary>
        /// Gets or sets a value indicating whether CMS page entity is supported.
        /// </summary>
        public virtual bool IsCMSPageEntitySupported
        {
            get
            {
                if (!_isCMSPageEntitySupported.HasValue)
                {
                    _isCMSPageEntitySupported = EntityProviderHandler.Instance.GetEntityProvider(typeof(CMSPageEntity)) != null;
                }

                return _isCMSPageEntitySupported.Value;
            }

            set
            {
                _isCMSPageEntitySupported = value;
            }
        }
        /// <summary>
        /// Gets or sets the current entity.
        /// </summary>
        public virtual CMSPageEntity CurrentEntity
        {
            get
            {
                if(CurrentPage != null)
                    return new CMSPageEntity(CurrentPage);
                return null;
            }
        }

        /// <summary>
        /// Gets or sets the comments.
        /// </summary>
        public virtual CommentCollection Comments
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets a value indicating whether comments is enabled.
        /// When comments is disabled, it will not be possible to add new comments
        /// </summary>
        public virtual bool Enabled
        {
            get;
            set;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsCMSPageEntitySupported)
            {
                return;
            }

            if (Visible)
            {
                BindComments();
            }
        }
        /// <summary>
        /// Binds the comments to the user control.
        /// </summary>
        protected virtual void BindComments()
        {
            if (CurrentEntity != null)
            {
                CMSPageEntity entity = CMSPageEntityHandler.Instance.GetEntity(CurrentEntity.PageGuid, CurrentEntity.PageLanguage, CurrentEntity.PageWorkID);
                int totalItems = 0;
                if (entity != null)
                {
                    Comments = CommentHandler.Instance.GetComments(EntityReference.ToEntityReference(entity), null, DateTime.MinValue, DateTime.MaxValue, EntityStatus.Approved, pager.CurrentPagingNumber, 20, out totalItems, new CommentSortOrder(CommentSortField.Created, EPiServer.Common.Sorting.SortingDirection.Descending));
                }
                lvEntries.DataSource = Comments;
                lvEntries.DataBind();
                pager.BindPagerControl(20, totalItems);
            }
        }

        protected void lbDelete_Command(object sender, CommandEventArgs e)
        {
            IComment entry = CommentHandler.Instance.GetComment(Convert.ToInt32(e.CommandArgument.ToString()));

            if (entry != null && HasRemoveAccessRights(entry))
            {
                // Delete the  
                CommentHandler.Instance.RemoveComment(entry);
                BindComments();
            }
        }

        protected void btnSendComment_Click(object sender, EventArgs e)
        {
            if (CurrentUser != null && Page.IsValid)
            {
                if (CurrentEntity != null)
                {
                    CMSPageEntity pagedataEntity = CMSPageEntityHandler.Instance.GetEntity(CurrentEntity.PageGuid, CurrentEntity.PageLanguage, CurrentEntity.PageWorkID);
                    if (pagedataEntity == null)
                    {
                        pagedataEntity = new CMSPageEntity(CurrentEntity.PageGuid, CurrentEntity.PageLanguage, CurrentEntity.PageWorkID);
                        CMSPageEntityHandler.Instance.AddEntity(pagedataEntity);
                    }

                    var comment = new Comment(EntityReference.ToEntityReference(pagedataEntity), string.Empty, txtCommentContent.Text.FormatContentTextNoHtml(), new UserAuthor(CurrentUser)) { Status = EntityStatus.Approved };
                    var clone = CommentHandler.Instance.AddComment(comment);
                    ActivityFeedHandler.PublishArticleComment(clone, CurrentPage);
                    txtCommentContent.Text = string.Empty;
                    BindComments();
                }
            }
        }

        protected string GetConfirmDelete()
        {
            return string.Format("return confirm('{0}');", Translate("/confirmdeletequestions/comment"));
        }
    }
}