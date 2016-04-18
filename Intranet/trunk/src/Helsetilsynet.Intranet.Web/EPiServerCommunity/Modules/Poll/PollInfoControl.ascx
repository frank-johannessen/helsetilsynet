<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="PollInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.PollInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.Title") %>'
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<ComponentArt:TabStrip ID="tabStripPoll" CssClass="topGroup" DefaultItemLookId="DefaultTabLook"
    DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook"
    DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
    MultiPageId="multiPagePoll" runat="server">
    <ItemLooks>
        <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
        <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
    </ItemLooks>
    <Tabs>
        <ComponentArt:TabStripTab runat="server" ID="tabStripTabCalendarInformation">
        </ComponentArt:TabStripTab>
    </Tabs>
</ComponentArt:TabStrip>
<ComponentArt:MultiPage ID="multiPagePoll" CssClass="multiPage" style="width:100%" runat="server">
    <ComponentArt:PageView runat="server" ID="pageViewPollInformation">

<asp:Panel ID="panelMain" runat="server">
<div class="pollInfo">

<asp:Panel ID="panelPoll" Runat="server">

<table cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th><% = AdministrationUtils.FormatString(PollName) %></th>
</tr>
</thead>
<tr>
	<td>
	    <asp:Button ID="buttonSavePoll" Runat="server" CssClass="button"/>
	    <asp:PlaceHolder ID="placeHolderRemove" runat="server"> 
	        &nbsp;<span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.PollInfo.RemovePoll.confirm") %>');"><asp:Button ID="buttonRemove" Runat="server" OnCommand="ButtonRemove_Command" CssClass="button"/></span>
	    </asp:PlaceHolder>
	</td>
</tr>

</table>

<br />

<table cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th colspan="4"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.PollInformation") %></th>
</tr>
</thead>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.inputName") %>:</td>
	<td colspan="3"><asp:TextBox ID="textBoxPollText" Runat="server" CssClass="input" MaxLength="250" Width="50%"></asp:TextBox>
		<asp:RequiredFieldValidator ID="validatorPollText" Runat="server" ControlToValidate="textBoxPollText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator></td>
</tr>
<tr>
	<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.inputStartDate") %>:</td>
	<td>
		<asp:Calendar ID="calendarStartDate" Runat="server" CssClass="calendar" Width="200" CellSpacing="0" CellPadding="0">
			<TitleStyle CssClass="title"></TitleStyle>
			<NextPrevStyle CssClass="title"></NextPrevStyle>
			<OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
			<DayStyle CssClass="day"></DayStyle>
			<DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
			<SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
		</asp:Calendar></td>
	<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.inputEndDate") %>:</td>
	<td>
		<asp:Calendar ID="calendarEndDate" Runat="server" CssClass="calendar" Width="200" CellSpacing="0" CellPadding="0">
			<TitleStyle CssClass="title"></TitleStyle>
			<NextPrevStyle CssClass="title"></NextPrevStyle>
			<OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
			<DayStyle CssClass="day"></DayStyle>
			<DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
			<SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
		</asp:Calendar><asp:CustomValidator ID="validatorCalendar" Runat="server" Display="None" EnableClientScript="False" /></td>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.ActiveLabel")%>:</td>
	<td colspan="3">
		<asp:DropDownList ID="dropDownIsActive" Runat="server" CssClass="input" Width="200">
			<asp:ListItem Value="Active"></asp:ListItem>
			<asp:ListItem Value="Not Active"></asp:ListItem>
		</asp:DropDownList></td>
</tr>
</table>

</asp:Panel>

<br />

<table cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th colspan="5"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.PollChoices") %></th>
</tr>
</thead>
<tr>
	<td colspan="5" align="right"><asp:Button ID="buttonSaveNewChoice" Runat="server" CssClass="button"></asp:Button></td>
</tr>
	
<asp:DataList ID="dataListPollChoices" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID" 
OnDeleteCommand="dataListPollChoices_DeleteCommand" OnItemCommand="dataListPollChoices_MoveCommand">
	<HeaderTemplate>
	<tr>
		<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.Header.Text") %></th>
		<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.Header.Votes") %></th>
		<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.Header.DisplayOrder") %></th>
		<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollInfo.Header.Percentage") %></th>
		<th>&nbsp;</th>
	</tr>
	</HeaderTemplate>
	<ItemTemplate>
	<tr>
		<td><asp:TextBox ID="textBoxChoiceText" Runat="server" CssClass="input" Width="200" MaxLength="250" Text='<%# DataBinder.Eval(Container.DataItem, "Text") %>'></asp:TextBox>
			<input type="hidden" runat="server" id="hiddenChoiceID" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' NAME="hiddenChoiceID"/>
			<asp:RequiredFieldValidator ID="validatorNewChoiceText" Runat="server" ControlToValidate="textBoxChoiceText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator><asp:Panel ID="panelValidateNewChoice" Runat="server" Visible="False"></asp:Panel></td>
		<td><%# GetOpenVotes((int)DataBinder.Eval(Container.DataItem, "VoteCount"), (int)DataBinder.Eval(Container.DataItem, "ID")) %></td>
		<td><asp:ImageButton ID="imageButtonMoveUp" CommandName="MoveUp" Runat="server" ImageUrl="../../Images/scrollup.gif" Width="16" Height="16"></asp:ImageButton>
			<asp:ImageButton ID="imageButtonMoveDown" CommandName="MoveDown" Runat="server" ImageUrl="../../Images/scrolldown.gif" Width="16" Height="16"></asp:ImageButton>&nbsp;</td>
		<td><div class="choiceBg"><div class="choice" style="width: <%# GetChoiceWidth((EPiServer.Community.Poll.Choice)Container.DataItem) %>%" title="<%# GetChoiceWidth((EPiServer.Community.Poll.Choice)Container.DataItem) %>%"><%# GetChoiceWidthLabel((EPiServer.Community.Poll.Choice)Container.DataItem) %></div></div></td>
		<td align="right"><asp:Button ID="buttonDeleteChoice" Runat="server" CssClass="button" CommandName="Delete"></asp:Button></td>
	</tr>
	</ItemTemplate>
</asp:DataList>

</table>

</div>
</asp:Panel>

</ComponentArt:PageView>
</ComponentArt:MultiPage>

<asp:PlaceHolder ID="placeHolderReload" runat="server" Visible="False">

    <script language="javascript" type="text/javascript">
        setTimeout('ReloadPoll()', 1000);
        setTimeout('ReloadPollList()', 1000);

        function ReloadPoll() {
            document.location.href = 'ControlWrapper.aspx?control=Modules/Poll/PollInfoControl.ascx&clubId=-1&myPageId=-1&pollId=<% = PollID %>&pollListControlId=<% = PollListControlID %>';
        }
        
        function ReloadPollList() {
            if (window.opener)
                window.opener.__doPostBack('<% = PollListControlID %>', '<% = EPiServer.Community.Web.Administration.PollListControl.POSTBACK_REFRESH_ARGUMENT %>');
        }
    </script>

</asp:PlaceHolder>

<sc:NoEntityError runat="server" ID="NoEntityError" />