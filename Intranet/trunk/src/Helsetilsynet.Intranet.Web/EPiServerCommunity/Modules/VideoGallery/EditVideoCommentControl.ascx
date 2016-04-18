<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditVideoCommentControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditVideoCommentControl" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>


<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<script language="javascript" src="Administration.js"></script>
<script language="javascript" src="js/StarSuite.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript">
    document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.EditComment.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderCreateComment" Runat="server">
    <asp:HiddenField ID="hiddenVideoCommentId" runat="server" />
	<table class="epi-default" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.EditComment.Header") %></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.EditComment.inputEntryTitle") %>:</td>
				<td><asp:TextBox ID="textBoxTitle" Runat="server" CssClass="input" Width="100%" /><asp:RequiredFieldValidator ID="validatorTitle" Runat="server" EnableClientScript="false" ControlToValidate="textBoxTitle" Display="None" /></td>
			</tr>
			<tr>
				<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.EditComment.inputEntryText") %>:</td>
				<td><asp:TextBox ID="textBoxContent" Runat="server" CssClass="input" TextMode="MultiLine" Rows="20" Columns="77" /><asp:RequiredFieldValidator ID="validatorContent" Runat="server" EnableClientScript="false" ControlToValidate="textBoxContent" Display="None" /></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><asp:Button ID="buttonSave" Runat="server" CssClass="button"/></td>
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
				window.opener.__doPostBack('<% = VideoControlId %>', '<% = EPiServer.Community.Web.Administration.VideoInfoControl.POSTBACK_REFRESH_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>