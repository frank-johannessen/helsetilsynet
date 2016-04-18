<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Import Namespace="EPiServer.Common"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="DirectMessageListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.DirectMessageListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
	<tr>
        <th>
			<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.MenuHeader") %>
        </th>
        <th>
			<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.Header") %>: <% = AdministrationUtils.FormatString(Folder.Name) %>
        </th>
    </tr>
	<tr>
		<td class="menu">
			<asp:Button ID="buttonRemoveSelected" Runat="server" CssClass="button" />
			<div class="section"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.Folders") %></div>
			<asp:Repeater ID="repeaterFolders" Runat="server">
				<ItemTemplate>
					<asp:LinkButton ID="linkButtonFolder" Runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="LinkButtonFolder_Command" CssClass="input"><img src="images/folder_small.gif" border="0" />&nbsp;<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Name")) %></asp:LinkButton><br />
				</ItemTemplate>
			</asp:Repeater>
		</td>
		<td class="epi-noPadding">
			<asp:PlaceHolder id="placeHolderDirectMessage" Runat="server">
				<table border="0" cellpadding="2" cellspacing="0" class="epi-default" style="width: 100%">
					<tbody>
						<tr>
							<th colspan="2">&nbsp;</th>
							<th align="left"><asp:LinkButton ID="linkButtonSubject" Runat="server"></asp:LinkButton></th>
							<th align="left"><asp:LinkButton ID="linkButtonFrom" Runat="server"></asp:LinkButton></th>
							<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.Header.Type") %></th>
							<th align="right"><asp:LinkButton ID="linkButtonDateSent" Runat="server"></asp:LinkButton></th>
						</tr>
						<tr runat="server" id="rowPagingTop">
							<td colspan="6"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
						</tr>
						<asp:Repeater ID="repeaterMessages" Runat="server">
							<ItemTemplate>
								<tr>
									<td width="16"><input type="hidden" id="hiddenMessageId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' /><asp:CheckBox ID="checkBoxSelected" Runat="server" /></td>
									<td class="icon"><asp:Image ID="imageReadIcon" Runat="server" ImageUrl='<%# ((((EPiServer.Community.DirectMessage.MessageBase)Container.DataItem).GetRecipient(DirectMessageContainer.User) == null || ((EPiServer.Community.DirectMessage.MessageBase)Container.DataItem).GetRecipient(DirectMessageContainer.User).HasRead) ?  "../../images/readMessage.gif" : "../../images/unreadMessage.gif") %>' Width="16" Height="16" /></td>
									<td><a href="javascript:SCDirectMessageOpenMessageWindow(<%# DataBinder.Eval(Container.DataItem, "ID") %>, <%# Folder.ID %>)"><%# GetMessageSubject((string)DataBinder.Eval(Container.DataItem, "Header")) %></a></td>
									<td><a href="javascript:SCMyPageOpenEditUser(<%# (((UserAuthor)((EPiServer.Community.DirectMessage.MessageBase)Container.DataItem).Author)).User.ID %>)"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(((UserAuthor)((EPiServer.Community.DirectMessage.MessageBase)Container.DataItem).Author), "User.Alias"))%></a></td>
									<td><%# (EPiServer.Community.DirectMessage.MessageBase)Container.DataItem is EPiServer.Community.DirectMessage.SystemMessage ? EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.SystemMessage") : EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.DirectMessageList.Message")%></td>
									<td align="right"><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "SendDate")) %></td>
								</tr>
							</ItemTemplate>
						</asp:Repeater>
						<tr runat="server" id="rowPagingBottom">
							<td colspan="6"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
						</tr>
					</tbody>
				</table>
			</asp:PlaceHolder>
		</td>
	</tr>
</table>