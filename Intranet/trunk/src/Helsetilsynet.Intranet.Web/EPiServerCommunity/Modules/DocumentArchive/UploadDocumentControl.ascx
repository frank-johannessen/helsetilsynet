<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UploadDocumentControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.UploadDocumentControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.Upload.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderDocumentUpload" Runat="server">
	<table class="epi-default" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.Upload.Header") %></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.Upload.Header.File") %>:</td>
				<td><input type="file" id="fileDocument" runat="server" class="input" NAME="fileDocument"/><asp:CustomValidator ID="validatorDocument" Runat="server" EnableClientScript="False" ErrorMessage="Invalid document" Display="None" /></td>
			</tr>
			<tr>
				<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.Upload.Header.Description") %>:</td>
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
			    window.opener.__doPostBack('<% = ArchiveControlId %>', '<% = EPiServer.Community.Web.Administration.DocumentArchiveControl.POSTBACK_REFRESH_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>