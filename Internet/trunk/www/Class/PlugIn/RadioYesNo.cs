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
using EPiServer.Web.WebControls;


namespace EPiServer.SpecializedProperties
{
	/// <summary>
	/// Viser en radioknapp liste med valgene ja eller nei.(true/false)
	/// </summary>
	[Serializable]
	[PageDefinitionTypePlugIn]
	public class PropertyYesNoRadioButton:PropertyString
	{	
		public PropertyYesNoRadioButton()
		{
		}

        public override IPropertyControl CreatePropertyControl()
        {
            return new YesNoControl();
        }
	}



    public class YesNoControl : EPiServer.Web.PropertyControls.PropertyBooleanControl //.PropertyStringControl
    {
        public override void ApplyEditChanges()
        {
            //bool value = false;
            if (this.radioButtonList.Items[0].Selected)
                //value = true;
            if (this.radioButtonList.Items[1].Selected && _hidden.Text=="true")
                //value = false;

            base.SetValue(this.radioButtonList.Items[0].Selected);
        }

        TextBox _hidden = new TextBox();

        public TextBox hidden
        {
            get { return _hidden; }
            set { _hidden = value; }
        }

        public RadioButtonList radioButtonList;

        public override void CreateEditControls()
		{
            System.Web.UI.Control container = this;
            hidden.ID = Name;
            hidden.Visible = false;
            hidden.Text = ToString();
           
            radioButtonList = new RadioButtonList();
			radioButtonList.RepeatDirection = RepeatDirection.Horizontal;
			
            bool next = true;
			ListItem item = new ListItem("Ja","true");
            if (hidden.Text == "true")
            {
                item.Selected = true;
                next = false;
            }
			radioButtonList.Items.Add(item);
			
			item = new ListItem("Nei","false");
            //if(hidden.Text=="false")
				item.Selected=next;
			radioButtonList.Items.Add(item);
			
			container.Controls.Add(radioButtonList);
            container.Controls.Add(hidden);
            //radioButtonList.Controls.Add(CreateParseValidator(radioButtonList));

		 }	


        //public override void ParseValidation(object source, ServerValidateEventArgs args)
        //{			
        //    args.IsValid = false;
        //    RadioButtonList  caller = ((Control)source).Parent as RadioButtonList;
        //    if(caller.Items[0].Selected)
        //        String="true";
        //    else
        //        String="false";
        //    args.IsValid=true;
        //}
	}
}
