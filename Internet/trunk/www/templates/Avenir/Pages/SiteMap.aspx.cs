/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer.Core;
using EPiServer;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class SiteMap : TemplatePage
    {
        private PageReference _indexRoot;
        private PageReference _indexTop;

		/// <summary>
		/// Gets the page used as the root for the site map
		/// </summary>
		/// <remarks>If the IndexRoot page property is not set the start page will be used instead</remarks>
        public PageReference IndexRoot
        {
            get 
            { 
                if(PageReference.IsNullOrEmpty(_indexRoot))
                {
					_indexRoot = CurrentPage["IndexRoot"] as PageReference ?? PageReference.StartPage;
                }
                return _indexRoot;
            }
        }

        public PageReference IndexTop
        {
            get
            {
                if (PageReference.IsNullOrEmpty(_indexTop))
                {
                    _indexRoot = CurrentPage["IndexTop"] as PageReference;
                }
                return _indexRoot;
            }
        }

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            if (CurrentPage["IndexRoot"] == null)
                Topp.Visible = false;
            Master.NoMenu(); //make menu invisible - needs <%@ MasterType VirtualPath=
            SiteMapTree.DataBind();
        }
    }
}