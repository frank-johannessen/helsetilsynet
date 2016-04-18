/* Custem property example 
 * Installation guide:
 * 1. Add this file to your EPiServer project
 * 2. Compile the project (Important!)
 * 3. Open EPiServer admin mode
 * 4. Scroll to "Page types", select "Edit custom property types"
 * 5. Click the Create button
 * 6. Use the following settings:
 *        Basetype:        String
 *        Name:            Color
 *        Classname:        development.PropertyColor (remember the namespace)
 *        Assemblyname:    episerversample
 * 7. You can now use this custom property type on your pagetypes 
 */		

using System;
using EPiServer;
using EPiServer.Core;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Drawing;
using System.IO;

namespace development
{
	public class Listbox : EPiServer.Core.PropertyString
	{
		public Listbox()
		{
		}
 
		public override void CreateChildControls(string renderType,System.Web.UI.Control container)
		{
			switch(renderType)
			{
				case "edit":

					TextBox hidden = new TextBox();
					hidden.ID = Name;
					hidden.Text          = ToString();
					hidden.Attributes.Add("style","visibility:hidden; height:0px; width:0px");	
   
					




					ListBox input = new ListBox();

					//DropDownList input = new DropDownList();
					
					input.ID = "keywordlist"; 


					                                                   

					input.Height = 200;
					input.SelectionMode = ListSelectionMode.Multiple;

					DataFactory factory = Global.EPDataFactory;
					string KeywordList = factory.GetPage(EPiServer.Global.EPConfig.StartPage).Property["KeyWordList"].ToString();

					string [] ArrayKeywordList = KeywordList.Split(',');

					input.Items.Add(new ListItem("(None)", ""));
					foreach(string K in ArrayKeywordList) 
 
					{
						input.Items.Add(new ListItem(K.ToString(),K.ToString())); 
					}
						
					input.Attributes["onchange"] = "JavaScript:GetValue()";

					
					
					
					CopyWebAttributes(container, input);
 
					/*
					// Try to set selection in ListBox to saved one
					if(ToString().Length != 0)
					{
						ListItem selectedItem = input.Items.FindByValue(ToString());
						if (selectedItem != null)
							selectedItem.Selected = true;
						else
							input.SelectedIndex = 0;
					}
					else
						input.SelectedIndex = 0;
					*/
					
					container.Controls.Add(input);					
					container.Controls.Add(hidden);	

				    
					

					Literal containercode = new Literal();                                                          

					//containercode.Text = "<SCRIPT>hiddenid='" +  "PC_72_1_EditForm_" + this.Name + "_" + this.Name + "';</SCRIPT>";                        
					containercode.Text = "<SCRIPT>hiddenid='" +  hidden.ClientID+ "';</SCRIPT>";                        
					//containercode.Text += "<SCRIPT>selectid='" +  "PC_72_1_EditForm_" + this.Name + "_keywordlist';</SCRIPT>";                        
					containercode.Text += "<SCRIPT>selectid='" + input.ClientID + "';</SCRIPT>";                        
					containercode.Text += "<SCRIPT>valuestring='" + this.Value  + "';</SCRIPT>";

					StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\keywordlist.inc");

					containercode.Text += din.ReadToEnd();din.Close();  
                    
        
					container.Controls.Add(containercode);
					container.Controls.Add(CreateParseValidator(hidden)); 
					break;

				default:
					base.CreateChildControls(renderType,container);
					break;
			}
		}
 
	}
}
