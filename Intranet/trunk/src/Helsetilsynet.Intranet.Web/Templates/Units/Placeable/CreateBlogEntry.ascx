<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateBlogEntry.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.CreateBlogEntry" %>
<%@ Register TagPrefix="Relate" Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Util" Assembly="MakingWaves.Helsetilsynet.Intranet.Web" %>
<div class="new-forum-entry">
    <h3>Legg til nytt innhold</h3>

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createentry.title %>" AssociatedControlID="txtTitle" />
    <asp:TextBox runat="server" ID="txtTitle" ValidationGroup="<%# ValGroup %>" />
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, createentry.body %>" AssociatedControlID="tinyTextEditor" />
    <Relate:TinyTexteditor ID="tinyTextEditor" Mode="BlogEntry" runat="server"/>
    <%--<asp:TextBox runat="server" ID="txtBody" TextMode="MultiLine" ValidationGroup="<%# ValGroup %>" />--%>
    <asp:Button runat="server" OnClick="btnCreateNewEntry_OnClick" ValidationGroup="<%# ValGroup %>" Text="<%$ Resources: EPiServer, general.add %>" />
</div>
