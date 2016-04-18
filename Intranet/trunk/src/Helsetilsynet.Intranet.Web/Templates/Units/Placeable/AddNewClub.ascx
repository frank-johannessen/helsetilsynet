<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddNewClub.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.AddNewClub" %>
<%@ Register tagPrefix="ht" tagName="UserPicker" src="~/Templates/Units/Placeable/UserPicker.ascx" %>
    <div class="modal-popup-wrapper">
        <div class="edit-project modal-popup">
<h2 class="heading"><%= Translate("/createclub/heading")%></h2>
<div class="project-details">
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createclub.name %>" AssociatedControlID="txtName" />
    <asp:TextBox runat="server" ID="txtName" ValidationGroup="vgNewClub" MaxLength="255" />
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtName" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="vgNewClub" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgNewClub" ErrorMessage="Du må skrive inn et navn på prosjektrommet" />
    </div>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createclub.description %>" AssociatedControlID="txtDescription" />
    <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" ValidationGroup="vgNewClub" />

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createclub.goal %>" AssociatedControlID="txtProjectGoal" />
    <asp:TextBox runat="server" ID="txtProjectGoal" TextMode="MultiLine" ValidationGroup="vgNewClub" />

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createclub.period %>" AssociatedControlID="txtProjectPeriod" />
    <asp:TextBox runat="server" ID="txtProjectPeriod" MaxLength="255" ValidationGroup="vgNewClub" />
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtProjectPeriod" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="vgNewClub" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>
</div>
<fieldset class="service-areas">
    <legend><%= Translate("/personinformation/serviceareas") %></legend>
    <asp:CheckBoxList RepeatLayout="UnorderedList" ValidationGroup="vgNewClub" runat="server" ID="cblServiceAreas" OnDataBound="cblServiceAreas_OnDataBound" />
</fieldset>
<fieldset class="image-picker">
    <legend><%= Translate("/general/addorchangeimage")%></legend>
    <div>
        <asp:FileUpload runat="server" ID="fuImage" ValidationGroup="vgNewClub" />
        <asp:CustomValidator runat="server" ID="valFileUpload" ControlToValidate="fuImage" Display="Dynamic" OnServerValidate="valFileUpload_OnServerValidate" ValidationGroup="vgNewClub"></asp:CustomValidator>
    </div>
</fieldset>

<fieldset class="user-picker">
    <legend><%= Translate("/createclub/bullettwo")%></legend>

    <ht:userpicker runat="server" ID="ucUserPicker" />
</fieldset>
<fieldset>
    <legend><%= Translate("/createclub/bulletthree")%></legend>
    <asp:RadioButtonList runat="server" ID="rblAccessSecurity" ValidationGroup="vgNewClub" OnDataBound="rblAccessSecurity_OnDataBound">
        <asp:ListItem Value="Open" Text="<%$ Resources: EPiServer, createclub.statusopen %>" Selected="True" />
        <asp:ListItem Value="Closed" Text="<%$ Resources: EPiServer, createclub.statusclosed %>" />
    </asp:RadioButtonList>
</fieldset>
<asp:LinkButton runat="server" OnCommand="lbCancel_OnClick" Text="<%$ Resources: EPiServer, general.cancel %>" />
<asp:Button runat="server" ID="btnCreateClub" OnClick="btnCreateClub_OnClick" ValidationGroup="vgNewClub" Text="<%$ Resources: EPiServer, general.save %>" />
<br/>
<span id="addClubWarningAndLoader">Det kan ta tid å opprette nytt prosjektrom, vennligst ikke trykk flere ganger.</span>
</div>
</div>
<script type="text/javascript">
    $('#<%= btnCreateClub.ClientID %>').click(function () {
        var valid = true;// window.Page_ClientValidate();
        if (valid) {
            $('#addClubWarningAndLoader').replaceWith('<span style="color: green;">Det tar litt tid å lage prosjektrom, venligst vent...</span>');
            $('#<%= btnCreateClub.ClientID %>').css("display", "none");
        } 
    });    
</script>
