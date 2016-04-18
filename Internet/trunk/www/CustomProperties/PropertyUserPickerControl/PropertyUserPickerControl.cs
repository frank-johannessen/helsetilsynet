using System.Text;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Web.PropertyControls;

namespace Helsetilsynet.CustomProperties.PropertyUserPickerControl
{
    public class PropertyUserPickerControl : PropertyTextBoxControlBase
    {
        readonly HtmlInputHidden _hfUsers = new HtmlInputHidden();
        public override void CreateEditControls()
        {
            const string callbackScript = @"<script type=""text/javascript"">
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
                                //var currentVal = $('#hfUsers').val().split(',');
                                //$.each(currentVal, function () {
                                //    currentUsr = this;
                                //    var found = $.inArray(user[0], $('#hfUsers').val().split(',')) > -1;
                                //    if (currentUsr != user[0] && user[0] != '' && !found)
                                //        textbox.value += user[0] + ',';
                                var found = $.inArray(user[0], $('#hfUsers').val().split(',')) > -1;
                                if (user[0] != '' && !found)
                                   textbox.value += user[0] + ',';
                                //});
                            }
                            createButtons();
                        }
                    }
                    </script>";

            if (!Page.ClientScript.IsStartupScriptRegistered(GetType(), "PropertyUserPickerDialog"))
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "PropertyUserPickerDialog", callbackScript);
            }

            _hfUsers.Value = ToString();
            _hfUsers.ID = "hfUsers";
            _hfUsers.Attributes.Add("id", "hfUsers"); //According to http://stackoverflow.com/questions/2974258/there-is-any-way-to-get-clientidmode-and-clientid-property-on-asp-net-3-5, it's a workaround to use ClientIDMode, which is in .net 4.0
            //_hfUsers.ClientIDMode = ClientIDMode.Static;
            Controls.Add(_hfUsers);

            var btn = new HtmlInputButton {Value = "Add contact"};
            btn.Attributes.Add("class", "epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Add");
            btn.Attributes.Add("onclick", "OpenDialogUserAndGroupBrowser(0, '', '" + UriSupport.AbsoluteUrlFromUIBySettings("edit") + "', true, HtUserDialogCompleted, document.getElementById('" + _hfUsers.ClientID + "'), null);");

            var span = new HtmlGenericControl("span");
            span.Attributes.Add("class", "epi-cmsButton");
            span.Controls.Add(btn);

            var div = new HtmlGenericControl("div") {ID = "divAddContact"};
            div.Attributes.Add("class", "epi-buttonDefault");
            div.Controls.Add(span);

            Controls.Add(div);
            var emptyDiv = new HtmlGenericControl("div") { ID = "emptyDiv" };
            Controls.Add(emptyDiv);

            var script = new StringBuilder();
            script.Append("<script type='text/javascript'>\n");
            script.Append("<!--\n");
            script.Append("function getCssName(username) {\n");
            script.Append("var cssName = username.replace('.', 'dot'); \n");
            script.Append("return cssName.replace('\\\\', 'slash');\n");
            script.Append("}\n");
            script.Append("function removeUserFromList(contact,className,field) {");
            script.Append("var valueField = $('#'+field+'');");
            script.Append("valueField.val(valueField.val().replace(contact+',',''));");
            script.Append("$('.'+className+'').remove();");
            script.Append("}");
            script.Append("//-->\n");
            script.Append("</script>");
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "UserRemove", script.ToString());

            var createButtons = new StringBuilder();
            createButtons.Append("<script type='text/javascript'>\n");
            createButtons.Append("<!--\n");
            createButtons.Append("function createButtons() {\n");
            createButtons.Append("  var contacts = $('#" + _hfUsers.ClientID + "').val().split(',');\n");
            createButtons.Append("  $.each(contacts, function(){\n");
            createButtons.Append("   var contact = this, className = getCssName(('Contact'+this.split('@')[0]).replace(/ /g,''));\n");
            createButtons.Append("    if(this != '' && $('.'+className).length == 0){\n");
            createButtons.Append("      var button = $('<input>').attr('type', 'button').attr('class', 'epi-cmsButton-tools epi-cmsButton-Delete').click(function(){ removeUserFromList(contact,className,'" + _hfUsers.ClientID + "');}) ;\n");
            createButtons.Append("      var element = $('<p>').attr('class',className).html('<span class=\"epi-cmsButton\"></span>' + this);\n");
            createButtons.Append("      element.find('span').append(button);\n");
            createButtons.Append("      element.insertBefore('#" + emptyDiv.ClientID + "');");
            createButtons.Append("  }\n});}\n;");
            createButtons.Append("//-->\n");
            createButtons.Append("</script>");
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "createButtons", createButtons.ToString());

            var onFirstLoad = new StringBuilder();
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
            SetValue(_hfUsers.Value);
        }
    }
}