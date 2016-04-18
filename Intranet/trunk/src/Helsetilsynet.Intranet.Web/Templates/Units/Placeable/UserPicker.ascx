<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserPicker.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.UserPicker" %>
<%@ Import Namespace="EPiServer" %>
<asp:PlaceHolder runat="server" ID="plhControls"></asp:PlaceHolder>
<script src="/util/javascript/system.js" type="text/javascript" ></script>
<script src="/util/javascript/dialog.js" type="text/javascript" ></script>
<link rel="stylesheet" type="text/css" href="/App_Themes/Default/Styles/ToolButton.css"/>
<script type="text/javascript" src="/secureUI/CMS/Javascript/system.aspx" ></script>
<script type="text/javascript" src="/util/javascript/episerverscriptmanager.js" ></script>


<%--<input type="hidden" id="hfUsers" />--%>
<asp:HiddenField runat="server" ID="hfUsersToAdd" ClientIDMode="Static" />

<div id="divAddContact" class="epi-buttonDefault">
    <span class="epi-cmsButton">
    <input type="button" value="Legg til medlemmer" class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Add" onclick="OpenDialogUserAndGroupBrowser(0, '', '<%= UriSupport.AbsoluteUrlFromUIBySettings("edit") %>', true, HtUserDialogCompleted, document.getElementById('<%= hfUsersToAdd.ClientID %>'), null);"/>
</span>
</div>            

<div id="emptyDiv"></div>


<script type="text/javascript">
    function HtUserDialogCompleted(returnValue, textbox) {
        if (!returnValue) {
            return;
        }

        if (returnValue.length > 0) {
            for (var i = 0; i < returnValue.length; i++) {

                var user = returnValue[i].split(';');
                if (user[1] == 1) {
                    alert('You selected a group. Select a user instead.');
                    return;
                }
                //get current val()  if exist dont add.
//                var currentVal = $('#<%= hfUsersToAdd.ClientID %>').val().split(',');
//                $.each(currentVal, function () {
//                    if (this != user[0] && user[0] != '')
//                        textbox.value += user[0] + ',';
                //                });
                var found = $.inArray(user[0], $('#<%= hfUsersToAdd.ClientID %>').val().split(',')) > -1;
                if (user[0] != '' && !found)
                    textbox.value += user[0] + ',';
            }
            createButtons();
        }
    }
    function getCssName(username) {
        var cssName = username.replace('.', 'dot');
        return cssName.replace('\\\\', 'slash');
    }
    function removeUserFromList(contact,className,field) {
        var valueField = $('#'+field+'');
        valueField.val(valueField.val().replace(contact+',',''));
        $('.'+className+'').remove();
    }
    function createButtons() {
        var contacts = $('#<%= hfUsersToAdd.ClientID %>').val().split(',');
        $.each(contacts, function(){
            var contact = this, className = getCssName(('Contact'+this.split('@')[0]).replace(/ /g,''));
            if(this != '' && $('.'+className).length == 0){
                var button = $('<input>').attr('type', 'button').attr('class', 'epi-cmsButton-tools epi-cmsButton-Delete').click(function () { removeUserFromList(contact, className, '<%= hfUsersToAdd.ClientID %>'); });
                var element = $('<p>').attr('class',className).html('<span class=\"epi-cmsButton\"></span>' + this);
                element.find('span').append(button);
                element.insertBefore('#emptyDiv');
            } 
        });
    }
    $(document).ready(function () {
        createButtons();
    });
</script>