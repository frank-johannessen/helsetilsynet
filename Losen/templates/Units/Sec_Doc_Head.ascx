<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" EnableViewState="False" AutoEventWireup="false" Codebehind="Sec_Doc_Head.ascx.cs" Inherits="development.UserControls.ContentDocHead" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="development" TagName="BreadCrumbs"		Src="~/templates/Units/BreadCrumbs.ascx"%>
<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<!-- Check if there is a page header saved - if not use page name -->
		<td valign="top"><div class="breadbrumb"><development:BreadCrumbs runat="server" ID="breadcrumb"/></div>
		<div class="<%#GetPageNameSize()%>"><%# GetPageName() %></div></td>
	</tr>
</table>
