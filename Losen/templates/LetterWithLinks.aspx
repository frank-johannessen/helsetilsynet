<%@ Page language="c#" Codebehind="LetterWithLinks.aspx.cs" AutoEventWireup="false" Inherits="development.LetterWithLinks" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_Letter_Head.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHeadPrint id="SectionHeadPrint" runat="server"></development:SectionHeadPrint>
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
				<td class="body" valign="top">
<!-- print_start -->
					<br>&nbsp;<br>
					<table width="100%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td valign="top" colspan="2"><b><%# LetterOrNoteTitle() %></b></td>
						</tr>
						<tr>
							<td colspan="2"><DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV></td>
						</tr>
						<tr>
							<td valign="top" colspan="2"><b><episerver:property PropertyName="LangLetterFrom" runat="server" ID="Property1" />: </b><episerver:property PropertyName="LetterFrom" runat="server" ID="Property7" /></td>
						</tr>
						<tr>
							<td colspan="2"><DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV></td>
						</tr>
						<tr>
							<td valign="top" colspan="2"><b><episerver:property PropertyName="LangLetterTo" runat="server" ID="Property2" />: </b><episerver:property PropertyName="LetterTo" runat="server" ID="Property8" /></td>
						</tr>
						<tr>
							<td colspan="2"><DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV></td>
						</tr>
						<tr>
							<td valign="top" colspan="2"><b><episerver:property PropertyName="LangLetterDate" runat="server" ID="Property4" />: </b><%#LetterDate()%></td>
						</tr>
						<tr>
							<td colspan="2"><DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV></td>
						</tr>
						<tr>
							<td width="50%" valign="top"><b><episerver:property PropertyName="LangLetterOure" runat="server" ID="Property5" />: </b><episerver:property PropertyName="LetterOure" runat="server" ID="Property10" /></td>
							<td width="50%" valign="top"><b><episerver:property PropertyName="LangLetterYours" runat="server" ID="Property6" />: </b><episerver:property PropertyName="LetterYours" runat="server" ID="Property11" /></td>
						</tr>
						<tr>
							<td colspan="2"><DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV></td>
						</tr>
					</table>

					<br><br>
<!-- print_end -->
					<development:PageBody id="PageBody" runat="server"></development:PageBody>
				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links id="Links" runat="server"></development:Links>
				</td>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
