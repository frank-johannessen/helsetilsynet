<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="EPiServer.Community.Web.Administration.Admin"
    MasterPageFile="~/EPiServerCommunity/Community.Master" %>

<asp:Content ContentPlaceHolderID="MenuContent" ID="AdminMenuContent" runat="server">
    <div id="epi-applicationBodySidebar">
        <%= ShowMenu()%>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" ID="AdminMainContent" runat="server">
    <div id="epi-applicationBodyMainWrapper">
        <div id="epi-applicationBodyMain">
            <iframe src="<%= MainContentUrl%>" frameborder="0" width="100%" height="99%" name="<%= MainContentFrameName %>">
            </iframe>
        </div>
    </div>
</asp:Content>
