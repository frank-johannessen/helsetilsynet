<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UploadImageControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.UploadImageControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.UploadImage.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderImageUpload" Runat="server">
	<table class="epi-default" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.UploadImage.Header") %></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.UploadImage.inputFile") %>:</td>
				<td><input type="file" id="fileImage" runat="server" class="input" /><asp:CustomValidator ID="validatorImageFormat" Runat="server" EnableClientScript="False" Display="None" /></td>
			</tr>
			<tr>
				<td valign="top" style="vertical-align: top;"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.UploadImage.inputDescription") %>:</td>
				<td><asp:TextBox ID="textBoxDescription" Runat="server" CssClass="input" TextMode="MultiLine" Rows="5" Columns="50" /></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><asp:Button ID="buttonUpload" Runat="server" CssClass="button" onclick="ButtonUpload_Click" /></td>
			</tr>
		</tbody>
	</table>
	
</asp:PlaceHolder>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
			if(window.opener)
			    window.opener.__doPostBack('<% = GalleryControlId %>', '<% = EPiServer.Community.Web.Administration.ImageGalleryControl.POSTBACK_REFRESH_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>