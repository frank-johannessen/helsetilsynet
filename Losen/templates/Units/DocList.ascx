<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DocList.ascx.cs" Inherits="development.UserControls.DocList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<br>
<episerver:newslist SortOrder="<%#GetSortOrder()%>" id="NewsList" PageLinkProperty="DocList" MaxCount=<%#GetCount()%> runat="server">
	<HeaderTemplate>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
	</HeaderTemplate>
	<NewsTemplate>
			<tr>
				<td valign=top>
					<IMG src="/images/arrow.gif" alt="" align=absmiddle border="0">
				</td>
				<td width="100%">
					<DIV class="link">
						<%# Container.CurrentPage["Link"] != null ? Regex.Replace(Container.CurrentPage.Property["Link"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase) : ""%>&nbsp;<%#Container.CurrentPage["DocType"] != null ? "(" +  Container.CurrentPage["DocType"] + ")": ""%><br>
						<%#Container.CurrentPage["MainIntro"]%>
					</DIV><br>
				</td>	
			</tr>		
	</NewsTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</episerver:newslist>
