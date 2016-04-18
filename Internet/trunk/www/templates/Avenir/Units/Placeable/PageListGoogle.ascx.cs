using System;
using EPiServer.Core;
using EPiServer;

namespace Avenir.Templates.Units.Placeable
{
    public partial class PageListGoogle : UserControlBase
    {
        private bool _showListDate;
        private bool _showListMeta;
        private bool _showListIntro;
        private bool _extLinkList;
        private int _previewLength;

        public int PreviewTextLength
        {
            get; set;
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentPage.Property["ShowListDate"] != null && CurrentPage.Property["ShowListDate"].ToString() == "True")
            {
                _showListDate = true;
                //this.PageList.DateProperty = "PageStartPublish";
            }
            if (CurrentPage.Property["ShowListMeta"] != null && CurrentPage.Property["ShowListMeta"].ToString() == "True")
            {
                _showListMeta = true;
                //this.PageList.ShowMetadesc = true;
            }
            if (CurrentPage.Property["ShowListIntro"] != null && CurrentPage.Property["ShowListIntro"].ToString() == "True")
            {
                _showListIntro = true;
                //this.PageList.ShowIntro = true;
            }
            if (CurrentPage.Property["ExtLinkList"] != null && CurrentPage.Property["ExtLinkList"].ToString() == "True")
            {
                _extLinkList = true;
                //this.PageList.ExtLinkList = true;
            }
            _previewLength = 200;
            if (CurrentPage.Property["PreviewTextLength"] != null && CurrentPage.Property["PreviewTextLength"].ToString() != string.Empty)
            {
                _previewLength = int.Parse(CurrentPage.Property["PreviewTextLength"].ToString());
            }
            //this.PageList.PreviewTextLength = previewLength;

        }

        protected string GetGoogleList()
        {
            string g = Request.QueryString["g"]; //lage liste fra query-string hvis inngitt
            if (!string.IsNullOrEmpty(g))
                return Lib.GoogleSearch(g);
            if (CurrentPage.Property["GoogleList"] != null && CurrentPage.Property["GoogleList"].ToString() != string.Empty)
                return Lib.PageListSearch(CurrentPage.Property["GoogleList"].ToString(), _showListDate, _showListMeta, _showListIntro, _extLinkList, _previewLength);
            return string.Empty;
        }

        protected string GetEpiList()
        {
            if (CurrentPage.Property["MainListRoot"] != null && CurrentPage.Property["MainListRoot"].ToString() != string.Empty)
            {
                PageReference pr = PageReference.Parse(CurrentPage.Property["MainListRoot"].ToString());
                return Lib.PageListSearch(pr, _showListDate, _showListMeta, _showListIntro, _extLinkList, _previewLength);
            }
            return string.Empty;
        }

        //private string Url(string s)
        //{
        //    string ny = Server.UrlEncode(s);
        //    return ny.Replace("%3a", ":");
        //}


    }
}