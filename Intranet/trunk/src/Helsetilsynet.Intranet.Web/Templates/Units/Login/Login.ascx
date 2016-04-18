<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Login.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login.Login" %>
<%@ Register TagPrefix="RelatePlus" TagName="Register" Src="~/Templates/Units/Login/Register.ascx" %>
<%@ Register TagPrefix="RelatePlus" TagName="ForgotPassword" Src="~/Templates/Units/Login/ForgotPassword.ascx" %>
<%@ Register TagPrefix="RelatePlus" TagName="NewPassword" Src="~/Templates/Units/Login/NewPassword.ascx" %>


<%--<asp:HiddenField ID="txtClaimedIdentifier" runat="server" />
<asp:HiddenField ID="txtFriendlyIdentifier" runat="server" />--%>
<div class="info-text">
    <asp:Literal runat="server" ID="litInfoText" />
</div>
<asp:LoginView ID="livLogin" runat="server">
    <AnonymousTemplate>
        <asp:Login ID="lgiCommunityLogin" CssClass="login" runat="server" VisibleWhenLoggedIn="false" DisplayRememberMe="true" RememberMeSet="True" OnAuthenticate="onAuthenticate" OnLoggingIn="login_loggingIn" OnLoggedIn="login_loggedIn" OnLoginError="login_LoginError" >
            <LayoutTemplate>
                <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">
                    
                    <asp:Label ID="lblUsername" runat="server" AssociatedControlID="username" Text="<%$ Resources: EPiServer, login.usernameoremail %>" />
                    <asp:TextBox ID="username" runat="server" Columns="20" ValidationGroup="loginFormGroup" CssClass="textBox" />
                    <asp:RequiredFieldValidator ID="valUsername" runat="server" ControlToValidate="username" ErrorMessage="*" SetFocusOnError="true" Display="Dynamic" ValidationGroup="loginFormGroup" />

                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="password" Text="<%$ Resources: EPiServer, login.password %>" />
                    <asp:TextBox ID="password" TextMode="Password" Columns="20" ValidationGroup="loginFormGroup" runat="server" CssClass="textBox" />
                    <asp:RequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="password" ErrorMessage="*" SetFocusOnError="true" Display="Dynamic" ValidationGroup="loginFormGroup" />

                    <asp:CheckBox ID="RememberMe" Text="<%$ Resources: EPiServer, login.rememberme %>" runat="server" CssClass="loginCheckBox" />
                    <div class="login-button-wrapper">
                        <asp:Button ID="btnLogin" runat="server" Text="<%$ Resources: EPiServer, login.login%>" CommandName="Login" ValidationGroup="loginFormGroup" CausesValidation="true"/>
                    </div>
                    <div id="divErrorText" runat="server" visible="false" style="color: Red;">
                        <asp:Literal ID="litErrorText" runat="server" />
                    </div>                                
                    <div class="actions">
                        <asp:LinkButton ID="lbRegistration" runat="server" Text="<%$ Resources: EPiServer, login.register %>" OnClick="lbRegistration_Click" CausesValidation="false" />                                
                        <asp:LinkButton ID="lbForgotPassword" runat="server" Text="<%$ Resources: EPiServer, login.forgotyourpassword %>" OnClick="lbForgotPassword_Click" CausesValidation="false" />
                    </div>
                </asp:Panel>
            </LayoutTemplate>
        </asp:Login>
    </AnonymousTemplate>
    <LoggedInTemplate>
        <div class="member-info">
            <asp:HyperLink ID="hlUserImage" runat="server">
                <asp:Image ID="imgPerson" runat="server" CssClass="imgListThmb" />
            </asp:HyperLink>
            <div class="personalInfo">
                <h2>
                    <asp:Label ID="linUsername" runat="server"/>
                </h2>
            </div>
        </div>
    </LoggedInTemplate>
</asp:LoginView>
<RelatePlus:Register ID="ucRegister" runat="server" Visible="false" />
<RelatePlus:ForgotPassword ID="ucForgotPassword" runat="server" Visible="false" />
<RelatePlus:NewPassword ID="ucNewPassword" runat="server" Visible="False" ShowErrorsDiv="True" ShowCurrentEmail="True" RedirectToLoginPage="True" />
<div class="info-text">
    <asp:Literal runat="server" ID="litInfoText2" />
</div>
