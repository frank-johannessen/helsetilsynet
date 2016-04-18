<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Calendar.ascx.cs" Inherits="development.templates.Units.Calendar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table width="590" height="90%" cellpadding="0" cellspacing="0" class="Article" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr valign="top">
		<td class="body">
			<table class="article" cellSpacing="0" cellPadding="0" width="345" border="0">
				<tr>
					<td vAlign="bottom">
						<episerver:calendar
							id="calendarList" 
							runat="server" 
							NumberOfDaysToRender=<%#((EPiServer.PageBase)Page).CurrentPage["nDaysToRender"]%> 
							PageLinkProperty="CalendarContainer" 
							PageTypeID=<%#((EPiServer.PageBase)Page).CurrentPage["CalendarType"]%>
							ExpandAllDays = "False"
						>
							<DayPrefixTemplate>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td height="25" valign="middle">
										<div><%#Container.DayName%></i>, <%#Container.DayOfMonth%> <%#Container.MonthName%><i>
										<br>
										<hr>
										</div>
										</td>
									</tr>
									<tr>
										<td valign="bottom">
							</DayPrefixTemplate>
							<EventTemplate>
								<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
									
										<tr>
											<td width="60%">
												<a href="<%#Container.CurrentPage.LinkURL%>" class="link"><%#Container.CurrentPage.PageName%></a>
											</td>
											<td width="40%" align="right">
												<%#Container.StartTime%>&nbsp;-&nbsp;
												<%#Container.StopTime%>
											</td>
										</tr>
									
								</table>
							</EventTemplate>
							<DaySuffixTemplate>
											<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
											<tr>
												<td >
													<br />
													<br />
												</td>
											</tr>
											</table>
										</td>
									</tr>
								</table>
							</DaySuffixTemplate>
						</episerver:calendar>
					</td>
				</tr>
			</table>
		</td>
		<td align="right">
		<br>
			<asp:Calendar 
				id="monthCalendar" 
				runat="server" 
				SelectionMode="DayWeekMonth" 
				CellSpacing="1" 
				BackColor="#FFFFFFF" 
				NextMonthText="+" 
				PrevMonthText="-" 
				DayHeaderStyle-CssClass="dayWeekHeader" 
				OtherMonthDayStyle-CssClass="dateCellOtherMonth" 
				DayStyle-CssClass="dateCellInactive"
				SelectedDayStyle-CssClass="selectedDateCell"
				WeekendDayStyle-CssClass="weekendCell"
				BorderColor="#000000"
				BorderWidth="1"
			>
			</asp:Calendar>			
		</td>
	</tr>
</table>