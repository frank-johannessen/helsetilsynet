<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LargeDocumentChapterNavigation.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Dummy.LargeDocumentChapterNavigation" %>

<div class="doc-nav">
    Bla i dokumentet: 
    <asp:HyperLink runat="server" ID="hlPrevDocLink" Visible="False" />
    <asp:Literal runat="server" ID="ltrPrevNextDocLinkSeparator" Visible="False"> | </asp:Literal>
    <asp:HyperLink runat="server" ID="hlNextDocLink" Visible="False" />
    <asp:Literal runat="server" ID="ltrMainDocLinkSeparator" Visible="False"> | </asp:Literal>
    <asp:HyperLink runat="server" ID="hlMainDocLink2" />
</div>