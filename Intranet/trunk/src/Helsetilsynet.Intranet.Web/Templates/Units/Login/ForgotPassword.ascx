<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ForgotPassword.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login.ForgotPassword" %>
    
<asp:Panel ID="pnlForgotPassword" runat="server" DefaultButton="btnConfirm" Visible="False">
    <div id="PopUp">
        <fieldset class="popUp">
            <asp:Label ID="lblEmail" runat="server" Text="<%$Resources: EPiServer, login.usernameoremail %>" AssociatedControlID="txtEmail" />
            <div class="validation">
                <asp:TextBox ID="txtEmail" runat="server" ValidationGroup="passwordGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valRequiredEmail" ErrorMessage="<%$Resources: EPiServer, registration.emailmissing %>" runat="server" SetFocusOnError="true" ValidationGroup="passwordGroup" ControlToValidate="txtEmail" Display="Dynamic" />
                </div>
            </div>
            <div class="floatright">
                <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources: EPiServer, general.cancel %>" ToolTip="<%$ Resources: EPiServer, general.cancel %>" CausesValidation="false" OnClick="btnCancel_Click" />
                <asp:Button ID="btnConfirm" runat="server" Text="<%$ Resources: EPiServer, login.sendforgotpassword %>" ToolTip="<%$ Resources: EPiServer, login.sendforgotpassword %>" CausesValidation="true" ValidationGroup="passwordGroup" OnClick="btnConfirm_Click" />
            </div>
        </fieldset>
    </div>
</asp:Panel>
    
