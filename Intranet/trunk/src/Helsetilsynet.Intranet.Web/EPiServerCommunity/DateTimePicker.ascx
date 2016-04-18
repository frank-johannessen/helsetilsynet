<%@ Control Language="c#" AutoEventWireup="True" Codebehind="DateTimePicker.ascx.cs" Inherits="EPiServer.Community.Web.Administration.DateTimePicker" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<input type="hidden" id="hdnOpenCalendar" runat="server" value="" />
<input type="hidden" id="hdnOpenCalendarTop" runat="server" value="" />
<input type="hidden" id="hdnOpenCalendarLeft" runat="server" value="" />
<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/Js/StarSuite.js") %>"></script>
<script language="javascript">
	EPiServerCommonAddLoadEvent(<% = this.ClientID %>_Init);
		
	function <% = this.ClientID %>_Init()
	{
		var openedCalendar = document.getElementById('<% = hdnOpenCalendar.ClientID %>').value;
		if( openedCalendar != '' ) {
			document.getElementById(openedCalendar).style.display = '';
		}
	}

	function <% = this.ClientID %>_ToggleCalendar(cal, event)
	{
		if(cal.style.display == '') {
			cal.style.display = 'none';
			document.getElementById('<% = hdnOpenCalendar.ClientID %>').value = '';
		}
		else if ( cal.style.display == 'none' ) {
			cal.style.display = '';
			document.getElementById('<% = hdnOpenCalendar.ClientID %>').value = cal.id;
		}

		return false;
	}

</script>

<div>
    <div style="display:none; position: absolute; z-index: 1000; background-color: #fff; border: 1px solid #aaa; padding: 3px; width: 186px; margin: 22px 0 0 -35px;" id="calendarDiv" runat="server">
		    <asp:Calendar ID="calendarDate" OnSelectionChanged="Calendar_SelectionChanged" Runat="server" CssClass="calendar" Width="185" CellSpacing="0" CellPadding="0">
			    <TitleStyle CssClass="title"></TitleStyle>
			    <NextPrevStyle CssClass="title"></NextPrevStyle>
			    <OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
			    <DayStyle CssClass="day"></DayStyle>
			    <DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
			    <SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
		    </asp:Calendar>
            <div style="float: right;padding-top: 3px;">
                 <span runat="server" id="timePicker">
                    <asp:DropDownList ID="dropDownListHour" Runat="server" CssClass="input" />
                    <asp:DropDownList ID="dropDownListMinute" Runat="server" CssClass="input" />
                 </span>
                 <asp:Button ID="buttonOK" Runat="server" CssClass="button" Text="OK" CausesValidation="False" OnClick="ButtonOk_Click" /><asp:Button ID="buttonCancel" runat="server" CssClass="button" Text="Cancel" CausesValidation="false" OnClick="ButtonCancel_Click" />
            </div>
    </div>
    <div style="white-space: nowrap;"><asp:Label ID="labelDate" Runat="server" />&nbsp;<button id="PopupButton" class="button" onclick="return <% = this.ClientID %>_ToggleCalendar(document.getElementById('<% = calendarDiv.ClientID %>'), event);">...</button></div>
</div>
