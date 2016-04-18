/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using System.Xml;
using EPiServer.Core;
using EPiServer.Core.Html;
using EPiServer.Web;
using EPiServer.Filters;
//using EPiServer.Templates;
using EPiServer;
using System.Collections.Generic;
using Avenir;

namespace Templates.Avenir.Pages
{
    /// <summary>
    /// Renders an xml page representing an RSS source feed based on pages in 
    /// an RSS contianer root retrieved from the "RssSource" page property.
    /// </summary>
    public partial class RssFeed : TemplatePage
    {
        //private System.Web.UI.HtmlControls.HtmlMeta Redirect;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Response.CacheControl = "no-cache";
            Response.AddHeader("Pragma", "no-cache");
            Response.Expires = -1;
            string g = Request.QueryString["g"];
            string r = Request.QueryString["r"];
            if (!string.IsNullOrEmpty(r) && !string.IsNullOrEmpty(g))
            {
                Response.ContentType = "text/xml";
                Response.Clear();
                if (IsValue("RssSource"))
                    WriteRssDocument();
                WriteRssDocAvenir(g);
                    //return Avenir.Lib.googleSearch(g);
                Response.End();
            }
            else
            {
                Redirect.Attributes["content"] = "1;url=" + GetRedirect();
            }
        }

        protected string GetRedirect()
        {
            string r = Request.QueryString["r"];
            if (!string.IsNullOrEmpty(r))
                return string.Empty;
            var g = Request.QueryString["g"];
            //return "http://hanshaga-pc:17000//ts/rss/?r=true&g=" + g;
            return "/ts/rss/?r=true&g=" + g;
              
        }

        private void WriteRssDocument()
        {
            XmlDocument doc = new XmlDocument();

            XmlNode outerNode = doc.CreateElement("rss");
            XmlAttribute uriInfo = doc.CreateAttribute("xmlns:dc");
            uriInfo.Value = "http://purl.org/dc/elements/1.1/";
            if (outerNode.Attributes != null) outerNode.Attributes.Append(uriInfo);
            doc.AppendChild(outerNode);

            XmlAttribute versionInfo = doc.CreateAttribute("version");
            versionInfo.Value = "2.0";
            if (outerNode.Attributes != null) outerNode.Attributes.Append(versionInfo);

            XmlNode channel = doc.CreateElement("channel");
            outerNode.AppendChild(channel);

            XmlNode title = doc.CreateElement("title");
            title.InnerText = CurrentPage.PageName;
            channel.AppendChild(title);

            XmlNode link = doc.CreateElement("link");
            if (UrlRewriteProvider.IsFurlEnabled)
            {
                UrlBuilder url = new UrlBuilder(EPiServer.Configuration.Settings.Instance.SiteUrl);
                EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, null, System.Text.UTF8Encoding.UTF8);
                link.InnerText = url.ToString();
            }
            else
            {
                link.InnerText = EPiServer.Configuration.Settings.Instance.SiteUrl.ToString();
            }
            channel.AppendChild(link);

            XmlNode description = doc.CreateElement("description");
            if (CurrentPage != null) description.InnerText = CurrentPage["Description"] as string;
            channel.AppendChild(description);

            PageReference listingContainer = CurrentPage["RssSource"] as PageReference;
            PageDataCollection children = GetChildren(listingContainer);
            FilterForVisitor.Filter(children);
            foreach (PageData page in children)
            {
                XmlNode item = doc.CreateNode(XmlNodeType.Element, "item", null);

                XmlNode itemTitle = doc.CreateElement("title");
                string tittel = string.Empty;
                if (CurrentPage["Heading"] != null)
                {
                    tittel = CurrentPage.Property["Heading"].ToWebString();
                }
                else
                {
                    tittel = CurrentPage.Property["PageName"].ToWebString();
                }
                itemTitle.InnerText = tittel;
                item.AppendChild(itemTitle);

                UrlBuilder url = new UrlBuilder(UriSupport.Combine(EPiServer.Configuration.Settings.Instance.SiteUrl.ToString(), page.LinkURL).ToString());
                XmlNode itemLink = doc.CreateElement("link");
                if (UrlRewriteProvider.IsFurlEnabled)
                {
                    Global.UrlRewriteProvider.ConvertToExternal(url, null, System.Text.Encoding.UTF8);
                    itemLink.InnerText = url.ToString();
                }
                else
                {
                    itemLink.InnerText = url.ToString();

                }
                item.AppendChild(itemLink);

                XmlNode itemDescription = doc.CreateElement("description");
                itemDescription.InnerText = CreatePreviewText(page);
                item.AppendChild(itemDescription);

                XmlNode itemGuid = doc.CreateElement("guid");
                itemGuid.InnerText = url.ToString();
                item.AppendChild(itemGuid);
                
                XmlNode itemPubDate = doc.CreateElement("pubDate");
                itemPubDate.InnerText = page.Changed.ToString("r");
                item.AppendChild(itemPubDate);
                                
                foreach (int category in page.Category)
	            {
                    XmlNode itemCategory = doc.CreateElement("category");
                    itemCategory.InnerText = page.Category.GetCategoryName(category);
                    item.AppendChild(itemCategory);
            	}
                
                channel.AppendChild(item);
            }

