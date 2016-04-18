/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System.Collections.Generic;
using System.Globalization;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web.WebControls;

namespace Avenir.Templates.Units.Static
{
    /// <summary>
    /// Lists the pages visible in the main (top) menu.
    /// </summary>
    public partial class UtilMenu : UserControlBase
    {
        private bool _start = true;

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            //DataFactory.Instance.GetPage(new PageReference(10367));
            //Menu.PageLink = PageReference.StartPage;
            Menu.PageLink = new PageReference(CurrentPage.Property["HelpMenuContainer"].ToString());
            Menu.PageLoader.GetChildrenCallback = new HierarchicalPageLoader.GetChildrenMethod(LoadChildren);
            Menu.DataBind();

            var accessKeyMenuSource = GetAccessKeyPages();
            DisplayAccessKeyMenu(accessKeyMenuSource.Count);
            AccessKeyMenu.DataSource = accessKeyMenuSource;
            AccessKeyMenu.DataBind();
        }

        private void DisplayAccessKeyMenu(int count)
        {
            if (count == 0)
                AccessKeyMenu.Visible = false;
        }

        private Dictionary<string, string> GetAccessKeyPages()
        {
            var startPage = DataFactory.Instance.GetPage(PageReference.StartPage);
            var result = new Dictionary<string, string>();

            var accessKeyName = "AccessKey0";

            for (var i = 1; i < 8; i++ )
            {
                if (startPage.Property[accessKeyName] != null &&
                    !string.IsNullOrEmpty(startPage.Property[accessKeyName].ToString()))
                {
                    var page =
                    DataFactory.Instance.GetPage(PageReference.Parse(startPage.Property[accessKeyName].ToString()));
                    if (page != null)
                    {
                        result.Add(accessKeyName[accessKeyName.Length - 1].ToString(CultureInfo.InvariantCulture), page.LinkURL);
                        
                    }
                }
                accessKeyName = changeAccessKeyName(i, accessKeyName);
            }
            return result;
        }

        private string changeAccessKeyName(int i, string accessKey)
        {
            accessKey = accessKey.Remove(accessKey.Length - 1);
            accessKey += i.ToString(CultureInfo.InvariantCulture);
            return accessKey;
        }

        /// <summary>
        /// Creates the collection for the main menu, adding the startpage
        /// </summary>
        private PageDataCollection LoadChildren(PageReference pageLink)
        {
            PageDataCollection pages = DataFactory.Instance.GetChildren(pageLink);
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
        protected string GetSep()
        {
            if (_start)
            {
                _start = false;
                return "";
            }
            return "<span>|</span>";
        }
    }
}