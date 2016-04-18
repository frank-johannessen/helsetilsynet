using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using EPiServer.WebControls;
using EPiServer.Core;
using EPiServer.Personalization;

namespace development
{

	public class sitemap : Control
	{

		private String _rootpagelink = null;
		private String _levels = null;
		public int wrapPoint = 3;

		public String rootpagelink 
		{
			get { return _rootpagelink; }
			set { _rootpagelink = value; }
		}

		public String levels 
		{
			get { return _levels; }
			set { _levels = value; }
		}

		protected override void Render(HtmlTextWriter output) 
		{			
			DataBind();
			try 
			{
				generatesitemap(output,new EPiServer.Core.PageReference(rootpagelink),0);
			}
			catch (Exception e)
			{
				output.Write(e.ToString());
			}
		}

		public string alert(string msg) 
		{
			return "<script>alert('" + msg + "')</script>";
		}

		private void generatesitemap(HtmlTextWriter output, EPiServer.Core.PageReference pageLink, int level)
		{

			// get pagedata of rootpage
			IPageSource thisPage = (IPageSource)Page; 
			EPiServer.Core.PageDataCollection PageList = thisPage.GetChildren(pageLink);			
			EPiServer.Core.PageDataCollection PageListNew = new PageDataCollection();				
			
			// transfer visible sectionpages into new pagecollection
			for(int x=0; x<PageList.Count; x++) if (PageList[x].VisibleInMenu== true) PageListNew.Add(PageList[x]);		

			// fetch data into pagedata array with subpages
			PageData[][] amap = new PageData[PageListNew.Count][];
			int maxcount=50;
			for(int x=0; x<amap.Length; x++) 
			{		
				EPiServer.Core.PageDataCollection SubList = thisPage.GetChildren(PageListNew[x].PageLink);	
				EPiServer.Core.PageDataCollection SubListNew = new PageDataCollection();
				// transfer visible subpages into new pagecollection
				for(int i=0; i<SubList.Count; i++) if (SubList[i].VisibleInMenu== true) SubListNew.Add(SubList[i]);	

				amap[x] = new PageData[SubListNew.Count]; 
				for(int y=0; y<amap[x].Length; y++) 
				{
					amap[x][y] = SubListNew[y]; 
				}				
			}
			
			// init variables
			int cols = 3;
			int wraps = 0;
			int z = 0;
			int margins = 2;
			int loopsafe = 100;
			int loops = 0;
			int empty = 0;


			// loop trough array and generate sitemap
			output.Write("<table cellpadding=0 cellspacing=0 border=0 width=600 class=sitemap>");
			while (z<PageListNew.Count) 
			{
				// quit while loop if something goes wrong
				loops++; if (loops>loopsafe) break;
				for(int x=0; x<maxcount; x++) 
				{
					//write sectionpages
					if (x==0) 
					{						 
						output.Write("<tr>");					
						output.Write("<td width=15 class=lvl1><img src=/images/pxl.gif alt=\"\" width=15 height=1></td>");

						// write sectionpages 
						for(z=wraps; z<wraps+cols; z++) 
						{
							if (z<PageListNew.Count) 
							{
								output.Write("<td class=lvl1><a href=" + PageListNew[z].LinkURL + ">" + PageListNew[z].PageName + "</a></td>");
							}
							else 
							{
								output.Write("<td>&nbsp;</td>");
							}
						}

						output.Write("<td class=lvl1><img src=/images/pxl.gif alt=\"\" width=1 height=1></td>");
						output.Write("</tr>");						

						/* write white line with width */
						output.Write("<tr>");
						output.Write("<td bgcolor=white><img src=/images/pxl.gif alt=\"\" width=15 height=1></td>");
						for(z=wraps; z<wraps+cols; z++) { output.Write("<td bgcolor=white><img src=/images/pxl.gif alt=\"\" height=1 width=191></td>"); }
						output.Write("<td bgcolor=white><img src=/images/pxl.gif alt=\"\" width=5 height=1></td>");
						output.Write("</tr>");
						
					}					

					//write subpages
					output.Write("<tr>");	
					output.Write("<td width=5 class=lvl2><img src=/images/pxl.gif alt=\"\" width=5 height=1></td>");

					// write subpages for sectionpages 
					for(z=wraps; z<wraps+cols; z++) 
					{	
						if (z<amap.Length && x<amap[z].Length) 
						{
							output.Write("<td class=lvl2>");
							output.Write("<img src=\"/images/arrow-red.gif\" alt=\"\"> &nbsp;<a href=" + amap[z][x].LinkURL + ">" + amap[z][x].PageName + "</a>");
							output.Write("</td>");
							empty=0;
						}
						else 
						{
							output.Write("<td>&nbsp;</td>");
							empty++;								
						}
					}

					output.Write("<td class=lvl2><img src=/images/pxl.gif alt=\"\" width=1 height=1></td>");
					output.Write("</tr>");

					// finish first row of coloumns if alle cols are empty
					if (empty>cols-1) break;
					output.Write("<tr><td colspan=" + (cols+margins) + " bgcolor=white><img src=/images/pxl.gif alt=\"\" height=1 width=1></td></tr>");					
				}
				output.Write("<tr><td colspan=" + (cols+margins) + "><img src=/images/pxl.gif alt=\"\" height=1 width=1><br></td></tr>");
				wraps = wraps + cols;
			}			
			output.Write("</table>");	
		}	
	}
}
