<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="EditRoomControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditRoomControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<div id="forum">
<asp:Panel ID="panelEditRoom" Runat="server">
<table width="100%">
<tr>
	<td><asp:Button ID="buttonSave" Runat="server" CssClass="button" />&nbsp;
		<button class="button" <% if (m_room.ID == -1 || !m_accessRights.Administrate) { %>disabled<% } %> onclick="SCForumOpenRoomWindow(document.getElementById('<% = hiddenRoomId.ClientID %>').value, null, '<%= this.ResolveUrl("~/EPiServerCommunity/") %>')"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.EditRoom.buttonModerateRoom") %></button>
		<span onclick="if(document.getElementById('<% = hiddenRoomId.ClientID %>').value != -1) return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.EditRoom.SpanConfirmRemoveRoom") %>');"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" /></span>
		<button id="buttonAccessRights" class="button" <% if (m_room.ID == -1 || !m_accessRights.Administrate) { %>disabled<% } %> onclick="SCOpenAccessRights('EPiServer.Community.Forum.Security.RoomAccessRights,EPiServer.Community.Forum', '<% = m_room.ID %>','<%= this.ResolveUrl("~/EPiServerCommunity/") %>'); return false;"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.EditRoom.buttonAccessRights") %></button>
	</td>
</tr>
</table>
	<div id="tabStrip" class="epi-marginVertical-small">
		<input type="hidden" runat="server" id="hiddenRoomId" />
		<ComponentArt:TabStrip id="tabStripForumRoom" 
			CssClass="subGroup"
			DefaultItemLookId="DefaultTabLook"
			DefaultSelectedItemLookId="SelectedTabLook"
			DefaultDisabledItemLookId="DisabledTabLook"
			DefaultGroupTabSpacing="0"
			ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
			MultiPageId="multiPageForumRoom"
			runat="server"
			EnableViewState="false">
			<ItemLooks>
				<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="DefaultTab" HoverCssClass="DefaultTabHover" />
				<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="SelectedTab"  />
			</ItemLooks>
			<Tabs>
			    <ComponentArt:TabStripTab ID="TabDetails" runat="server" />
			</Tabs>
		</ComponentArt:TabStrip>
		<ComponentArt:MultiPage id="multiPageForumRoom" CssClass="MultiPage" runat="server" EnableViewState="false">
			<ComponentArt:PageView  runat="server" ID="pageViewContent">
				<table border="0" width="100%" cellpadding="0" cellspacing="0" class="epi-default">
					<tr>
						<td width="100"><asp:Label ID="labelName" Runat="server"></asp:Label></td><td><asp:TextBox ID="textBoxName" Runat="server" CssClass="input" Width="300"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="validatorName" runat="server" ControlToValidate="textBoxName" EnableClientScript="False" Display="None" /></td>
					</tr>
					<tr>
						<td valign="top"><asp:Label ID="labelDescription" Runat="server"></asp:Label></td><td><asp:TextBox ID="textBoxDescription" Runat="server" CssClass="input" TextMode="MultiLine" Height="100" Width="300"></asp:TextBox></td>
					</tr>
					<tr>
						<td><asp:Label ID="labelMode" Runat="server"></asp:Label></td><td><asp:RadioButtonList ID="radioButtonListMode" Runat="server" CssClass="input" RepeatDirection="Horizontal"></asp:RadioButtonList></td>
					</tr>
					<tr>
						<td><asp:Label ID="labelTraceMove" Runat="server"></asp:Label></td><td><asp:RadioButtonList ID="radioButtonListTraceMove" Runat="server" CssClass="input" RepeatDirection="Horizontal"></asp:RadioButtonList></td>
					</tr>
					<tr>
						<td colspan="2" align="right"></td>
					</tr>
				</table>
			</ComponentArt:PageView>
		</ComponentArt:MultiPage>
	</div>
</asp:Panel>
</div>