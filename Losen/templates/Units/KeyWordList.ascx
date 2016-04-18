<%@ Control Language="c#" AutoEventWireup="false" Codebehind="KeyWordList.ascx.cs" Inherits="development.templates.UserControls.KeyWordList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table border="0" height="90%" cellpadding="0" cellspacing="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td>
			<table width="440">
				<tr>
					<td nowrap>
						<%# MakeKeywordList()%>
					</td>
					<td nowrap>&nbsp;&nbsp;</td>
					<td nowrap valign="top">
						<asp:Literal id="Result" runat="server"></asp:Literal>
						
						<episerver:PropertySearch PageLink=<%#((EPiServer.PageBase)Page).CurrentPage["MainContainer"]%> runat="server" ID="PropertySearchControl"></episerver:PropertySearch>
					
						<episerver:PageList SortBy="PageName" SortDirection="Ascending" DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
							<ItemTemplate>
								<a href="<%#Container.CurrentPage.LinkURL%>">-- <%#Container.CurrentPage.PageName%></a><br>
							</ItemTemplate>
						</episerver:PageList>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>