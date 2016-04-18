<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProfileContactInfo.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.EditProfileContactInfo" %>
<%@ Register TagPrefix="RelatePlus" TagName="NewPassword" Src="~/Templates/Units/Login/NewPassword.ascx" %>

<h2 class="heading"><%= Translate("/personinformation/contactinformation")%></h2>
<div class="edit-contact-info">
    <div class="employee-category-selector">    
        <asp:LinkButton runat="server" ID="c1Employee" OnCommand="ChangeEmployeView_OnCommand" CommandArgument="false" Text="<%$ Resources: EPiServer, personinformation.employeec1 %>" />
        <asp:LinkButton runat="server" ID="fmEmployee" OnCommand="ChangeEmployeView_OnCommand" CommandArgument="true" Text="<%$ Resources: EPiServer, personinformation.employeefylkesmann %>" />
    </div>
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.firstname %>" AssociatedControlID="txtFirstname" />
    <asp:TextBox ID="txtFirstname" MaxLength="255" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:RegularExpressionValidator  ControlToValidate="txtFirstname" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.lastname %>" AssociatedControlID="txtLastname" />
    <asp:TextBox ID="txtLastname" MaxLength="255" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtLastname" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>
    
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.initials %>" AssociatedControlID="txtInitials" />
    <asp:TextBox ID="txtInitials" MaxLength="255" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtInitials" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>
    
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.title %>" AssociatedControlID="txtTitle" />
    <asp:TextBox ID="txtTitle" MaxLength="255" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtTitle" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>

    <div runat="server" id="liFylkesmannsEmbete">
        <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.fylkesmannsembete %>" AssociatedControlID="ddlFylkesmannsEmbete" />
        <asp:DropDownList runat="server" ID="ddlFylkesmannsEmbete" ValidationGroup="editProfileGroup" OnDataBound="ddlFylkesmannsEmbete_DataBound"></asp:DropDownList>
    </div>

    <asp:Label runat="server" ID="lblDepartmentDdl" Text="<%$ Resources: EPiServer, personinformation.department %>" AssociatedControlID="ddlDepartment" />
    <asp:DropDownList ID="ddlDepartment" runat="server" ValidationGroup="editProfileGroup" OnDataBound="ddlDepartment_DataBound" />
    <div>
        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="valDepartment" ControlToValidate="ddlDepartment" ValidationGroup="editProfileGroup" ErrorMessage="Velg en avdeling, er du fylkesmann må du velge dette ved å trykke på 'Ansatte hos fylkesmannen' på toppen av denne boksen" InitialValue="0"></asp:RequiredFieldValidator>
    </div>

    <asp:Label runat="server" ID="lblDepartmentTxt" Text="<%$ Resources: EPiServer, personinformation.department %>" AssociatedControlID="txtDepartment" />
    <asp:TextBox runat="server" ID="txtDepartment" ValidationGroup="editProfileGroup"></asp:TextBox>
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtDepartment" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>

    <div runat="server" id="liRoomNumber">
        <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.roomnumber %>" AssociatedControlID="txtRoomNumber" />
        <asp:TextBox runat="server" ID="txtRoomNumber" ValidationGroup="editProfileGroup"></asp:TextBox>
        <div>
            <asp:RegularExpressionValidator ControlToValidate="txtRoomNumber" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
        </div>
    </div>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.email %>" AssociatedControlID="txtEmail" />
    <asp:TextBox ID="txtEmail" MaxLength="255" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:RegularExpressionValidator ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression=".{0,255}" runat="server" SetFocusOnError="true" ValidationGroup="editProfileGroup" ErrorMessage="<%$ Resources: EPiServer, general.texttolong %>"/>
    </div>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.telephone %>" AssociatedControlID="txtTelephone" />
    <asp:TextBox ID="txtTelephone" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:CustomValidator ID="cvTelephone"
            ControlToValidate="txtTelephone" 
            ValidationGroup="editProfileGroup"
            ErrorMessage="<%$ Resources: EPiServer, personinformation.wrongtelephone %>" OnServerValidate="cvValidatePhoneNumber" 
            SetFocusOnError="true" Display="Dynamic" runat="server" />
    </div>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.mobile %>" AssociatedControlID="txtMobile" />
    <asp:TextBox ID="txtMobile" runat="server" ValidationGroup="editProfileGroup" />
    <div>
        <asp:CustomValidator ID="cvMobile"
            ControlToValidate="txtMobile" 
            ValidationGroup="editProfileGroup"
            ErrorMessage="<%$ Resources: EPiServer, personinformation.wrongtelephone %>" OnServerValidate="cvValidatePhoneNumber" 
            SetFocusOnError="true" Display="Dynamic" runat="server" />
    </div>
    
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.profilepicture %>" AssociatedControlID="fuImage" />
    <asp:FileUpload runat="server" ID="fuImage" ValidationGroup="editProfileGroup" />
    <asp:CustomValidator runat="server" ID="valFileUpload" ControlToValidate="fuImage" Display="Dynamic" 
        OnServerValidate="valFileUpload_OnServerValidate" 
        ValidationGroup="editProfileGroup"
        ErrorMessage="<%$ Resources: EPiServer, errormessages.notimageformat %>" />
    
    <asp:Button ID="btnSaveProfile" runat="server" OnClick="btnSaveProfile_Click" ValidationGroup="editProfileGroup" Text="<%$ Resources: EPiServer, personinformation.savecontactinfo %>" />
    
    <RelatePlus:NewPassword runat="server" ShowCurrentEmail="False" ShowErrorsDiv="True" ID="ucNewPassword" />
</div>