            XmlDeclaration xDec = doc.CreateXmlDeclaration("1.0", "ISO-8859-1", null);
            doc.InsertBefore(xDec, doc.DocumentElement);

            doc.Save(Response.OutputStream);
        }

        private string CreatePreviewText(PageData page)
        {   
            if (page.Property["MainIntro"] != null && page.Property["MainIntro"].ToString().Length > 0)
            {
                return page.Property["MainIntro"].ToWebString();
            }
            
            if (page.Property["MainBody"] == null && page.Property["MainBody"].ToString().Length == 0)
            {
                return String.Empty;
            }

            return TextIndexer.StripHtml(page.Property["MainBody"].ToWebString(), 400);
        }

        private void WriteRssDocAvenir(string g)
        {
            XmlDocument doc = new XmlDocument();

            XmlDeclaration xDec = doc.CreateXmlDeclaration("1.0", "ISO-8859-1", null);
            doc.InsertBefore(xDec, doc.DocumentElement);

            XmlNode outerNode = doc.CreateElement("rss");
            XmlAttribute uriInfo = doc.CreateAttribute("xmlns:dc");
            uriInfo.Value = "http://purl.org/dc/elements/1.1/";
            outerNode.Attributes.Append(uriInfo);
            doc.AppendChild(outerNode);

            XmlAttribute versionInfo = doc.CreateAttribute("version");
            versionInfo.Value = "2.0";
            outerNode.Attributes.Append(versionInfo);

            XmlNode channel = doc.CreateElement("channel");
            outerNode.AppendChild(channel);

            XmlNode itemTitle = doc.CreateElement("title");
            string tittel = string.Empty;
            if (CurrentPage["Heading"] != null)
            {
                tittel = CurrentPage.Property["Heading"].ToWebString();
            }
            else
            {
                tittel = CurrentPage.Property["PageName"].ToWebString();
            }
            itemTitle.InnerText = tittel;
            //title.InnerText = CurrentPage.PageName;
            channel.AppendChild(itemTitle);

            XmlNode link = doc.CreateElement("link");
            if (UrlRewriteProvider.IsFurlEnabled)
            {
                UrlBuilder url = new UrlBuilder(EPiServer.Configuration.Settings.Instance.SiteUrl);
                Global.UrlRewriteProvider.ConvertToExternal(url, null, System.Text.UTF8Encoding.UTF8);
                link.InnerText = url.ToString();
            }
            else
            {
                link.InnerText = EPiServer.Configuration.Settings.Instance.SiteUrl.ToString();
            }
            channel.AppendChild(link);

            XmlNode description = doc.CreateElement("description");
            description.InnerText = CurrentPage["Description"] as string;
            channel.AppendChild(description);


            List<ResultElement> pages = Lib.SearchGoogle(g);
            foreach (ResultElement page in pages)

            //PageReference listingContainer = CurrentPage["RssSource"] as PageReference;
            //PageDataCollection children = GetChildren(listingContainer);
            //FilterForVisitor.Filter(children);
            //foreach (PageData page in children)
            {
                XmlNode item = doc.CreateNode(XmlNodeType.Element, "item", null);
                XmlNode Title = doc.CreateElement("title");
                Title.InnerText = Lib.StripHtml(page.Title);
                item.AppendChild(Title);

                //UrlBuilder url = new UrlBuilder(UriSupport.Combine(EPiServer.Configuration.Settings.Instance.SiteUrl.ToString(), page.Url).ToString());
                UrlBuilder url = new UrlBuilder(page.Url.ToString());
                XmlNode itemLink = doc.CreateElement("link");
                if (UrlRewriteProvider.IsFurlEnabled)
                {
                    Global.UrlRewriteProvider.ConvertToExternal(url, null, System.Text.Encoding.UTF8);
                    itemLink.InnerText = url.ToString();
                }
                else
                {
                    itemLink.InnerText = url.ToString();

                }
                item.AppendChild(itemLink);

                XmlNode itemDescription = doc.CreateElement("description");
                itemDescription.InnerText = page.Description;
                item.AppendChild(itemDescription);

                XmlNode itemGuid = doc.CreateElement("guid");
                itemGuid.InnerText = url.ToString();
                item.AppendChild(itemGuid);

                XmlNode itemPubDate = doc.CreateElement("pubDate");
                itemPubDate.InnerText = page.Date;
                item.AppendChild(itemPubDate);

                //foreach (int category in page.Category)
                //{
                //    XmlNode itemCategory = doc.CreateElement("category");
                //    itemCategory.InnerText = page.Category.GetCategoryName(category);
                //    item.AppendChild(itemCategory);
                //}

                channel.AppendChild(item);
            }

            doc.Save(Response.OutputStream);
        }
    
    
    }
}
