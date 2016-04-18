<%@ Register TagPrefix="componentart" Namespace="EPiServer.Common.ComponentArt.Web.UI"
    Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="CalendarControl.ascx.cs"
    Inherits="EPiServer.Community.Web.Administration.CalendarControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI"
    Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" type="text/javascript">
    SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.CalendarDetails") %>');
</script>

<ComponentArt:TabStrip ID="tabStripCalendar" CssClass="topGroup" DefaultItemLookId="DefaultTabLook"
    DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook"
    DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
    MultiPageId="multiPageCalendar" runat="server">
    <ItemLooks>
        <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
        <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
    </ItemLooks>
    <Tabs>
        <ComponentArt:TabStripTab runat="server" ID="tabStripTabCalendarInformation">
        </ComponentArt:TabStripTab>
    </Tabs>
</ComponentArt:TabStrip>
<ComponentArt:MultiPage ID="multiPageCalendar" CssClass="multiPage" runat="server" Width="99%">
    <ComponentArt:PageView runat="server" ID="pageViewCalendarInformation">
        <table cellpadding="0" cellspacing="0" border="0" class="epi-default">
            <tr>
                <td width="100">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.NameLabel") %>
                </td>
                <td>
                    <asp:TextBox ID="textBoxName" runat="server" CssClass="input" Width="200" /><asp:RequiredFieldValidator
                        ID="validatorName" runat="server" Display="None" ControlToValidate="textBoxName" EnableClientScript="false" />
                </td>
                <td align="left">
                    <asp:Button ID="buttonSave" runat="server" CssClass="button" OnClick="ButtonSave_Click" />&nbsp;<span
                        onclick="return document.getElementById('<%= buttonRemove.ClientID %>').disabled || confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.RemoveConfirm") %>')"><asp:Button
                            ID="buttonRemove" runat="server" CssClass="button" OnClick="ButtonRemove_Click" /></span>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <ComponentArt:Calendar ID="calendarControl" runat="server" ClientTarget="Downlevel"
                        ShowNextPrev="True" DayCssClass="day" CalendarCssClass="calendar" MonthPadding="0"
                        MonthSpacing="0" MonthCssClass="month" DayHeaderCssClass="dayHeader label" DayNameFormat="Full"
                        CalendarTitleCssClass="title whitetitle" OtherMonthDayCssClass="otherMonth" AllowDaySelection="False"
                        ShowCalendarTitle="True" PrevText="<" NextText=">">
                    </ComponentArt:Calendar>
                </td>
            </tr>
        </table>
    </ComponentArt:PageView>
</ComponentArt:MultiPage>
<asp:PlaceHolder ID="placeHolderReload" runat="server" Visible="False">

    <script language="javascript" type="text/javascript">
        setTimeout('ReloadCalendar()', 1000);

        function ReloadCalendar() {
            document.location.href = 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Calendar/CalendarControlWrapper.ascx&calendarId=<% = Calendar.ID %>';
        }
    </script>

</asp:PlaceHolder>
<asp:PlaceHolder ID="placeHolderCloseWindow" runat="server" Visible="False">

    <script language="javascript" type="text/javascript">
        setTimeout('window.close()', 1000);
    </script>

</asp:PlaceHolder>
