<%@ Control Language="c#" Codebehind="ViewResultEdit.ascx.cs" AutoEventWireup="False" Inherits="Mobiletech.plugins.edit.ViewResultEdit" %>

<!-- TODO: Add markup for the plugin here -->

<h1><EPiServer:Property runat="server" PropertyName="PageName" /></h1>


<iframe id="myIFrame" runat="server" style="width: 280px; height: 450px;">
</iframe>

<h2>URL to feed: </h2><asp:Label ID="feedUrl" runat="server" Text="Label"></asp:Label>