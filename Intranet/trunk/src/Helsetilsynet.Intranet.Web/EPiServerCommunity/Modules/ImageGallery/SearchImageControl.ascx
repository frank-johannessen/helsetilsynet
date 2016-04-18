<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SearchImageControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SearchImageControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="ImageListControl" Src="ImageListControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<asp:RegularExpressionValidator ID="validatorImageID" Runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxSearchID" ValidationExpression="[0-9]{1,}" ></asp:RegularExpressionValidator>
<asp:CustomValidator ID="dateValidator" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
<tr>
	<th valign="top" colspan="6">
	    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.Header") %>
	</th>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputName") %>:</td>
	<td><asp:TextBox ID="textBoxSearchImageName" Runat="server" Width="120" CssClass="input"></asp:TextBox></td>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputDescription") %>:</td>
	<td><asp:TextBox ID="textBoxSearchDescription" Runat="server" Width="120" CssClass="input"></asp:TextBox></td>	
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputUploaderAlias") %>:</td>
	<td><asp:TextBox ID="textBoxSearchAlias" Runat="server" Width="120" CssClass="input"></asp:TextBox></td>	
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputCategory") %>:</td>
	<td><asp:DropDownList ID="dropDownCategories" Runat="server" CssClass="input"></asp:DropDownList></td>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputID") %>:</td>
	<td><asp:TextBox ID="textBoxSearchID" Runat="server" Width="120" MaxLength="9" CssClass="input"></asp:TextBox></td>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputUploadDate") %>:</td>
	<td colspan="5">
		<asp:DropDownList ID="dropDownListUploadDateYearStart" Runat="server" CssClass="input" />
		-
		<asp:DropDownList ID="dropDownListUploadDateMonthStart" Runat="server" CssClass="input" />
		-
		<asp:DropDownList ID="dropDownListUploadDateDayStart" Runat="server" CssClass="input" />
		&nbsp;
		<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.SearchImage.inputUploadDateAnd") %> 
		&nbsp;
		<asp:DropDownList ID="dropDownListUploadDateYearEnd" Runat="server" CssClass="input" />
		-
		<asp:DropDownList ID="dropDownListUploadDateMonthEnd" Runat="server" CssClass="input" />
		-
		<asp:DropDownList ID="dropDownListUploadDateDayEnd" Runat="server" CssClass="input" /></td>
</tr>
<tr>
	<td valign="top" colspan="6" align="right"><asp:Button ID="buttonSearchImages" Runat="server" CssClass="button"></asp:Button></td>
</tr>
</table>

<br />

<asp:Panel ID="panelImagesSearchResult" Runat="server" Visible="False">
	<sc:ImageListControl id="imageListControl" runat="server" />
</asp:Panel>
