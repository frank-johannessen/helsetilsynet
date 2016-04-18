<%@ Control Language="c#" EnableViewState="False" AutoEventWireup="false" Codebehind="LeftMenu.ascx.cs" Inherits="development.UserControls.Menu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!-- <asp:Label ID="test" Runat="server"></asp:Label> -->
<noindex>
<table border="0" cellspacing="0" cellpadding="0" class="leftmenu" width="175" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<% string StartPageStyle = IsStartPage("on","");%>
	<!-- Statisk meny element som linkes til frontpage -->
	<tr valign="top" id="<% = StartPageStyle %>">
		<td width="25"><IMG alt="" src="/images/pxl.gif" width="25" height="1"><BR></td>
		<td width="150" class="off"><div class="HomePageColor"><%#GetPageURL()%></div></td>
	</tr>
	<tr valign="top" class="home"> 
		<td colspan="2" class="hr"><IMG alt="" src="/images/pxl.gif"><BR></td>
	</tr>

	<!-- Liste ut topp meny elementene -->
	<episerver:MenuList ExpandAll="False" PageLink=<%#((EPiServer.PageBase)Page).CurrentPage["MainMenuContainer"]%> runat="server" ID="MenuList1">
		
		<ItemTemplate>
			<% MenuElementCount = MenuElementCount + 1; %>
			<% if (MenuElementCount != 1) {%>
			<tr valign="top" class="parent"> 
				<td colspan="2" class="hr"><IMG alt="" src="/images/pxl.gif"><BR></td>
			</tr>
			<% } %>
			<tr valign="top" class=""> 
				<td width="25"><IMG src="/images/pxl.gif" alt="" width="25" height="1"><BR></td>
				<td width="150" class="off"><a href='<%#Container.CurrentPage.LinkURL%>' title='<%#Container.CurrentPage["PageDescription"]%>' taget='<%#Container.CurrentPage["PageTargetFrame"]%>'><%#Container.CurrentPage.PageName%></a><BR></td>
			</tr>
		</ItemTemplate>
		<SelectedTemplate>
			<% MenuElementCount = MenuElementCount + 1; %>
			<% string HasChildStyle = HasChild("","on");%> <!-- parent skal ikke være gul om det finnes en aktiv child elemnt -->
			<% string DisplayGifIfChildExist = DisplayGif("<IMG src='/images/icon-leftmenu-parent.gif' alt='' class='icon'>","<IMG alt='' src='/images/pxl.gif' width='25' height='1'>");%> <!-- Hvis det ikke finnes child elementer, så skal ikke pil gif vises -->
			<% string DisplayGifIfParentActive = DisplayParentGif("<IMG src='/images/arrow_closed2.gif' alt='' class='icon'>","");%>

			<% if (MenuElementCount != 1) {%>
			<tr valign="top" class="parent"> 
				<td colspan="2" class="hr"><IMG alt="" src="/images/pxl.gif"><BR></td>
			</tr>
			<% } %>
			<tr valign="top" class="parent"> 
				<td><% = DisplayGifIfParentActive %><BR></td>
				<td class="off"><episerver:property PropertyName="PageLink" runat="server" ID="Property4"/></td>
			</tr>
			
			<!-- Liste ut child meny elementene -->
			<episerver:PageTree NumberOfLevels="1" ExpandAll="False" DataSource=<%#MenuList1%> runat="server" ID="Pagetree2">
				<ItemTemplate>
					<%#writemenu(Container.CurrentPage,0)%>
				</ItemTemplate>
				<SelectedItemTemplate>
					<%#writemenu(Container.CurrentPage,1)%>
				</SelectedItemTemplate>
				<expandeditemtemplate>
					<%#writemenu(Container.CurrentPage,1)%>			
				</expandeditemtemplate>
				<selectedexpandeditemtemplate>
					<%#writemenu(Container.CurrentPage,1)%>		
				</selectedexpandeditemtemplate>
			</episerver:PageTree>

		</SelectedTemplate>
	</episerver:MenuList>

</table>
</noindex>