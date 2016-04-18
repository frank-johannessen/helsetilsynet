<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarEventInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarEventInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="DateTimePicker" Src="../../DateTimePicker.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ns" TagName="EventRecurrence" Src="CalendarEventRecurrenceControl.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css">
<link rel="stylesheet" type="text/css" href="<%= this.ResolveUrl("~/EPiServerCommunity/Styles/tabstrip.css") %>" />
<script language="javascript" src="Administration.js"></script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<script language="javascript">
	SCSetTitle('Calendar Event Details');
</script>
<div id="tabStrip">

<ComponentArt:TabStrip id="tabStripCalendarEvent" 
		CssClass="topGroup"
		DefaultItemLookId="DefaultTabLook"
		DefaultSelectedItemLookId="SelectedTabLook"
		DefaultDisabledItemLookId="DisabledTabLook"
		DefaultGroupTabSpacing="1"
		ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		MultiPageId="multiPageCalendarEvent"
		runat="server">
		<ItemLooks>
			<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
		</ItemLooks>
		<Tabs>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabEventDetails" PageViewId="pageViewEventDetails" Text="Event Details"></ComponentArt:TabStripTab>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabEventInvites" PageViewId="pageViewEventInvites" Text="Invites"></ComponentArt:TabStripTab>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabEventRegistrations" PageViewId="pageViewEventRegistrations" Text="Registrations"></ComponentArt:TabStripTab>				
		</Tabs>
</ComponentArt:TabStrip>
<ComponentArt:MultiPage id="multiPageCalendarEvent" CssClass="multiPage" runat="server">
	<ComponentArt:PageView runat="server" ID="pageViewEventDetails">
		<table class="epi-default" cellspacing="0" cellpadding="0" border="0">
			<tbody>
				<tr>
					<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Header") %></td>
					<td colspan="3"><asp:TextBox ID="textBoxHeader" Runat="server" CssClass="input" Width="50%" /><asp:RequiredFieldValidator
                        ID="validatorHeader" runat="server" Display="None" ControlToValidate="textBoxHeader" EnableClientScript="false" /></td>
				</tr>
				<tr>
					<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Description") %></td>
					<td colspan="3"><asp:TextBox ID="textBoxBody" Runat="server" CssClass="input" TextMode="MultiLine" Width="50%" Height="100" /></td>
				</tr>
				<tr id="eventStartEndDateRow">
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.StartDate") %></td>
					<td width="160"><sc:DateTimePicker runat="server" id="dateTimePickerStartDate" /></td>
					<td width="80" align="right"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.EndDate") %></td>
					<td><sc:DateTimePicker runat="server" ID="dateTimePickerEndDate" /><asp:CustomValidator ID="validatorDateSpan" Display="None" Runat="server" /></td>
				</tr>
				<ns:EventRecurrence runat="server" id="eventRecurrenceControl"/>
				
				
				<tr>
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Arranger") %></TD>
					<td colspan="3"><asp:textbox id="textBoxArranger" CssClass="input" Runat="server" Width="50%"></asp:textbox></TD>
				</tr>
				<tr>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Place") %></td>
					<td colspan="3"><asp:TextBox ID="textBoxPlace" Runat="server" CssClass="input" Width="50%" /></td>
				</tr>
				<tr>
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.MaximumRegistrations") %></TD>
					<td colspan="3"><asp:textbox id="textBoxMaxNumRegistrations" CssClass="input" Runat="server" Width="90" Text="0"></asp:textbox>&nbsp;0 = Unlimited
					<asp:RequiredFieldValidator ID="validatorMaxNumRegistrations" Runat="server" Display="None" ControlToValidate="textBoxMaxNumRegistrations" ErrorMessage="Max. registrations must be a numeric value" EnableClientScript="False" />
					<asp:RangeValidator ID="MaxNumberOfRegistrationsValidator" runat="server" type="Integer" Display="None" MinimumValue="0" MaximumValue="2147483647" ControlToValidate="textBoxMaxNumRegistrations" EnableClientScript="False" />
					</td>
				</tr>
				<tr>
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.RegStartDate") %></td>
					<td width="150"><sc:DateTimePicker runat="server" id="dateTimePickerRegStartDate" />
					    <asp:CustomValidator ID="validatorStartRegDateSpan" Display="None" runat="server" />
					</td>
					<td width="120" align="right"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.RegEndDate") %></td>
					<td width="150"><sc:DateTimePicker runat="server" ID="dateTimePickerRegEndDate" />
					    <asp:CustomValidator ID="validatorRegDateSpan" Display="None" Runat="server" />
					    <asp:CustomValidator ID="validatorEndRegDateSpan" Display="None" runat="server" />
					    <br /><asp:Button ID="buttonClearRegDate" Runat="server" CssClass="button" Text="Clear" /></td>
				</tr>
				<tr>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Published") %></td>
					<td colspan="3"><asp:CheckBox ID="checkBoxPublished" Runat="server" /></td>
				</tr>
				<tr>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Hidden") %></td>
					<td colspan="3"><asp:CheckBox ID="checkBoxHidden" Runat="server" /></td>
				</tr>
				<tr>
					<td valign="top" class="topTd"><asp:Label ID="labelImageFile" Runat="server"></asp:Label></td>
					<td valign="top">
						<input type="file" id="fileEventImage" class="input" runat="server">&nbsp;<asp:CheckBox ID="checkBoxRemoveImage" Runat="server" CssClass="input" />
					</td>
					<td align="right" colspan="2">
						<asp:Image ID="imageEvent" Runat="server" ImageUrl="~/EPiServerCommunity/Images/NoImage.gif" />
						<asp:CustomValidator ID="validatorImageFormat" Runat="server" EnableClientScript="False" Display="None" /><br>
					</td>
				</tr>
				<tr>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.SecurityStatus") %></td>
					<td colspan="3">
						<asp:DropDownList id="dropDownListSecurityStatus" Runat="server" CssClass="input" Width="50%">
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="right"><asp:Button ID="buttonSaveEvent" Runat="server" CssClass="button" Text='Save Event' />&nbsp;<span id="removeEventSpan" runat="server"><asp:Button ID="buttonRemoveEvent" Runat="server" CssClass="button" Text="Remove Event" CausesValidation="False" /></span></td>
				</tr>
			</TBODY>
		</TABLE>
	</ComponentArt:PageView>
	<ComponentArt:PageView runat="server" ID="pageViewEventInvites"></ComponentArt:PageView>
	<ComponentArt:PageView runat="server" ID="pageViewEventRegistrations"></ComponentArt:PageView>
</ComponentArt:MultiPage>
</div>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
			if(window.opener)
			    window.opener.__doPostBack('<% = CalendarControlId %>', '');
			window.close();
		}
	</script>
</asp:PlaceHolder>
<asp:PlaceHolder ID="placeHolderReloadWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('ReloadWindow()', 1000);
		
		function ReloadWindow()
		{
			if(window.opener)
			    window.opener.__doPostBack('<% = CalendarControlId %>', '');

			document.location.href = 'ControlWrapper.aspx?control=~/EPiServerCommunity/Modules/Calendar/CalendarEventInfoControl.ascx&eventId=<% = Event.ID %>&calendarControlId=<% = CalendarControlId %>';
		}
	</script>
</asp:PlaceHolder>