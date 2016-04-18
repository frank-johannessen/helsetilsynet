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
using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace EPiServer.SpecializedProperties
{
	/// <summary>
	/// Viser en radioknapp liste med valgene ja eller nei.(true/false)
	/// </summary>
	[Serializable]
	[PageDefinitionTypePlugIn]
	public class PropertyYesNoRadioButton:PropertyString
	{	
	  	public override void CreateChildControls(string renderType,System.Web.UI.Control container)
		{
		 	switch(renderType)
		 	{
					
		 		case "edit":					
					RadioButtonList radioButtonList = new RadioButtonList();
					radioButtonList.RepeatDirection = RepeatDirection.Horizontal;
					
					ListItem item = new ListItem("Ja","true");
					if(String=="true")
						item.Selected=true;
					radioButtonList.Items.Add(item);
					
					item = new ListItem("Nei","false");
					if(String=="false")
						item.Selected=true;
					radioButtonList.Items.Add(item);
					
					container.Controls.Add(radioButtonList);
					radioButtonList.Controls.Add(CreateParseValidator(radioButtonList));

		 			break;
		 		default:
		 			base.CreateChildControls(renderType,container);
		 			break;
		 	}
		 }	
		public override void ParseValidation(object source, ServerValidateEventArgs args)
		{			
			args.IsValid = false;
			//bool val = false;
			RadioButtonList  caller = ((Control)source).Parent as RadioButtonList;
			

				
					//val |=  bool.Parse();

			if(caller.Items[0].Selected)
				String="true";
			else
				String="false";

			args.IsValid=true;
		}
	}
}
