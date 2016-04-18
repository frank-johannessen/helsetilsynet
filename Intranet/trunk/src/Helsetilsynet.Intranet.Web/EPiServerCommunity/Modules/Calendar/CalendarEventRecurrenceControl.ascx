<%@ Register TagPrefix="uc1" TagName="DateTimePicker" Src="../../DateTimePicker.ascx" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarEventRecurrenceControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarEventRecurrenceControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<tr>
	<td colspan="4"><asp:checkbox id="recurrentEventCheckBox" AutoPostBack="True" Text="Recurrence..." Runat="server" oncheckedchanged="OnRecurrenceCheckedChanged"></asp:checkbox></td>
<tr id="recurrenceProperties" runat="server">
	<td valign="top" rowspan="2"><asp:label id="recurrencePatternLabel" Text="Recurrence pattern:" Runat="server"></asp:label></td>
	<td colspan="3"><asp:radiobuttonlist id="frequencies" AutoPostBack="True" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
			Visible="True" onselectedindexchanged="OnFrequencyChanged"></asp:radiobuttonlist>
		<asp:CustomValidator ID="validatorInterval" Runat="server" Display="None" ErrorMessage="You have to set the recurrence interval" /></td>
</tr>
<tr id="dailyRecurrenceSettings" runat="server" Visible="False">
	<td colspan="3"><asp:radiobutton id="dailyNumericRB" Text="Every" Runat="server" Checked="True" GroupName="dailyRecurrance"></asp:radiobutton>&nbsp;<asp:textbox id="dailyNumericValue" Runat="server" CssClass="input" Width="25"></asp:textbox>&nbsp;<asp:label id="dailyNumericSuffix" Text="day(s)" Runat="server"></asp:label><br>
		<asp:radiobutton id="dailyWeekdayRB" Text="Every weekday" Runat="server" GroupName="dailyRecurrance"></asp:radiobutton></td>
</tr>
<tr id="weeklyRecurrenceSettings" runat="server" Visible="False">
	<td colspan="3">
		<asp:label id="weeklyNumericLabel" Text="Every" Runat="server"></asp:label>&nbsp;
		<asp:textbox id="weeklyNumericValue" Runat="server" CssClass="input" Width="25"></asp:textbox>&nbsp;
		<asp:label id="weeklyNumericLabelSuffix" Text="weeks(s) on:" Runat="server"></asp:label><br>
		<asp:checkboxlist id="weekdaysCB" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"></asp:checkboxlist>
		<asp:CustomValidator ID="validatorWeekdaySelection" Runat="server" Display="None" ErrorMessage="You have to select at least one weekday" /></td>
</tr>
<tr id="monthlyRecurrenceSettings" runat="server" Visible="False">
	<td colspan="3">
		<asp:label id="monthlyNumericLabel" Text="Every" Runat="server"></asp:label>&nbsp;
		<asp:textbox id="monthlyNumericValue" Runat="server" CssClass="input" Width="25"></asp:textbox>&nbsp;
		<asp:label id="monthlyNumericLabelSuffix" Text="month(s)" Runat="server"></asp:label>
	</td>
</tr>
<tr id="yearlyRecurrenceSettings" runat="server" Visible="False">
	<td colspan="3">
		<asp:label id="yearlyNumericLabel" Text="Every" Runat="server"></asp:label>&nbsp;
		<asp:textbox id="yearlyNumericValue" Runat="server" CssClass="input" Width="25"></asp:textbox>&nbsp;
		<asp:label id="yearlyNumericLabelSuffix" Text="year(s)" Runat="server"></asp:label>
	</td>
</tr>
<tr id="recurrenceRange" runat="server">
	<td valign="top" rowspan="2"><asp:label id="recurrenceRangeLabel" Text="Recurrence range:" Runat="server"></asp:label></td>
	<td valign="top" rowspan="2"><asp:label id="recurrenceStartDateLabel" Text="Start date:" Runat="server"></asp:label>&nbsp;<uc1:datetimepicker id="startDatePicker" runat="server"></uc1:datetimepicker></td>
	<td colspan="2">
		<asp:RadioButton ID="recurrenceEndDateRB" Runat="server" Text="End date:" GroupName="RecurrenceEnd"
			Checked="True"></asp:RadioButton>
		<uc1:DateTimePicker id="endDatePicker" runat="server"></uc1:DateTimePicker>
		<asp:CustomValidator ID="validatorDateSpan" Runat="server" Display="None" ErrorMessage="Start date must be before end date." />
    </td>
</tr>
<tr id="recurrenceRangeMaxOccurs" runat="server">
	<td colspan="2">
		<asp:RadioButton ID="recurrenceEndAfterMaxOccurences" Runat="server" Text="End after" GroupName="RecurrenceEnd"></asp:RadioButton>&nbsp;
		<asp:TextBox ID="maxOccurencesTB" Runat="server" Width="25" CssClass="input"></asp:TextBox>
		<asp:CustomValidator ID="validatorEndOccurences" Runat="server" Display="None" ErrorMessage="Maximum number of recurrence occurrences have to be set" />
		<asp:RangeValidator ID="RecuranceCountValidator" runat="server" type="Integer" MinimumValue="1" Display="None" ControlToValidate="maxOccurencesTB" EnableClientScript="false" />
		<asp:Label ID="recurrenceEndAfterMaxOccurencesSuffix" Runat="server" Text="occurences"></asp:Label>
	</td>
</tr>
