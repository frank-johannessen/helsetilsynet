/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using System.Text;
using EPiServer;
using EPiServer.Web.WebControls;
using EPiServer.Core;


namespace Avenir.Templates.Units.Static
{
    /// <summary>
    /// Lists the pages in the submenu. The root page for the submenu is 
    /// the current page in the main menu.
    /// </summary>
    public partial class SubMenu : UserControlBase
    {
        private MenuList _menuList;
        //private string _expand;
        private PageReference _menuRoot;
        //private int _maxOfLevels;
        private bool _autoExpanded;

        /// <summary>
        /// Gets or sets the data source for this control
        /// </summary>
        public MenuList MenuList
        {
            get { return _menuList; }
            set { _menuList = value; }
        }

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            if (MenuList == null)
            {
                return;
            }
            NumberOfLevels = 2;
            //MaxOfLevels = 4;

            MenuRoot =  MenuList.OpenTopPage;
            //Menu.PageLink = MenuList.OpenTopPage;
            //Menu.DataBind();
            //if (CurrentPage.ParentLink == new PageReference("10370")) //hh Vis brødsmuler hvis vi er utenfor hovedmeny
            //{
            //    MenuRoot = null;
            //}
        }
       protected PageReference MenuRoot
        {
            get { return _menuRoot; }
            set { _menuRoot = value; }
        }

        //public int MaxOfLevels
        //{
        //    get { return _maxOfLevels; }
        //    set { _maxOfLevels = value; }
        //}

        private int _numberOfLevels;
        /// <summary>
        /// Specifies the number of levels to show in the tree
        /// </summary>
        public int NumberOfLevels
        {
            get { return _numberOfLevels; }
            set { _numberOfLevels = value; }
        }
	
        /// <summary>
        /// return children on selected page
        /// Filter: FilterForVisitor, PageVisibleInMenu        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        protected PageDataCollection getChildren(PageData page)
        {
            PageDataCollection pdc = DataFactory.Instance.GetChildren(page.PageLink);
            pdc = EPiServer.Filters.FilterForVisitor.Filter(pdc);

            EPiServer.Filters.FilterRemoveNullValues filter = new EPiServer.Filters.FilterRemoveNullValues("PageVisibleInMenu");

            filter.Filter(pdc);
            return pdc;
        }

        protected bool HasVisibleChildren(PageData page)
        {
            PageDataCollection pdc = getChildren(page);
            return pdc.Count > 0;
        }

        //private int getLevel(PageData pd,  PageReference root )
        //{
        //    PageReference _parentRef;
        //    int level = 1;
        //    if (root == null)
        //        root = PageReference.StartPage;
        //    while ((_parentRef = pd.ParentLink) != root)
        //    {
        //        level++;
        //        pd = this.GetPage(_parentRef);
        //    }
        //    return level;
        //}

