<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BreadCrumbs.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.BreadCrumbs" %>
<EPiUtil:BreadCrumbsMenu ID="BreadCrumbsMenu1" AutoBind="true" runat="server">
    <HeaderTemplate>
            <strong>Du er her:</strong>
            <ol class="bread-crumbs nav">
    </HeaderTemplate>
    <ItemTemplate>
        <asp:PlaceHolder runat="server" Visible="<%# !(Container.Item is MakingWaves.Helsetilsynet.Intranet.Web.Model.Folder) %>">
            <li><a href="<%# Container.Item.LinkURL %>" title="<%# Container.Item.PageName %>"><%# Container.Item.PageName %></a></li>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" Visible="<%# IsViewableFolder(Container.Item) %>">
            <li><%# Container.Item.PageName %></li>
        </asp:PlaceHolder>
    </ItemTemplate>
    <SelectedItemTemplate>
        <asp:PlaceHolder runat="server" Visible="<%# !(Container.Item is MakingWaves.Helsetilsynet.Intranet.Web.Model.Folder) %>">
            <li class="current"><%#  Container.Item.PageName %></li>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" Visible="<%# IsViewableFolder(Container.Item) %>">
            <li class="current"><%#  Container.Item.PageName %></li>
        </asp:PlaceHolder>
    </SelectedItemTemplate>
    <SeparatorTemplate>        
    </SeparatorTemplate>
    <FooterTemplate>
            </ol>
    </FooterTemplate>
</EPiUtil:BreadCrumbsMenu>