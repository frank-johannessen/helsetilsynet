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
using EPiServer.Filters;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.templates.UserControls
{
	/// <summary>
	///		Summary description for AlphanumericListing.
	/// </summary>
	public abstract class AlphanumericListing : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;
		protected string lettergroup = "";
		protected string KeyWordList = "";

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				AddLetter("A");
				AddLetter("B");
				AddLetter("C");
				AddLetter("D");
				AddLetter("E");
				AddLetter("F");

				this.DataBind();
			}
		}

		protected void ChangeLetters(object sender, System.EventArgs e)
		{
			LinkButton activator = (LinkButton)sender;			
			switch(activator.ID)
			{
				case "Alphanumeric1":
					AddLetter("A");
					AddLetter("B");
					AddLetter("C");
					AddLetter("D");
					AddLetter("E");
					AddLetter("F");
					break;
				case "Alphanumeric2":
					AddLetter("G");
					AddLetter("H");
					AddLetter("I");
					AddLetter("J");
					AddLetter("K");
					AddLetter("L");
					break;
				case "Alphanumeric3":
					AddLetter("M");
					AddLetter("N");
					AddLetter("O");
					AddLetter("P");
					AddLetter("Q");
					AddLetter("R");
					break;
				case "Alphanumeric4":
					AddLetter("S");
					AddLetter("T");
					AddLetter("U");
					AddLetter("V");
					AddLetter("W");
					AddLetter("X");					
					break;
				case "Alphanumeric5":
					AddLetter("Y");
					AddLetter("Z");
					AddLetter("Æ");
					AddLetter("Ø");
					AddLetter("Å");

					break;
				default:
					break;
			}
			DataBind();
		}

		public string FilterName(string PageLink, string wordlist) 
		{
			string [] list = wordlist.Split(',');
			
			if (list.Length > 0)
			{
				for (int i=0; i<list.Length; i++)
				{
					KeyWordList += list[i].Trim() + "," + PageLink + "+";
				}
			}
			return "";
		}


		public string GetKeywords() 
		{
			string table = "";
			string x = lettergroup;
			string [] letters = x.Split(',');
			string [] KeywordList = KeyWordList.Split('+');
			Array.Sort(KeywordList);
			string temp;

			if (KeywordList.Length > 0)
			{
				foreach(string L in letters) 
				{
					foreach(string K in KeywordList) 
					{
						string [] Keyword = K.Split(',');
						temp = Keyword[0].Trim();
						if (temp.Length>0 && temp.Substring(0,1).ToLower() == L.ToLower()) 
						{
							table += "<tr><td>";
							table += "<a href=\"" + Keyword[1] + "\">" + temp + "</a><br>";
							table += "</td></tr>";
						}
					}
				}
			}
			return table;
		}



		private void AddLetter(string letter)
		{
			lettergroup += letter + ",";

			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.StringCondition = StringCompareMethod.StartsWith;
			criteria.Type = PropertyDataType.String;
			criteria.Value = letter;
			criteria.Name = "keyword";

			EPiServer.PropertyCriteria criterialist = new PropertyCriteria();
			criterialist.StringCondition = StringCompareMethod.Contained;
			criterialist.Type = PropertyDataType.String;
			criterialist.Value = "," + letter;
			criterialist.Name = "keyword";

			EPiServer.PropertyCriteria criterialistWithSpace = new PropertyCriteria();
			criterialistWithSpace.StringCondition = StringCompareMethod.Contained;
			criterialistWithSpace.Type = PropertyDataType.String;
			criterialistWithSpace.Value = ", " + letter;
			criterialistWithSpace.Name = "keyword";

			PropertySearchControl.Criterias.Add(criteria);
			PropertySearchControl.Criterias.Add(criterialist);
			PropertySearchControl.Criterias.Add(criterialistWithSpace);
			
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