        protected string GetLeftMenu()
        {
            // finn roten til menyen, dvs der man skal begynne å liste ut.
            if (MenuRoot == null)
                return string.Empty;

            if (MenuRoot.ID.Equals(CurrentPage.PageLink.ID))
                return BuildSingleLevelMenu(CurrentPage);

            PageData _page;
            PageReference _pageRef;
            PageDataCollection _parentTree = new PageDataCollection();

            _page = CurrentPage;
            _parentTree.Insert(0, _page);

            try
            {
                while ((_pageRef = _page.ParentLink) != MenuRoot)   // && _pageRef != PageReference.StartPage)
                {
                    _page = GetPage(_pageRef);
                    //string name = _page.PageName;
                    _parentTree.Insert(0, _page);
                }
                _parentTree.Insert(0, GetPage(MenuRoot));

            }
            catch (Exception) // CurrentPage does not exists in menu container
            {
                return string.Empty;
            }

            // Build menu
            if (_parentTree.Count == 1)
            {
                return BuildSingleLevelMenu(CurrentPage);
            }
            return BuildMenuFrom(_parentTree[0], _parentTree);


        }
        /// <summary>
        /// Build a simple menu
        /// ekspandere nested level nivå
        /// </summary>
        /// <param name="menuRoot"></param>
        /// <returns></returns>
        private string BuildSingleLevelMenu(PageData menuRoot)
        {
            PropertyNumber expanded = menuRoot.Property.Get("MenuExpanded") as PropertyNumber;
            _autoExpanded = (expanded != null ? expanded.Number > 0 : false);
            StringBuilder menuBuilder = new StringBuilder();
            PageDataCollection menuChildren = getChildren(menuRoot);
            if (menuChildren.Count > 0)
            {
                // Header
                //menuBuilder.Append("<div class=\"mainMenuSubLevels\">\n");
                menuBuilder.Append("<ul class=\"level2\">\n");
                //menuBuilder.Append("<h2>" + menuRoot.PageName + "</h2>\n");
                int i = 0;
                foreach (PageData child in menuChildren)
                {
                    if (Lib.DummyPage(child)) continue;
                    i++;

                    // lagt til selected 8.3.2010
                    //bool selected = isCurrentPage(child.PageLink.ID);
                    string s = "<li>";
                    if (i == 6)
                    //{
                        //if (selected)
                        //    s = "<li class=\"selected noRightBorder\">";
                        //else
                            s = "<li class=\"noRightBorder\">";
                    //}
                    //else
                    //    if (selected)
                    //        s = "<li class=\"selected\">";


                    menuBuilder.Append(s + "</span><a  href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                            child.PageName + "</a></li>\n");
                }

                // Footer
                menuBuilder.Append("</ul>\n");
                //menuBuilder.Append("</div></div>\n");
            }
            else
            {
                // Dummy Space
                menuBuilder.Append(HtmlSpace);
            }

            return menuBuilder.ToString();

        }

        private string BuildMenuFrom(PageData menuRoot, PageDataCollection parentTree)
        {
            PropertyNumber expanded = menuRoot.Property.Get("MenuExpanded") as PropertyNumber;
            _autoExpanded = (expanded != null ? expanded.Number > 0 : false);
            StringBuilder menuBuilder = new StringBuilder();
            menuBuilder.Append(BuildLevelFrom(menuRoot, parentTree));
            return menuBuilder.ToString();
        }

        private bool IsCurrentPage(int pageId)
        {
            return CurrentPage.PageLink.ID.Equals(pageId);
        }

        //private static string EmptyLine = "<li>&nbsp;</li>";
        private static string HtmlSpace = "&nbsp;";

        /// <summary>
        /// Build a completed menu
        /// Expanded level 2.
        /// Expand level 3 if active
        /// </summary>
        /// <param name="root"></param>
        /// <param name="parentTree"></param>
        /// <returns></returns>
        private string BuildLevelFrom(PageData root, PageDataCollection parentTree)
        {
            PageDataCollection children = getChildren(root);
            StringBuilder menuBuilder = new StringBuilder();
            menuBuilder.Append("<ul class=\"level2\">\n");
            PageData subChild = null; //peker på selected hvis vi skal lage subnivå
            int i = 0;
            foreach (PageData child in children)
            {
                if (Lib.DummyPage(child)) continue;
                i++;
                string s = "<li>";
                string s2 = "";
                if (i == 6)
                {
                    s = "<li class=\"noRightBorder\">";
                    s2 = " noRightBorder";
                }
                if (parentTree.Find(child.PageLink) != -1) // found
                {
                    PageDataCollection grandChildren = getChildren(child);
                    if (IsCurrentPage(child.PageLink.ID))
                    {
                        menuBuilder.Append("<li class=\"selected" + s2 + "\"><a  href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                                   child.PageName + "</span></a>\n");
                        if (grandChildren.Count > 0)
                            subChild = child;
                        //    menuBuilder.Append(buildSubLevelFrom(child));
                        menuBuilder.Append("</li>\n");
                    }
                    else if (grandChildren.Count > 0)
                    {
                        menuBuilder.Append("<li class=\"selected" + s2 + "\">");
                        menuBuilder.Append("<a  href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                        child.PageName + "</span></a>\n");
                        subChild = child;
                        menuBuilder.Append("</li>\n");
                    }
                    else
                    {
                        menuBuilder.Append(s + "<a href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                           child.PageName + "</span></a>\n");
                    }
                }
                else
                {
                    menuBuilder.Append(s + "<a href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                       child.PageName + "</span></a>\n");
                }
            }
             menuBuilder.Append("</ul>\n");
             if (subChild != null)
                 menuBuilder.Append(BuildMenu3(subChild, parentTree));

            return menuBuilder.ToString();
        }


        private string BuildMenu3(PageData menuRoot, PageDataCollection parentTree)
        {
            PropertyNumber expanded = menuRoot.Property.Get("MenuExpanded") as PropertyNumber;
            parentTree.Insert(0, menuRoot);
            StringBuilder menuBuilder = new StringBuilder();
            menuBuilder.Append(BuildLevel3(menuRoot, parentTree));
            return menuBuilder.ToString();
        }


        private string BuildLevel3(PageData root, PageDataCollection parentTree)
        {
            PageDataCollection children = getChildren(root);
            StringBuilder menuBuilder = new StringBuilder();
            menuBuilder.Append("<ul class=\"level3\">\n");
            PageData subChild = null; //peker på selected hvis vi skal lage subnivå

            foreach (PageData child in children)
            {
                if (Lib.DummyPage(child)) continue;
                if (parentTree.Find(child.PageLink) != -1) // found
                {
                    PageDataCollection grandChildren = getChildren(child);
                    if (grandChildren.Count > 0)
                        subChild = child;
                    if (IsCurrentPage(child.PageLink.ID) || grandChildren.Count > 0)
                    {
                        menuBuilder.Append("<li class=\"selected\"><a  href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                                   child.PageName + "</span></a>\n");
                        //if (grandChildren.Count > 0)
                        //    subChild = child;

                        //    menuBuilder.Append(buildSubLevelFrom(child));
                        menuBuilder.Append("</li>\n");
                    }
                    else
                    {
                        menuBuilder.Append("<li><a href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                           child.PageName + "</span></a>\n");
                    }
                }
                else
                {
                    menuBuilder.Append("<li><a href=\"" + child.LinkURL + "\" title=\"" + child.PageName + "\"><span>" +
                                       child.PageName + "</span></a>\n");
                }
            }
            menuBuilder.Append("</ul>\n");
            if (subChild != null)
                menuBuilder.Append(BuildSubLevelFrom(subChild));

            return menuBuilder.ToString();
        }


        /// <summary>
        /// build a simple menu
        /// </summary>
        /// <param name="root"></param>
        /// <returns></returns>
        private string BuildSubLevelFrom(PageData root)
        {
            PageDataCollection children = getChildren(root);

            if (children.Count < 1)
                return string.Empty;

            StringBuilder menuBuilder = new StringBuilder();
            menuBuilder.Append("<ul class=\"level4\">");
            foreach (PageData child in children)
            {
                if (Lib.DummyPage(child)) continue;
                if (IsCurrentPage( child.PageLink.ID))
                    menuBuilder.Append("<li class=\"selected\">");                        
                else
                    menuBuilder.Append("<li>");

                menuBuilder.Append("<a href=\"" + child.LinkURL + "\" title=\"" +
                    child.PageName + "\"><span>" + child.PageName + "</span></a>\n");

                menuBuilder.Append("</li>\n");

            }
            menuBuilder.Append("</ul>\n");
            return menuBuilder.ToString();
        }

        protected string GetBread()
        {
            //if (CurrentPage.ParentLink == new PageReference("10370")) //Vis brødsmuler hvis vi er utenfor hovedmeny
            //{
            //    //this.SubMenu.Visible = false;
            //    this.BreadCrumbs.Visible = true;
            //    return " hasBreadCrumbs";
            //}
            //if (CurrentPage.PageTypeID == 83 || CurrentPage.PageTypeID == 100 || CurrentPage.PageTypeID == 93)  //skal vise smuler hvis vi står på artikkel, tilsynsrapport eller lovside 
            if (CurrentPage.PageTypeID == int.Parse(Config.PageTypeIdArtikkel.GetConfigValue())
                || CurrentPage.PageTypeID == int.Parse(Config.PageTypeIdBoxListing.GetConfigValue())
                || CurrentPage.PageTypeID == int.Parse(Config.PageTypeIdTilsynsrapport.GetConfigValue())
                || CurrentPage.PageTypeID == int.Parse(Config.PageTypeIdLovside.GetConfigValue()))  //skal vise smuler hvis vi står på artikkel, tilsynsrapport eller lovside 
            {
                BreadCrumbs.Visible = true;
                return " hasBreadCrumbs";
            }
            return "";
        }


    }
}