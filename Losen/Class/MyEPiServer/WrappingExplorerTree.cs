using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;


namespace development.Class.MyEPiServer
{
	/// <summary>
	/// Summary description for WrappingExplorerTree.
	/// </summary>
	public class WrappingExplorerTree : ExplorerTree 
	{
		protected int _WIDTH=0;
		public WrappingExplorerTree() : base()
		{
			// Make sure the tree will load your own treebranch 
			// page, instead of the default
			BranchUrl = Global.EPConfig.RootDir + 
				"templates/ExplorerTreeBranch.aspx";

		}

		public int WIDTH
		{
			get{
				return _WIDTH;
			}
			set{
				_WIDTH = value;
			}		
		}

		protected override void RenderPageLink(PageTreeReader reader, bool isSelected, HtmlTextWriter output)
		{
			int numberPages=reader.Pages.Count;
			HyperLink htmlLink = new HyperLink();
			htmlLink.ID = "page#" + reader.Page.PageLink.ToString().Replace("/templates/","") + "#link";
			htmlLink.Text = reader.Page.Property["PageName"].ToWebString() + " (" + ((DateTime)reader.Page.Property["PageChanged"].Value).ToString("dd.MM.yy") + ")";
			htmlLink.Attributes.Add("Action","window.location.href = '"+reader.Page.LinkURL +"'");
			htmlLink.Attributes.Add("PageLink",reader.Page.PageLink.ID.ToString());
			if(reader.Page.PageLink.ID==CurrentPage.PageLink.ID)
				htmlLink.Attributes.Add("class","ExplorerTreeSelectedLink");
			else
			{
				htmlLink.Attributes.Add("class","ExplorerTreeLink");
				
			}
			htmlLink.Attributes.Add("href",reader.Page.LinkURL);
			if (htmlLink.Text.Length > WIDTH)
			{
				int repeats=htmlLink.Text.Length/WIDTH;
				for(int i = repeats; i>0;i--)
				{
					int counter=(WIDTH*i);
					while(htmlLink.Text[counter]!=' ')
					{
						counter--;
						if(counter==((WIDTH*(i-1))+1))
						{
							counter=(WIDTH*i);
							break;
						}
					}
					if(reader.Pages[numberPages-1].PageLink.ID == reader.Page.PageLink.ID)
						htmlLink.Text =htmlLink.Text.Insert(counter,"<br style=\"LINE-HEIGHT: 0px\"/> <img border=\"0\" src=\"/images/blank_explorertree.gif\" align=\"absmiddle\" />&nbsp;");	
					else
						htmlLink.Text =htmlLink.Text.Insert(counter,"<br style=\"LINE-HEIGHT: 0px\"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");	
				}
			}
			htmlLink.RenderControl(output);
		}
	}
}
