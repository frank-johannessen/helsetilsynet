/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPostf
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.WebControls;
using EPiServer.Core;
using EPiServer.Core.Html;
using System.Collections.Generic;
using EPiServer.DataAbstraction;

namespace Avenir
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
    public partial class _default : EPiCode.WebParts.TemplatePageWebPartBase  //TemplatePage
	{

		protected System.Web.UI.WebControls.Repeater	news1Repeater;
		protected System.Web.UI.WebControls.Repeater	news2Repeater;
		protected System.Web.UI.WebControls.Repeater news3Repeater;
		protected EPiServer.Web.WebControls.Property		MainBody;		
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;



        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
                DataBind();
            ChangedPages.Visible = true;
        }




        public string GetTeaser(int DisplayType)
        {
            string temp = "";
            int count = 0;
            string Container = "";

            switch (DisplayType)
            {
                case 1:
                    Container = ((EPiServer.PageBase)Page).CurrentPage.Property["PageContainerFrontpage1"].ToString();
                    break;
                case 2:
                    Container = ((EPiServer.PageBase)Page).CurrentPage.Property["PageContainerFrontpage2"].ToString();
                    break;
                case 3:
                    Container = ((EPiServer.PageBase)Page).CurrentPage.Property["InfocusList"].ToString();
                    break;
                default:
                    break;
            }

            if (Container != "")
            {
                string[] ArrayList = Container.Split(',');

                if (ArrayList.Length > 0)
                {
                    PageData oPage;
                    foreach (string id in ArrayList)
                    {
                        oPage = DataFactory.Instance.GetPage(new PageReference(id.Trim()));

                        if (DisplayType == 1)
                        {
                            temp += "<div class=\"teaser\"><div class=\"title\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a></div>";
                            temp += "<div><span class=\"leadTextLink\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["MetaDescription"] + "</a></span>";
                            temp += "<nobr> <span class=\"teaserDate\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Created.ToString("dd.MM.yyyy") + "</a></span> <a href=\"" + oPage.LinkURL + "\"><img src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" alt=\"\" class=\"arrow-right\"></a></nobr></div></div>";
                        }
                        else if (DisplayType == 2)
                        {
                            count += 1;
                            if (count == 1)
                                temp += "<tr>";

                            temp += "<td width=\"50%\" valign=\"top\"><div class=\"teaser\">";
                            temp += "<div class=\"subTitle\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a></div>";
                            temp += "<div><span class=\"leadTextLink\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["MetaDescription"] + "</a></span>";
                            temp += "<nobr> <span class=\"teaserDate\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Created.ToString("dd.MM.yyyy") + "</a></span> <a href=\"" + oPage.LinkURL + "\"><img src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" alt=\"\" class=\"arrow-right\"></a></nobr>";
                            temp += "</div></div></td>";

                            //if (ArrayList.Length == 1)
                            //	temp += "<td width=\"50%\" valign=\"top\"><div class=\"teaser\">&nbsp;</td>";

                            if (count == 2)
                            {
                                temp += "</tr>";
                                count = 0;
                            }
                        }
                        else if (DisplayType == 3)
                        {//<a href=\"" + oPage.LinkURL + "\"></a>
                            temp += "<h3><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a> </h3><p>";
                            if (oPage.Property["MainIntro"] != null && oPage.Property["MainIntro"].ToString().Length > 0)
                            {
                                string s = StripPreviewText(oPage.Property["MainIntro"].ToWebString(), 130); 
                                temp += TextIndexer.StripHtml(s, 130);
                            }
                            temp += "<span class=\"date\">" + oPage.Created.ToString("d") + "</span></p>";
                        }
                    }

                    if (DisplayType == 2)
                    {
                        temp = "<table width=\"100%\" bordercolor=\"yellow\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + temp + "</table>";
                    }

                }
            }
            return temp;
        }




        private static string StripPreviewText(string previewText, int maxLength)
        {
            if (previewText.Length <= maxLength)
            {
                return previewText;
            }
            previewText = previewText.Substring(0, maxLength);
            // The maximum number of characters to cut from the end of the string.
            int maxCharCut = (previewText.Length > 15 ? 15 : previewText.Length - 1);
            int previousWord = previewText.LastIndexOfAny(new char[] { ' ', '.', ',', '!', '?' }, previewText.Length - 1, maxCharCut);
            if (previousWord >= 0)
            {
                previewText = previewText.Substring(0, previousWord);
            }
            return previewText + " ...";
        }
        protected string getNewsArchive()
        {
            if (CurrentPage.Property["NewsArchive"] == null || CurrentPage.Property["NewsArchive"].ToString() == string.Empty)
                return "#";
            PageReference pr = new PageReference(CurrentPage.Property["NewsArchive"].ToString());
            PageData pd = DataFactory.Instance.GetPage(pr);
            return pd.LinkURL;
        }

        protected string getLastPubPage()
        {
            if (CurrentPage.Property["LastPubPage"] == null || CurrentPage.Property["LastPubPage"].ToString() == string.Empty)
                return "#";
            PageReference pr = new PageReference(CurrentPage.Property["LastPubPage"].ToString());
            PageData pd = DataFactory.Instance.GetPage(pr);
            return pd.LinkURL;
        }

		#region Web Form Designer generated code
        //override protected void OnInit(EventArgs e)
        //{
        //    //
        //    // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //    //
        //    InitializeComponent();
        //    base.OnInit(e);
			
        //}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
        //private void InitializeComponent()
        //{    
        //    this.Load += new System.EventHandler(this.Page_Load);

        //}
		#endregion
	}
}
