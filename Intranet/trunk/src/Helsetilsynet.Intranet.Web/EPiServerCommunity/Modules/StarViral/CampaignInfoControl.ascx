<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="CampaignInfoControl.ascx.cs"
    Inherits="EPiServer.Community.Web.Administration.CampaignInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI"
    Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript" src="js/StarSuite.js"></script>

<script language="javascript" src="Administration.js"></script>

<script language="javascript">
    SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.Title") %>');
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<div class="campaignInfo">
    <div id="tabStrip">
        <ComponentArt:TabStrip ID="CampaignsTabStrip" CssClass="topGroup" DefaultItemLookId="DefaultTabLook"
            DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook"
            DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
            MultiPageId="CampaignsMultiPage" runat="server">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="InformationTabStripTab" PageViewId="InformationPageView">
                </ComponentArt:TabStripTab>
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="CampaignsMultiPage" CssClass="multiPage" runat="server">
            <ComponentArt:PageView runat="server" ID="InformationPageView">
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <thead>
                        <tr>
                            <th><% = AdministrationUtils.FormatString(CampaignName) %></th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <asp:Button ID="buttonSaveCampaign" runat="server" CssClass="button"></asp:Button><asp:Button
                                ID="buttonDownloadReferrals" runat="server" CssClass="button"></asp:Button>
                        </td>
                    </tr>
                </table>
                <br />
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <thead>
                        <tr>
                            <th colspan="4">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.Header") %>
                            </th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputName") %>:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="textBoxName" runat="server" CssClass="input" MaxLength="250" Width="100%"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validatorName" runat="server" ControlToValidate="textBoxName"
                                Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputDescription") %>:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="textBoxDescription" runat="server" CssClass="input" Width="100%"
                                Height="70" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputStartDate") %>:
                        </td>
                        <td>
                            <asp:Calendar ID="calendarStartDate" runat="server" CssClass="calendar" Width="200"
                                CellSpacing="0" CellPadding="0">
                                <TitleStyle CssClass="title"></TitleStyle>
                                <NextPrevStyle CssClass="title"></NextPrevStyle>
                                <OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
                                <DayStyle CssClass="day"></DayStyle>
                                <DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
                                <SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
                            </asp:Calendar>
                        </td>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputEndDate") %>:
                        </td>
                        <td>
                            <asp:Calendar ID="calendarEndDate" runat="server" CssClass="calendar" Width="200"
                                CellSpacing="0" CellPadding="0">
                                <TitleStyle CssClass="title"></TitleStyle>
                                <NextPrevStyle CssClass="title"></NextPrevStyle>
                                <OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
                                <DayStyle CssClass="day"></DayStyle>
                                <DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
                                <SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
                            </asp:Calendar>
                            <asp:CustomValidator ID="validatorCalendar" runat="server" Display="None" EnableClientScript="False" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputCreator") %>:
                        </td>
                        <td colspan="3">
                            <% if (CreatorUserID > 0)
                               { %><a href="javascript:SCMyPageOpenEditUser(<% = CreatorUserID %>);"><% = AuthorName%></a><% }
                               else
                               {%> <% = AuthorName%><% } %>
                               &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignInfo.inputIsActive") %>:
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="dropDownIsActive" runat="server" CssClass="input" Width="200">
                                <asp:ListItem Value="Active"></asp:ListItem>
                                <asp:ListItem Value="Not Active"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </ComponentArt:PageView>
        </ComponentArt:MultiPage>
    </div>
</div>
<asp:PlaceHolder ID="placeHolderCloseWindow" runat="server" Visible="False">

    <script language="javascript">
        setTimeout('CloseWindow()', 1000);

        function CloseWindow() {
            if (window.opener)
                window.opener.location = 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/StarViral/StarViral.ascx';
            window.close();
        }
    </script>

</asp:PlaceHolder>
