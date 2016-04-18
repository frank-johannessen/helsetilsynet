/*
Copyright © 1997-2002 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using System;
using EPiServer.Core;

namespace Avenir.Templates.Pages
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
    public partial class LovListe : EPiCode.WebParts.TemplatePageWebPartBase // TemplatePage
	{
		protected System.Web.UI.WebControls.Label Label1;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			DataBind();
		}

        protected string GetMenu()
        {
            PageData pd = CurrentPage;
            PageReference pr = pd.ParentLink;
            PageDataCollection pdc = DataFactory.Instance.GetChildren(pr);
            string s = string.Empty;
            string c = string.Empty;
            foreach (PageData p in pdc)
            {
                if (p.PageGuid == pd.PageGuid) c = "class=\"selected\"";
                s += "<li " + c + "><a href=\"" + p.LinkURL + "\">" +  p.PageName + "</a></li>";
                c = string.Empty;
            }
            return s;
        }

        protected string GetLaws()
        {
            PageData pd = CurrentPage;
            PageReference pr = pd.PageLink;
            PageDataCollection pdc = DataFactory.Instance.GetChildren(pr);
            string s = string.Empty;
            bool right = true;
            foreach (PageData p in pdc)
            {
                string tip;
                string lovlink = GetLovlink(p,out tip);
                if (right)
                    s += "<tr><td><div class=\"leftCol\">";
                else
                    s += "<td><div>";
                s += "<h3 class=\"detailTrigger\">" + Lib.GetLink(p,tip) + p.PageName;
                s += "</h3>" + lovlink + "</p>";
                s += GetDetails(p);
                s += "</div></td>";
                if (!right) s += "</tr>";
                right = !right;
            }
            if (right) s += "</tr>";
            return s;
        }

        private string GetDetails(PageData p)
        {
            string s = "<div class=\"extendedInfoContent\">";
            if (p.Property["Forskrifter"] != null && p.Property["Forskrifter"].ToString() != string.Empty)
            {
                s += "<div class=\"extendedInfoItemContent\"><h4>Forskrifter</h4>";
                s += p.Property["Forskrifter"]+"</div>";
            }
            if (p.Property["Rundskriv"] != null && p.Property["Rundskriv"].ToString() != string.Empty)
            {
                s += "<div class=\"extendedInfoItemContent\"><h4>Rundskriv</h4>";
                s += p.Property["Rundskriv"] + "</div>";
            }
            if (p.Property["Veiledninger"] != null && p.Property["Veiledninger"].ToString() != string.Empty)
            {
                s += "<div class=\"extendedInfoItemContent\"><h4>Veiledninger</h4>";
                s += p.Property["Veiledninger"] + "</div>";
            }
            if (p.Property["Brev"] != null && p.Property["Brev"].ToString() != string.Empty)
            {
                s += "<div class=\"extendedInfoItemContent\"><h4>Brev</h4>";
                s += p.Property["Brev"] + "</div>";
            }
            return s + "</div>";
        }

        protected string GetLovlink(PageData p, out string rest)
        {
            string s = string.Empty;
            rest = string.Empty;
            if (p.Property["LovLink"] != null && p.Property["LovLink"].ToString() != string.Empty)
                s = "<p>Les hele loven på <a href=\""
                    + p.Property["LovLink"] + "\" target=_blank>Lovdata</a>";
            if (p.Property["MainBody"] != null && p.Property["MainBody"].ToString() != string.Empty)
            { 
                string l = p.Property["MainBody"].ToString();
                int pos = l.ToUpper().IndexOf("<A");
                if (pos > -1)
                {
                    int pos2 = l.IndexOf('>',pos);
                    s = l.Substring(pos, pos2 - pos);
                    s = "<p>Les hele loven på "
                        + s + ">Lovdata</a>";
                    pos = l.IndexOf("</a>",pos2);
                    if (pos > 0)
                        rest =Lib.StripHtml(l.Substring(pos));
                }
            }

            return s;
        }

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
