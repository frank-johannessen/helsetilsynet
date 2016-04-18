<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="Webmail.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Webmail.Webmail" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css">
<link rel="stylesheet" type="text/css" href="Administration.css">
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.webmail")%></h1>
<% if (AdminAccess)
   { %>
        <asp:Button ID="buttonSave" runat="server" CssClass="button" OnClick="buttonSave_Click" style="margin-bottom:10px;" />
<% } %>
<div id="tabStrip">
    <ComponentArt:TabStrip ID="tabStripWebmail" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageWebmail" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabSignature">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabDomain">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabMailServer">
            </ComponentArt:TabStripTab>
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageWebmail" CssClass="multiPage" runat="server">
        <ComponentArt:PageView runat="server" ID="pageViewSignature">
            <asp:Panel ID="panelWebmailSignature" runat="server">
            </asp:Panel>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewDomain">
            <asp:Panel ID="panelWebmailDomain" runat="server">
            </asp:Panel>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewMailServer">
            <asp:Panel ID="panelMailServer" runat="server">
            </asp:Panel>
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
</div>
