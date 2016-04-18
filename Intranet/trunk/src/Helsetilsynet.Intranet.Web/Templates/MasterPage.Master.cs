using System;
using System.Web;
using EPiServer;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private PageData _currentPage;
        public PageData CurrentPage
        {
            get
            {
                if (_currentPage != null) 
                    return _currentPage;

                var page = Page as PageBase;
                if (page == null)
                    return null;

                return _currentPage = page.CurrentPage;
            }
        }

        protected string GetPageTypeName()
        {
            return CurrentPage.PageTypeName;
        }

        protected string GetLayoutClassname()
        {
            return CurrentPage != null  && CurrentPage as BasePage != null ? ((BasePage)CurrentPage).LayoutClassName : string.Empty;
        }

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbSearch.Text))
            {
                string search = HttpUtility.UrlEncode(tbSearch.Text);
                string searchUrl = RelateTemplatePage<RelateGlobalSettings>.GetSearchPageUrl(search);
                Response.Redirect(searchUrl);
            }
        }
        protected string Translate(string str)
        {
            return LanguageManager.Instance.Translate(str, GetLanguage());
        }

        private static string GetLanguage()
        {
            return "no";
        }
    }
}