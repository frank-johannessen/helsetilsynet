using System;
using System.Collections;
using System.IO;
using EPiServer.Core;
using EPiServer.PlugIn;
using System.Web.UI.WebControls;
 
namespace Avenir.templates.Properties
{

	[PageDefinitionTypePlugIn(DisplayName="SideTyper", Description="Multiple pagetypes selection")]
	public class PageTypes : PropertyLongString
	{
	    [Obsolete]
		public override void CreateChildControls(string renderType,System.Web.UI.Control container)
		{			
			try 
			{
				switch(renderType)
				{
					case "edit":
										
						/* WEBCONTROL FOR SAVED DATA*/
						TextBox hidden = new TextBox();
						hidden.ID = Name;
						hidden.Text = ToString();
						hidden.Attributes.Add("style","visibility:hidden; height:0px; width:0px");	
   
						                                                     

						/* WEBCONTROL FOR LIST INTERACTION */
						ListBox input = new ListBox();					
						input.ID = "pagetypelist"; 
						input.Height = 200;
						input.SelectionMode = ListSelectionMode.Multiple;
						input.Attributes["onchange"] = "JavaScript:GetValue()";

						/* ADD PAGETYPES TO ARRAYLIST */
						ArrayList pagetypeslist = new ArrayList();
						foreach (EPiServer.DataAbstraction.PageType pagetype in EPiServer.DataAbstraction.PageType.List())  
						{
							pagetypeslist.Add(pagetype);
						}	
						/* SORT ARRAYLIST WITH CUSTOM COMPARER */
						pagetypeslist.Sort(new PagetypeComparer());

						/* ADD SORTET PAGETYPELIST TO LISTBOX */
						foreach (EPiServer.DataAbstraction.PageType pagetype in pagetypeslist) 
						{
							input.Items.Add(new ListItem(pagetype.Name,pagetype.ID.ToString()));
						}																	

						/* ADD CONTROLS TO CONTAINER */
                        //CopyWebAttributes(container, input);
                        //container.Controls.Add(hidden);	
                        //container.Controls.Add(input);															                                                    
						

                        /* CONTROL FOR INCLUDED SCRIPTS */
                        Literal containercode = new Literal();
                        //containercode.Text = "<SCRIPT>hiddenid='" + "_ctl0_EditForm_" + this.Name + "_" + this.Name + "';</SCRIPT>";
                        //containercode.Text += "<SCRIPT>selectid='" + "_ctl0_EditForm_" + this.Name + "_pagetypelist';</SCRIPT>";
                        containercode.Text = "<SCRIPT>hiddenid='" + hidden.ClientID + "';</SCRIPT>";
                        containercode.Text += "<SCRIPT>selectid='"+ input.ClientID +"';</SCRIPT>";
                        containercode.Text += "<SCRIPT>valuestring='" + Value + "';</SCRIPT>";
                        StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\keywordlist.inc");
                        containercode.Text += din.ReadToEnd();
                        din.Close();

                        container.Controls.Add(containercode);
                        //container.Controls.Add(CreateParseValidator(hidden));

						break;

					default:
                        //base.CreateChildControls(renderType,container);
						break;
				}
			}
			catch (Exception e)
			{				
				// DO NOTHING
				e.Message.ToString();
			}
		}
		#region IPropertyFormLayout Members
 
		public TableRowLayout RowLayout
		{
			get
			{
				return TableRowLayout.Default;
			}
		}
 
		#endregion
	}

	public class PagetypeComparer : IComparer  
	{
		/* COMPARE PAGETYPE NAMES FOR ASCII SORTING */
		int IComparer.Compare( Object x, Object y )  
		{
			return ((EPiServer.DataAbstraction.PageType)x).Name.CompareTo(((EPiServer.DataAbstraction.PageType)y).Name);
		}
	}
}
