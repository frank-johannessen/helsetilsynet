<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewPassword.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login.NewPassword" %>
<asp:Placeholder runat="server" ID="phErrors">
    <div class="info-box">
        <asp:Label runat="server" ID="lblInfo" ForeColor="Red" />
    </div>
</asp:Placeholder>
<asp:Panel ID="pnlNewPassword" runat="server" DefaultButton="btnConfirm">
    <fieldset class="fs-new-password">
        <asp:PlaceHolder runat="server" ID="phCurrentEmail">
            <asp:Label ID="lblEmail" runat="server" Text="<%$Resources: EPiServer, login.usernameoremail %>" AssociatedControlID="txtEmail" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="text" Enabled="False" Text="<%#UserName %>" />
        </asp:PlaceHolder>

        <asp:Label ID="lblPassword" runat="server" Text="<%$Resources: EPiServer, login.password %>" AssociatedControlID="txtPassword" />
        <div class="validation">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ValidationGroup="setNewPasswordGroup" CssClass="text" />
            <div class="valMessage">
                <asp:RequiredFieldValidator ErrorMessage="<%$Resources: EPiServer, registration.passwordmissing %>" ID="valPassword" runat="server" ValidationGroup="setNewPasswordGroup" ControlToValidate="txtPassword" Display="Dynamic" />
                <asp:RegularExpressionValidator ErrorMessage="<%$Resources: EPiServer, registration.invalidpasswordformat %>" ID="valNewPassword" runat="server" ControlToValidate="txtPassword" ValidationExpression="^.{6,}$" Display="Dynamic" ValidationGroup="setNewPasswordGroup" />
            </div>
        </div>

        <asp:Label ID="lblConfirmPassword" runat="server" Text="<%$Resources: EPiServer, registration.confirmpassword %>" AssociatedControlID="txtConfirmPassword" />
        <div class="validation">
            <asp:TextBox ID="txtConfirmPassword" runat="server" ValidationGroup="setNewPasswordGroup" TextMode="Password" CssClass="text" />
            <div class="valMessage">
                <asp:RequiredFieldValidator ID="valConfirmPassword" ErrorMessage="<%$Resources: EPiServer, registration.passwordmissing %>" runat="server" ValidationGroup="setNewPasswordGroup" ControlToValidate="txtConfirmPassword" Display="Dynamic" />
                <asp:CompareValidator ID="valComparePassword" ErrorMessage="<%$Resources: EPiServer, registration.passwordnotmatching %>" runat="server" ValidationGroup="setNewPasswordGroup" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" Display="Dynamic" />
            </div>
        </div>
        <div class="floatright">
            <asp:Button ID="btnConfirm" runat="server" Text="<%$ Resources: EPiServer, login.setnewpassword %>" ToolTip="<%$ Resources: EPiServer, login.setnewpassword %>" CausesValidation="True" ValidationGroup="setNewPasswordGroup" OnClick="btnConfirm_Click" />
        </div>
    </fieldset>
</asp:Panel>