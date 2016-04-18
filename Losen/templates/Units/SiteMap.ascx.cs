/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using EPiServer.Core;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.templates.Units
{	
	/// <summary>
	///		Summary description for SiteMap.
	/// </summary>
	public abstract class SiteMap : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.PageList level1;
		protected EPiServer.WebControls.PageList level2;
		protected string items = "";
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			EPiServer.Filters.FilterCompareTo filterCompareTo = new EPiServer.Filters.FilterCompareTo("PageVisibleInMenu", "True");
			level1.Filter += new EPiServer.WebControls.FilterEventHandler( filterCompareTo.Filter );
			DataBind();
		}

		public string MakeItemList(string PageName, string PageUrl, bool PageVisibleInMenu, string DummyPage)
		{			
			if (PageVisibleInMenu && DummyPage != "True")
			{
				if (items == "")
					items += "<div class=\"cellMargin\"><a href=\"" + PageUrl + "\">" + PageName + "</a></div>";
				else
					items += ";<div class=\"cellMargin\"><a href=\"" + PageUrl + "\">" + PageName + "</a></div>";
			}
			return "";
		}


		public string MakeTable()
		{
			string temp = "";
			string Cell1 = "";
			string Cell2 = "";
			string Cell3 = "";

			if (items != "")
			{
				string [] ArrayList = items.Split(';');
				int CellSplit;
				int ALength = ArrayList.Length;
				int Count = 0;
				int Differ = 0;

				foreach (string SingelItem in ArrayList)
				{
                    CellSplit = ALength % 3;
					if(CellSplit == 0)
					{
						// likt fordelt på tre celler
						Count += 1;
						if (Count <= (ALength / 3) && Differ != 3)
						{
							// celle 1
							if (Count == 2 && Differ == 2)
								Differ = 3;
							Cell1 += SingelItem;
						}
						else if (Count > (ALength - (ALength / 3)))
						{
							// celle 3
							Cell3 += SingelItem;
						}
						else
						{
							// celle 2
							Cell2 += SingelItem;
						}

					}
					else
					{
						if (Differ == 0)
						{
							Cell1 += SingelItem;
							ALength = ALength - 1;
							Differ = 1;
						}
						else
						{
							if (ArrayList.Length == 2)
								Cell2 += SingelItem;
							else
								Cell1 += SingelItem;

							ALength = ALength - 1;
							Differ = 2;
						}
					}
				}
				items = "";
			}
			temp += "<td width=190 valign=top>" + Cell1 + "</td>";
			temp += "<td width=190 valign=top>" + Cell2 + "</td>";
			temp += "<td width=190 valign=top>" + Cell3 + "</td>";
			return temp;
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
