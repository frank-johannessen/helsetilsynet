<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookmarkThisPage.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.BookmarkThisPage" %>

<asp:LinkButton runat="server" ID="btnBookMarkPage" Text="<%$ Resources: EPiServer, bookmarks.bookmarkthispage %>" OnClick="btnBookMarkPage_OnClick" CssClass="action favorite" />
<asp:LinkButton runat="server" ID="btnRemoveBookMarkPage" Text="<%$ Resources: EPiServer, bookmarks.unbookmarkthispage %>" OnClick="btnRemoveBookMarkPage_OnClick" CssClass="action favorite" Visible="False" />