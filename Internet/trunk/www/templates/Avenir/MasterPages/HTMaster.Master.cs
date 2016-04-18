using System;
using System.Web.UI;
using EPiServer;
using EPiServer.Configuration;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Classes.Helpers;
using Helsetilsynet.templates.Avenir.Classes.PropertyMappings;
using Helsetilsynet.templates.Avenir.Util;

namespace Avenir.Templates.MasterPages
{
    public partial class HTMaster : MasterPage
    {
        public System.Web.UI.HtmlControls.HtmlForm Form1;
        private const string _title = "{0}{1}{2}";
        private string _titleSeparator = " - ";
        private string mainClass = "";
        PageData _currentPage;

        public PageData CurrentPage
        {
            get { return _currentPage ?? (_currentPage = FindCurrentPage(this)); }
        }

        public string TitleSeparator
        {
            get { return _titleSeparator; }
            set { _titleSeparator = value; }
        }

        protected string PageTypeName
        {
            get { return CurrentPage.PageTypeName.Replace(" ", ""); }
        }

        protected string GetLang()
        {
            try
            {
                var language = PropertyHelper.GetPropertyValue<string>(HTMasterPropertyMappings.Language, CurrentPage);
                return string.IsNullOrEmpty(language) ? ConfigManager.DefaultLanguage : language;

            }
            catch (Exception)
            {
                return ConfigManager.DefaultLanguage;
            }
            //var language = PropertyHelper.GetPropertyValue<string>(HTMasterPropertyMappings.Language, CurrentPage);
            //return string.IsNullOrEmpty(language) ? ConfigManager.DefaultLanguage : language;
        }

        public void NoMenu()
        {
            //SubMenu.Visible = false;
        }

        protected string GetClass()
        {
            return mainClass;
        }

        public void NoRightColumn()
        {
            mainClass = "noRightColumn";
        }

        protected string GetLogotext()
        {
            if (CurrentPage.PageLink == PageReference.StartPage)
                return PropertyHelper.GetPropertyValue<string>(HTMasterPropertyMappings.LogoAlt1Txt, CurrentPage);
            return PropertyHelper.GetPropertyValue<string>(HTMasterPropertyMappings.LogoAlt2Txt, CurrentPage);
        }

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            //if (SubMenu != null && MainMenu != null)
            //{
            //    SubMenu.MenuList = MainMenu.MenuList;
            //}
            //if (CurrentPage.PageTypeName == PageTypesHelper.StartPage)
            //{
            //    SubMenu.Visible = false;
            //}

            var page = (PageBase)Page;
            Page.Title = string.Format(_title, page.CurrentPage.Property[CommonPropertyMappings.PageName].ToWebString(), TitleSeparator, Settings.Instance.SiteDisplayName);
            if (page.CurrentPage.Property[CommonPropertyMappings.PageName].ToString() == "Emner")
            {
                string emne = "Emne " + StripNumber(Request.QueryString["emne"]);
                Page.Title = string.Format(emne, TitleSeparator, Settings.Instance.SiteDisplayName);
            }
        }

        private static PageData FindCurrentPage(Control ctr)
        {
            if (ctr is IPageSource)
            {
                return (ctr as IPageSource).CurrentPage;
            }

            return ctr.Parent != null ? FindCurrentPage(ctr.Parent) : null;
        }

        //public bool EnableSubmenu
        //{
        //    set
        //    {
        //        if (SubMenu != null)
        //            SubMenu.Visible = value;
        //    }
        //}

        protected string GetSitemap()
        {
            var pr = new PageReference(CurrentPage.Property["SiteMap"].ToString());
            PageData pd = DataFactory.Instance.GetPage(pr);
            return pd.LinkURL;
        }

        protected string StripNumber(string s)
        {
            int p = s.IndexOf('0');
            if (p > 0)
                return s.Substring(0, p);
            return s;
        }
    }
}
