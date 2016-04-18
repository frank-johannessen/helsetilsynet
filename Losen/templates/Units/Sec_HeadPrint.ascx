<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" EnableViewState="False" AutoEventWireup="false" Codebehind="Sec_HeadPrint.ascx.cs" Inherits="development.UserControls.Sec_HeadPrint" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="development" TagName="BreadCrumbs"		Src="~/templates/Units/BreadCrumbs.ascx"%>
<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<!-- Check if there is a page header saved - if not use page name -->
		<td valign="top">
			<div class="breadbrumb"><development:BreadCrumbs runat="server" ID="breadcrumb" /></div>
			<div class="<%#GetPageNameSize()%>">
				<!-- print_start -->
				<span class="PrintTitle">
					<%= GetPageName() %>
				</span>
			</div>
			<!-- print_end -->
		</td>
	</tr>
	<tr>
		<td valign="bottom" class="leadtext">
			<%if(((EPiServer.PageBase)Page).CurrentPage["MainIntro"] != null) {%>
			<!-- print_start -->
			<br>
			<div class="PrintIntro">
				<episerver:property PropertyName="MainIntro" runat="server" ID="Property1" />
			</div>
			<!-- print_end -->
			<%}%>
			<DIV class="link">
				<a href="javascript:void(window.open('/templates/PrintPage.aspx?id=<%#((EPiServer.PageBase)Page).CurrentPage.PageLink.ID.ToString()%>&amp;url=<%=Request.Url%>', 'popupSKRIVUT', 'width=640,height=480,scrollbars,resizable,status'));">
				<img src="/images/print.gif" alt="Print" class="arrow-left"><episerver:property PropertyName="PrintText" runat="server" ID="Property2" /></a>
			</DIV>
		</td>
	</tr>
</table>
