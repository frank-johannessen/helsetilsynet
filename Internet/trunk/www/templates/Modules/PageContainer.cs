using System;
using System.IO;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using System.Web.UI.WebControls;

namespace Avenir.templates.Properties
{

	[PageDefinitionTypePlugIn(DisplayName="PageContainer", Description="Container for pages")]
	public class PageContainer : PropertyLongString
	{
		Literal errormsg = new Literal();

	    [Obsolete("CreateChildControls is no longer used. Use CreatePropertyDataControl to create a control instead.")]
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
						//containercode.Text += "<SCRIPT>" + this.Name + "_clientid='" +  "_ctl0_EditForm_" + this.Name + "_" + this.Name + "';</SCRIPT>";
						containercode.Text += "<SCRIPT>" + Name + "_clientid='" +  container.ClientID + "_" + Name + "';</SCRIPT>";
						string[] containerdata = ToString().Split(',');
						string clientdata = ""; int actualcount = 0;
						for(int i=0; i<containerdata.Length; i++)
						{
							try 
							{
								string[] pageitem = containerdata[i].Split('|');
								var pageLink = new PageReference(pageitem[0]);						
								var mypage = DataFactory.Instance.GetPage(pageLink);
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
						containercode.Text += "<SCRIPT>" + Name + "_containerdata='" + clientdata + "'.split('#');</SCRIPT>";
						//string ContainerClientCodePath = System.Configuration.ConfigurationSettings.AppSettings["PageContainerClientCodePath"];
						string containerClientCodePath = Global.BaseDirectory + @"inc\\PageContainerCode.html";
				        if (containerClientCodePath == null) throw new NotImplementedException();
				        StreamReader din = File.OpenText(containerClientCodePath);
						containercode.Text += din.ReadToEnd().Replace("OBJECTNAME",Name).Replace("DISPLAYNAME",TranslateDisplayName());din.Close(); 					
						container.Controls.Add(input);
						container.Controls.Add(containercode);					
                        //container.Controls.Add(CreateParseValidator(input)); 
						break;

					default:
                        //base.CreateChildControls(renderType,container);
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
 
		public  TableRowLayout RowLayout
		{
			get
			{
				return TableRowLayout.Wide;
			}
		}
 
		#endregion
	}
}
