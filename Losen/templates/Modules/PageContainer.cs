using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using System.Web.UI.WebControls;
 
namespace development.templates.Properties
{

	[PageDefinitionTypePlugIn(DisplayName="PageContainer", Description="Container for pages")]
	public class PageContainer : PropertyLongString
	{
		Literal errormsg = new Literal();

		public PageContainer()
		{
		}
 
		public override void CreateChildControls(string renderType,System.Web.UI.Control container)
		{			
			try 
			{
				switch(renderType)
				{
					case "edit":
										
						TextBox input = new TextBox();
						input.ID = Name;
						input.Text	= ToString();
						input.Attributes.Add("style","visibility:hidden; height:0px; width:0px");																						

						Literal containercode = new Literal();									
						containercode.Text += "<SCRIPT>" + this.Name + "_clientid='" +  "_ctl0_EditForm_" + this.Name + "_" + this.Name + "';</SCRIPT>";
						string[] containerdata = this.ToString().Split(',');
						string clientdata = ""; int actualcount = 0;
						for(int i=0; i<containerdata.Length; i++)
						{
							try 
							{
								string[] pageitem = containerdata[i].Split('|');
								EPiServer.Core.PageReference pageLink = new EPiServer.Core.PageReference(pageitem[0]);						
								EPiServer.Core.PageData mypage = Global.EPDataFactory.GetPage(pageLink);
								if (actualcount>0) clientdata += "#"; 
								if (!mypage.IsDeleted) 
								{
									clientdata += pageitem[0] + "|" + mypage.PageName;
									actualcount++;
								}
							}
							catch 
							{
								//DO NOTHING
							}
						}					
						containercode.Text += "<SCRIPT>" + this.Name + "_containerdata='" + clientdata + "'.split('#');</SCRIPT>";
						//string ContainerClientCodePath = System.Configuration.ConfigurationSettings.AppSettings["PageContainerClientCodePath"];
						string ContainerClientCodePath = EPiServer.Global.BaseDirectory + @"inc\\PageContainerCode.html";
						StreamReader din = File.OpenText(ContainerClientCodePath);
						containercode.Text += din.ReadToEnd().Replace("OBJECTNAME",this.Name).Replace("DISPLAYNAME",this.DisplayName);din.Close(); 					
						container.Controls.Add(input);
						container.Controls.Add(containercode);					
						container.Controls.Add(CreateParseValidator(input)); 
						break;

					default:
						base.CreateChildControls(renderType,container);
						break; 
				}
			}
			catch (Exception e)
			{				
				errormsg.Text += "[ERROR]";
				errormsg.Text += "<DIV>";
				errormsg.Text += e.Message;
				errormsg.Text += "</DIV>";
				container.Controls.Add(errormsg);
			}
		}
		#region IPropertyFormLayout Members
 
		public override EPiServer.Core.TableRowLayout RowLayout
		{
			get
			{
				return EPiServer.Core.TableRowLayout.Wide;
			}
		}
 
		#endregion
	}
}
