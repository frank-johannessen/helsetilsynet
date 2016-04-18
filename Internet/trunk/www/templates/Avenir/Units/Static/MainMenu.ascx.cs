/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer;
using EPiServer.Core;
using EPiServer.Web.WebControls;

namespace Avenir.Templates.Units.Static
{
    /// <summary>
    /// Lists the pages visible in the main (top) menu.
    /// </summary>
    public partial class MainMenu : UserControlBase
    {
        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            //PageData pdStart = GetPage(PageReference.StartPage);
            //Menu.PageLink = PageReference.StartPage;
            Menu.PageLink = new PageReference(CurrentPage.Property["MainMenuContainer"].ToString());
            Menu.PageLoader.GetChildrenCallback = new HierarchicalPageLoader.GetChildrenMethod(LoadChildren);
            Menu.DataBind();
            //if (CurrentPage != pdStart)
            //{
            //    Menu2.PageLink = CurrentPage.PageLink;
            //    Menu2.PageLoader.GetChildrenCallback = new HierarchicalPageLoader.GetChildrenMethod(LoadChildren);
            //    Menu2.DataBind();
            //}
        }

        /// <summary>
        /// Creates the collection for the main menu, adding the startpage
        /// </summary>
        private PageDataCollection LoadChildren(PageReference pageLink)
        {
            PageDataCollection pages = DataFactory.Instance.GetChildren(pageLink, LanguageSelector.AutoDetect(true));
            pages.Insert(0, DataFactory.Instance.GetPage(pageLink));
            return pages;
        }

        /// <summary>
        /// Gets or sets the MenuList for this control
        /// </summary>
        public MenuList MenuList
        {
            get { return Menu; }
            set { Menu = value; }
        }

        protected string GetLink(PageData pd)
        {
            //PageData pd = CurrentPage;
            string s = "<a href=\"" + pd.LinkURL + "\"><span>" + pd.PageName + "</span></a>";
            return s;
        }
    }
}