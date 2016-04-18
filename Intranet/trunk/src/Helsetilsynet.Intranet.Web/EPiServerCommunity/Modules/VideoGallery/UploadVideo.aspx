<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="UploadVideo.aspx.cs" Inherits="EPiServer.Community.Web.Administration.UploadVideo" %>
<%@ Register Assembly="EPiServer.Community.VideoGallery" Namespace="EPiServer.Community.VideoGallery" TagPrefix="sc" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.Title")%></title>
    <link href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/main.css") %>" type="text/css" rel="stylesheet" />
    <link href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
  </head>
  <body id="adminPage">
    <form id="UploadVideo" method="post" runat="server">
        <sc:SaveResultPanel id="saveResultPanel" runat="server" />
        <sc:VideoPostRewriter ID="VideoPostRewriter" runat="server" PostButtonID="buttonUpload" />
		<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
		    <thead>
		        <tr>
		            <th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.Title")%></th>
		        </tr>
		    </thead>
		    <tbody>
		        <tr>
		            <td width="100"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.inputFile")%></td><td><asp:FileUpload ID="fileUpload" runat="server" CssClass="input" Width="250" /></td>
		        </tr>
		        <tr>
		            <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.inputName")%></td><td><asp:TextBox ID="textBoxName" runat="server" CssClass="input" Width="250" /></td>
		        </tr>
		        <tr>
		            <td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.inputDescription")%></td><td><asp:TextBox ID="textBoxDescription" runat="server" CssClass="input" TextMode="MultiLine" Width="250" Height="100" /></td>
		        </tr>
		        <tr>
		            <td align="right" colspan="2">		                
		                <asp:Button ID="buttonUpload" runat="server" CssClass="button" OnClick="ButtonUpload_Click" /><br />
		                <%= EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.UploadVideo.uploadWarning") %>
		            </td>
		        </tr>
		    </tbody>
		</table>
		<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	        <script language="javascript">
		        setTimeout('window.close();', 1000);
	        </script>
        </asp:PlaceHolder>
    </form>
  </body>
</html>