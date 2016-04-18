<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CreateBlogEntryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CreateBlogEntryControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.CreateEntry.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<sc:NoEntityError runat="server" ID="NoEntityError"  />
<asp:PlaceHolder ID="placeHolderCreateEntry" Runat="server">
	<table class="epi-default" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.CreateEntry.Header") %></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.CreateEntry.inputEntryTitle") %>:</td>
				<td><asp:TextBox ID="textBoxTitle" Runat="server" CssClass="input" Width="95%" /><asp:RequiredFieldValidator ID="validatorTitle" Runat="server" EnableClientScript="false" ControlToValidate="textBoxTitle" Display="None" /></td>
			</tr>
			<tr>
				<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.CreateEntry.inputEntryText") %>:</td>
				<td><asp:TextBox ID="textBoxContent" Runat="server" CssClass="input" TextMode="MultiLine" Width="95%" Rows="20" Columns="77" /></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><asp:Button ID="buttonSave" Runat="server" CssClass="button" /></td>
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
			    window.opener.__doPostBack('<% = BlogControlId %>', '<% = EPiServer.Community.Web.Administration.BlogControl.POSTBACK_REFRESH_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>