<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="PollControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.PollControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<% if ( this.PollDisplayMode == EPiServer.Community.Web.Administration.PollControl.DisplayMode.Polls ) { %>
<div class="poll">
<% } %>
	<asp:CheckBox ID="checkBoxSelected" Runat="server" />
	<asp:HyperLink ID="titleViewHref" Runat="server" Visible="False"></asp:HyperLink>
	<asp:Repeater ID="repeaterChoices" runat="server">
		<HeaderTemplate>
			<asp:Label ID="labelPoll" Runat="server" CssClass="label">
				<a href="javascript:SCPollOpenPollInfo(<%# Poll.ID %>, '<% = ModuleUniqueName %>', '<% = ClubID %>', '<% = MyPageID %>', '<% = PollListControlID %>');">
					<strong>
						<%# AdministrationUtils.FormatString(Poll.Body) %>
					</strong></a>
			</asp:Label>
		</HeaderTemplate>
		<ItemTemplate>
			<br />
			<asp:Label ID="labelChoice" Runat="server" CssClass="label">
				<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Text")) %>
			</asp:Label><br />
			<div class="choiceBg"><div class="choice" style="width: <%#GetChoiceWidth((EPiServer.Community.Poll.Choice)Container.DataItem) %>%" title="<%#GetChoiceWidth((EPiServer.Community.Poll.Choice)Container.DataItem) %>%"><%#GetChoiceWidthLabel((EPiServer.Community.Poll.Choice)Container.DataItem) %></div>
			</div>
		</ItemTemplate>
	</asp:Repeater>
<% if ( this.PollDisplayMode == EPiServer.Community.Web.Administration.PollControl.DisplayMode.Polls ) { %>
</div>
<% } %>
