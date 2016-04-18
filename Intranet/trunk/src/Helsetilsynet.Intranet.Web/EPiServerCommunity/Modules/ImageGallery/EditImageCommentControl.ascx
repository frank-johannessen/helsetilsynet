<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditImageCommentControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditImageCommentControl" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>

<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript" src="Administration.js"></script>
<script language="javascript" src="js/StarSuite.js"></script>

<script language="javascript">
    document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageInfo.EditComment.Title") %>'
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<sc:NoEntityError ID="noEntityError" runat="server" />

<asp:Panel ID="mainPanel" runat="server">
<asp:PlaceHolder ID="placeHolderCreateComment" Runat="server">
    <asp:HiddenField ID="hiddenImageCommentId" runat="server" />
	<table class="epi-default" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageInfo.EditComment.Header") %></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageInfo.EditComment.inputEntryTitle") %>:</td>
				<td><asp:TextBox ID="textBoxTitle" Runat="server" CssClass="input" Width="100%" /><asp:RequiredFieldValidator ID="validatorTitle" Runat="server" EnableClientScript="false" ControlToValidate="textBoxTitle" Display="None" /></td>
			</tr>
			<tr>
				<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageInfo.EditComment.inputEntryText") %>:</td>
				<td><asp:TextBox ID="textBoxContent" Runat="server" CssClass="input" TextMode="MultiLine" Rows="20" Columns="77" /><asp:RequiredFieldValidator ID="validatorContent" Runat="server" EnableClientScript="false" ControlToValidate="textBoxContent" Display="None" /></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><asp:Button ID="buttonSave" Runat="server" CssClass="button" OnClick="ButtonSave_Click"/></td>
			</tr>
		</tbody>
	</table>
</asp:PlaceHolder>
</asp:Panel>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
			if(window.opener)
				window.opener.__doPostBack('<% = ImageControlId %>', '<% = EPiServer.Community.Web.Administration.ImageInfoControl.POSTBACK_REFRESH_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>