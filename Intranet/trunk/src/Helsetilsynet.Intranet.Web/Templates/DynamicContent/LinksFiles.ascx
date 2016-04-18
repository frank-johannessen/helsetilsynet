<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinksFiles.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.LinksFiles" %>
<asp:Repeater runat="server" ID="rptFiles">
    <ItemTemplate>
        <p><a href="<%# System.IO.Path.Combine(FolderBrowser.Value.ToString(), Container.DataItem.ToString()) %>"><%# Container.DataItem %></a></p>
    </ItemTemplate>
</asp:Repeater>