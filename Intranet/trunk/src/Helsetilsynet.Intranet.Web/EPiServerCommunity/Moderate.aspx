<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Moderate.aspx.cs" Inherits="EPiServer.Community.Web.Administration.Moderate"
    MasterPageFile="~/EPiServerCommunity/Community.Master" %>

<asp:Content ContentPlaceHolderID="HeaderDocumentReady" ID="HeaderDocumentReady" runat="server">
    <%= ShowEntityPopup() %>
</asp:Content>

<asp:Content ContentPlaceHolderID="MenuContent" ID="ModerateMenuContent" runat="server">
    <div id="epi-applicationBodySidebar">
        <%= ShowMenu() %>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" ID="ModerateMainContent" runat="server">
    <div id="epi-applicationBodyMainWrapper">
        <div id="epi-applicationBodyMain">
            <iframe src="<%= MainContentUrl %>" frameborder="0" width="100%" height="99%" name="<%= MainContentFrameName %>">
            </iframe>
        </div>
    </div>
</asp:Content>