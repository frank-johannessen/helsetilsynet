<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/NotLoggedIn.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.Login" %>

<%@ Register TagPrefix="ht" TagName="Login" Src="~/Templates/Units/Login/Login.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <script src="/Templates/scripts/custom-validators.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="MainContentRegion" ContentPlaceHolderID="MainContentRegion" runat="server">
    <div class="info-text">
        <asp:Literal runat="server" ID="litInfoText" />
    </div>
    <ht:Login runat="server" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnRegion">
    <h2><EPiServer:Property runat="server" PropertyName="Heading" /></h2>
    <EPiServer:Property runat="server" PropertyName="MainBody" CssClass="login-page-body"/>
</asp:Content>

