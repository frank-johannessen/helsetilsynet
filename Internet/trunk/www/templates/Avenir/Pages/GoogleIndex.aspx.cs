/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer.Core;
using EPiServer;
using EPiServer.Filters;
using System;
using System.Text;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class GoogleIndex : TemplatePage
    {

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Find();
        }

        protected void Find()
        {
            int searchPageTypeID = 399;

            PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
            PropertyCriteria criteria = new PropertyCriteria();

            criteria.Name = "PageTypeID";
            criteria.Type = PropertyDataType.PageType;
            criteria.Condition = CompareCondition.NotEqual;
            criteria.Value = searchPageTypeID.ToString();

            //criteria.Condition = CompareCondition.NotEqual;
            //criteria.Value = "News";
            //criteria.Type = PropertyDataType.Category;
            //criteria.Required = true;
            //criteria.Name = "PageCategory";
            //PropertyCriteria criteria = new PropertyCriteria(); 
            //criteria.IsNull = true; criteria.Name = "WriterName"; 

            var fromPage = (PageReference)CurrentPage["ListingContainer"];
            criterias.Add(criteria);
            PageDataCollection pages = DataFactory.Instance.FindAllPagesWithCriteria(fromPage, criterias, "no", new LanguageSelector("no"));
            //PageDataCollection pages = EPiServer.DataFactory.Instance.FindPagesWithCriteria(PageReference.StartPage, criterias);

            StringBuilder liste = new StringBuilder();
            int i = 0;
            foreach (PageData page in pages)
            {
                i++;
                UrlBuilder ub = new UrlBuilder(page.LinkURL);
                Global.UrlRewriteProvider.ConvertToExternal(
                   ub,
                   page.PageLink,
                   Encoding.UTF8);
                string url = ub.Uri.ToString();
                liste.Append("<a href='" + ResolveUrl("~" + url) + "'>" + page.PageName + "</a><br />");
                //Response.Write("<a href='" + url + "'>" + url + "</a><br />");

                //Response.Write(ResolveUrl(page.LinkURL.ToString() + "<br />"));
                //Response.Write(string.Format("{0} # {1}# {2}<br />",
                //    page.PageTypeID,
                //    page.PageLink.ID,
                //    page.PageName
                //    //page.Property["MetaKeywords"]
                //    ));
            } //page.PageName,  page.PageLink.ID,
            BodyText.Text = "Antall sider: " + i + "<br />" + liste.ToString();
        }
    
    }
}