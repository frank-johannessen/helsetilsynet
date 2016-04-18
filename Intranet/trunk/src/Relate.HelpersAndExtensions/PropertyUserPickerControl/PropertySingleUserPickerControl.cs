using System.Text;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Web.PropertyControls;

namespace Relate.HelpersAndExtensions.PropertyUserPickerControl
{
    public class PropertySingleUserPickerControl : PropertyTextBoxControlBase
    {
        HtmlInputHidden hfUsers = new HtmlInputHidden();
        public override void CreateEditControls()
        {
            //base.CreateEditControls();
            string callbackScript = @"<script type=""text/javascript"">
                    function HtUserDialogCompleted(returnValue, textbox){
                        if (!returnValue) {
                            return;
                        }
                        
                        if (returnValue.length > 0) {
                            for(i = 0; i < returnValue.length; i++)
                            {
                                
                                user = returnValue[i].split(';')
                                if (user[1] == 1) 
                                {
                                    alert('You selected a group. Select a user instead.');
                                    return;
                                }
                                textbox.value = user[0];
                            }
                            createButtons();
                        }
                    }
                    </script>";

            if (!Page.ClientScript.IsStartupScriptRegistered(this.GetType(), "PropertyUserPickerDialog"))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "PropertyUserPickerDialog", callbackScript);
            }



            hfUsers.Value = ToString();
            hfUsers.ID = "hfUsers";
            Controls.Add(hfUsers);


            HtmlInputButton btn = new HtmlInputButton();
            btn.Value = "Add contact";
            btn.Attributes.Add("class", "epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Add");
            btn.Attributes.Add("onclick", "OpenDialogUserAndGroupBrowser(0, '', '" + UriSupport.AbsoluteUrlFromUIBySettings("edit") + "', false, HtUserDialogCompleted, document.getElementById('" + this.hfUsers.ClientID + "'), null);");

            HtmlGenericControl span = new HtmlGenericControl("span");
            span.Attributes.Add("class", "epi-cmsButton");
            span.Controls.Add(btn);

            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "divAddContact";
            div.Attributes.Add("class", "epi-buttonDefault");
            div.Controls.Add(span);

            Controls.Add(div);
            HtmlGenericControl emptyDiv = new HtmlGenericControl("div") { ID = "emptyDiv" };
            Controls.Add(emptyDiv);

            StringBuilder script = new StringBuilder();
            script.Append("<script type='text/javascript'>\n");
            script.Append("<!--\n");
            script.Append("function getCssName(username) {\n");
            script.Append("var cssName = username.replace('.', 'dot'); \n");
            script.Append("return cssName.replace('\\\\', 'slash');\n");
            script.Append("}\n");
            script.Append("function removeUserFromList(contact,className,field) {");
            script.Append("var valueField = $('#'+field+'');");
            script.Append("valueField.val(valueField.val().replace(contact,''));");
            script.Append("$('.'+className+'').remove();");
            script.Append("}");
            script.Append("//-->\n");
            script.Append("</script>");
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "UserRemove", script.ToString());

            StringBuilder createButtons = new StringBuilder();
            createButtons.Append("<script type='text/javascript'>\n");
            createButtons.Append("<!--\n");
            createButtons.Append("function createButtons() {\n");
            createButtons.Append("  $('.oldUserSingleUserPicker').remove();\n");
            createButtons.Append("  var contacts = $('#" + hfUsers.ClientID + "').val().split(',');\n");
            createButtons.Append("  $.each(contacts, function(){\n");
            createButtons.Append("   var contact = this, className = getCssName('Contact'+this);\n");
            createButtons.Append("    if(this != '' && $('.'+className).length == 0){\n");
            createButtons.Append("      var button = $('<input>').attr('type', 'button').attr('class', 'epi-cmsButton-tools epi-cmsButton-Delete').click(function(){ removeUserFromList(contact,className,'" + hfUsers.ClientID + "');}) ;\n");
            createButtons.Append("      var element = $('<p>').attr('class',className+' oldUserSingleUserPicker').html('<span class=\"epi-cmsButton\"></span>' + this);\n");
            createButtons.Append("      element.find('span').append(button);\n");
            createButtons.Append("      element.insertBefore('#" + emptyDiv.ClientID + "');");
            createButtons.Append("  }\n});}\n;");
            createButtons.Append("//-->\n");
            createButtons.Append("</script>");
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "createButtons", createButtons.ToString());

            StringBuilder onFirstLoad = new StringBuilder();
            onFirstLoad.Append("<script type='text/javascript'>\n");
            onFirstLoad.Append("<!--\n");
            onFirstLoad.Append("$(document).ready(function () {");
            onFirstLoad.Append("createButtons();");
            onFirstLoad.Append("});");
            onFirstLoad.Append("//-->\n");
            onFirstLoad.Append("</script>");
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "onFirstLoad", onFirstLoad.ToString());

        }
        public override void ApplyEditChanges()
        {
            base.SetValue(hfUsers.Value);
        }
    }
}