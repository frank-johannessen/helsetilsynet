<%@ Page language="c#" Codebehind="ArticleWithLinksTilsyn.aspx.cs" AutoEventWireup="false" Inherits="development.ArticleWithLinksTilsyn" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<!-- Check if there is a page header saved - if not use page name -->
				<td valign="top" class="title"><%= GetPageName() %>
				</td>
			</tr>
			<tr>
				<td valign="bottom" class="leadtext">
					<DIV class="link">
						<a href="#"><img alt="" src="/images/arrow-red.gif" width="6" height="10" class="arrow-left">Skriv 
							ut denne siden</a><a href="#"></a><BR>
					</DIV>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server" />
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">
		<style>
body {
	background-image: url(/images/bg_list_dot.gif);
}
</style>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body">
					<development:PageBody id="PageBody" runat="server"></development:PageBody>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<IMG alt="" src="/images/arrow.gif" align="absmiddle" border="0">
							</td>
							<td width="100%" valign="top">
								<div class="link"><%# Regex.Replace(((EPiServer.PageBase)Page).CurrentPage.Property["Link"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase)%></div>
							</td>
						</tr>
					</table>
				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links id="Links" runat="server"></development:Links>
				</td>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
