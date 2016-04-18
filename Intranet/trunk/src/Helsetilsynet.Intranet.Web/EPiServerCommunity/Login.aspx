<%@ Page Language="c#" CodeBehind="Login.aspx.cs" AutoEventWireup="False" Inherits="EPiServer.Community.Web.Administration.Login"
    Title="Login" %>
<%@ OutputCache Location="None" %>
<%@ Import Namespace="System.Threading" %>
<%@ Register TagPrefix="community" Assembly="EPiServer.Community.Web.Administration" Namespace="EPiServer.Community.Web.Administration" %>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Thread.CurrentThread.CurrentUICulture.Name %>"
xml:lang="<%= Thread.CurrentThread.CurrentUICulture.Name %>">
<head id="Heading" runat="server">
    <!-- Mimic Internet Explorer 7 -->
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <meta name="robots" content="noindex,nofollow" />
    <link href="Styles/login.css" type="text/css" media="screen" rel="Stylesheet" />
</head>
<body>
    <form id="aspnetForm" runat="server">

    <script type="text/javascript">
        document.body.className = "epi-loginBody";

        function toggleCookieText() {
            var cookieInfoPanel = document.getElementById("cookieInfoPanel");
            cookieInfoPanel.style.display = (cookieInfoPanel.style.display == "block" ? "none" : "block");
            return false;
        }
    </script>

    <div class="epi-loginContainer">
    
        <community:LoginControl ID="LoginControl" runat="server">
            <LayoutTemplate>
                <div class="epi-loginTop">
                </div>
                <div class="epi-loginMiddle">
                    <div class="epi-loginContent">
                        <div class="epi-loginLogo">EPiServer Community</div>
                        <div class="epi-loginForm">
                            <h1><asp:Literal ID="HeadingLiteral" runat="server" /><span style="color:Red;"><asp:Literal runat="server" ID="FailureText" /></span></h1>
                            <asp:ValidationSummary ID="LoginValidationSummary" DisplayMode="List" EnableClientScript="true" runat="server" />
                           
                            <div class="epi-credentialsContainer">

                                <div class="epi-float-left">
                                    <asp:Label ID="UserNameLabel" AssociatedControlID="UserName" CssClass="episize80" runat="server" /><br />
                                    <asp:TextBox SkinID="Custom" CssClass="epi-inputText" ID="UserName" runat="server" />
                                    <asp:RequiredFieldValidator ID="RequiredUserNameValidator" Text="&#173;" ControlToValidate="UserName" Display="Dynamic" runat="server" />
                                </div>
                                <div class="epi-float-left">
                                    <asp:Label ID="PasswordLabel" AssociatedControlID="Password" CssClass="episize80" runat="server" /><br />
                                    <asp:TextBox SkinID="Custom" CssClass="epi-inputText" ID="Password" Text="password"
                                        runat="server" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="RequiredPasswordValidator" Text="&#173;" ControlToValidate="Password" Display="Dynamic" runat="server" />                                    
                                </div>
                                <div class="epi-button-container epi-float-left">
                                    <span class="epi-button">
                                        <span class="epi-button-child">
                                            <asp:Button ID="LoginButton" CssClass="epi-button-child-item" CommandName="Login" runat="server" />
                                        </span>
                                    </span>
                                </div>
                                <div class="epi-checkbox-container">
                                    <asp:CheckBox ID="RememberMe" CssClass="epi-checkbox" runat="server" />
                                    <asp:Label ID="RememberLabel" AssociatedControlID="RememberMe" runat="server" />
                                </div>
                            </div>
                            <p>
                                <a href="#" onclick="toggleCookieText(); return false;">
                                    <asp:Literal ID="CookiesCaption" runat="server" />
                                </a>
                                <div id="cookieInfoPanel" style="display: none; text-align: left;">
                                    <br />
                                    <asp:Literal ID="CookiesDescription" runat="server" />
                                </div>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="epi-loginBottom">
                </div>
            </LayoutTemplate>
    
    </community:LoginControl>    

    </div>
    </form>
</body>
</html>
