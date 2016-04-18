<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SiteMap.ascx.cs" Inherits="development.templates.Units.SiteMap" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<img src="/images/pxl.gif" alt="" width="1" height="10" border="0"><br>

<EPiServer:PageList ID="level1" PageLink="<%#((EPiServer.PageBase)Page).CurrentPage.PageLink%>" runat="server">
	<HeaderTemplate>
		<table width="400px" border="0" cellpadding="0" cellspacing="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	</HeaderTemplate>
	<ItemTemplate>
		
		<tr valign="top" class="lvl1">
			<td width="15">&nbsp;</td>
			<td width="370" colspan="3" class="listTitle"><a href="<%#Container.CurrentPage.LinkURL%>"><%#Container.CurrentPage.PageName%></a></td>
			<td width="15">&nbsp;</td>
		</tr>
		<tr valign="top">
			<td colspan="5" class="hr"><img src="/images/pxl.gif" alt="" width="1" height="1" border="0"></td>
		</tr>
		<tr valign="top" class="lvl2">
			<td>&nbsp;</td>

				<EPiServer:PageList ID="level2" PageLink="<%#Container.CurrentPage.PageLink%>" runat="server">
					<ItemTemplate>
						<%#MakeItemList(Container.CurrentPage.PageName,Container.CurrentPage.LinkURL,Container.CurrentPage.VisibleInMenu,(Container.CurrentPage.Property["DummyPage"] != null && Container.CurrentPage.Property["DummyPage"].ToString() != "") ? Container.CurrentPage.Property["DummyPage"].ToString() : "False")%>
					</ItemTemplate>
				</EPiServer:PageList>
				
				<%#MakeTable()%>			
		

			<td width="15">&nbsp;</td>
		</tr>
		<tr valign="top">
			<td colspan="5">&nbsp;</td>
		</tr>

	</ItemTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</EPiServer:PageList>