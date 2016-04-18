<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="ContestInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ContestInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>

<script language="javascript" src="Administration.js"></script>

<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript">
    document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Title") %>';
</script>

<script type="text/javascript">
    function confirm_delete() {
        if (confirm("Are you sure you want to remove this question?") == true)
            return true;
        else
            return false;
    }

    var RefreshQuestionsList = function() {
        <%=Page.ClientScript.GetPostBackEventReference(this, POSTBACK_REFRESH_ARGUMENT) %>;
    }
</script>	

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<sc:NoEntityError runat="server" ID="NoEntityError" />
<asp:Panel ID="panelMain" runat="server">
    <div id="tabStrip">
        <ComponentArt:TabStrip ID="tabStripContest" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageContest" runat="server">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabContestDetails" PageViewId="pageViewEditClubInfo">
                </ComponentArt:TabStripTab>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabContestQuestions" PageViewId="pageviewQuestions">
                </ComponentArt:TabStripTab>
                <ComponentArt:TabStripTab runat="server" ID="tabstripTabContestSubmissions" PageViewId="pageviewSubmissions">
                </ComponentArt:TabStripTab>
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="multiPageContest" CssClass="multiPage" runat="server">
            <ComponentArt:PageView runat="server" ID="pageViewEditClubInfo">
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <thead>
                        <tr>
                            <th><% = AdministrationUtils.FormatString(ContestName) %></th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <asp:Button ID="buttonSave" runat="server" CssClass="button"></asp:Button>
                        </td>
                    </tr>
                </table>
                <br />
            
                <table class="epi-default" cellspacing="0" cellpadding="0">
                    <thead>
                        <tr>
                            <th colspan="4">
                                 <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Header") %>
                            </th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.inputName") %>:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="textBoxContestName" runat="server" Width="500" MaxLength="400" CssClass="input"></asp:TextBox><asp:RequiredFieldValidator ID="validatorText" runat="server" ControlToValidate="textBoxContestName" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.inputDescription") %>:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="textBoxDescription" runat="server" Width="500" Height="80" CssClass="input" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.inputStartDate") %>:
                        </td>
                        <td>
                            <asp:Calendar ID="calendarStartDate" runat="server" CssClass="calendar" Width="200" CellSpacing="0" CellPadding="0">
                                <TitleStyle CssClass="title"></TitleStyle>
                                <NextPrevStyle CssClass="title"></NextPrevStyle>
                                <OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
                                <DayStyle CssClass="day"></DayStyle>
                                <DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
                                <SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
                            </asp:Calendar>
                            
                        </td>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.inputEndDate") %>:
                        </td>
                        <td>
                            <asp:Calendar ID="calendarEndDate" runat="server" CssClass="calendar" Width="200" CellSpacing="0" CellPadding="0">
                                <TitleStyle CssClass="title"></TitleStyle>
                                <NextPrevStyle CssClass="title"></NextPrevStyle>
                                <OtherMonthDayStyle CssClass="otherMonth"></OtherMonthDayStyle>
                                <DayStyle CssClass="day"></DayStyle>
                                <DayHeaderStyle CssClass="dayHeader"></DayHeaderStyle>
                                <SelectedDayStyle CssClass="selectedDay"></SelectedDayStyle>
                            </asp:Calendar>
                            <asp:CustomValidator runat="server" ID="datesValidator" OnServerValidate="ValidateDates" Display="None" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.inputImage") %>:
                        </td>
                        <td valign="top">
                            <input class="file" id="fileImage" type="file" name="fileImage" runat="server">&nbsp;
                            <asp:CustomValidator ID="imageFileValidator" runat="server" Display="None" EnableClientScript="False" ControlToValidate="fileImage"></asp:CustomValidator>
                            <asp:CheckBox ID="checkBoxRemoveImage" runat="server" CssClass="input" Visible="False"></asp:CheckBox>
                        </td>
                        <td colspan="2">
                            <asp:Image ID="contestImage" runat="server"></asp:Image>
                        </td>
                    </tr>
                    <asp:PlaceHolder ID="placeHolderRemove" runat="server">
                        <tr>
                            <td align="right" colspan="4">
                                <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ContestInfo.RemoveContest.confirm") %>');">
                                    <asp:Button ID="buttonRemove" runat="server" OnCommand="ButtonRemove_Command" CssClass="button" /></span>
                            </td>
                        </tr>
                    </asp:PlaceHolder>
                </table>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" ID="pageviewQuestions">
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <tr>
                        <td class="epi-noPadding">
                            <table class="epi-default" cellpadding="0" cellspacing="0" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.labelAddNewQuestion") %></th>
                                        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.HeaderQuestions") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="menu">
                                            <asp:Panel ID="panelAddQuestion" runat="server">
                                                <button class="button" onclick="SCContestOpenQuestion('', <%= ContestID %>, '<%= typeof(EPiServer.Community.Contest.TextQuestion) %>')">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.Text") %>
                                                </button>
                                                <br />
                                                <button class="button" onclick="SCContestOpenQuestion('', <%= ContestID %>, '<%= typeof(EPiServer.Community.Contest.SingleAlternativeQuestion) %>');">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.SingleAlt") %>
                                                </button>
                                                <br />
                                                <button class="button" onclick="SCContestOpenQuestion('', <%= ContestID %>, '<%= typeof(EPiServer.Community.Contest.MultipleAlternativeQuestion) %>');">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.MultipleAlt") %>
                                                </button>
                                            </asp:Panel>
                                            <asp:LinkButton ID="linkbuttonNewTextQuestion" runat="server" Visible="False"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.Text") %></asp:LinkButton>&nbsp;
                                            <br />
                                            <asp:LinkButton ID="linkbuttonNewSingleAlternativeQuestion" runat="server" Visible="False"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.SingleAlt") %></asp:LinkButton>&nbsp;
                                            <br />
                                            <asp:LinkButton ID="linkbuttonNewMultipleAlternativeQuestion" runat="server" Visible="False"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.AddQuestion.MultipleAlt") %></asp:LinkButton>
                                            <input type="hidden" id="hiddenContestID" runat="server">
                                            <asp:Panel ID="panelNewQuestions" runat="server">
                                            </asp:Panel>
                                            <br />
                                            <asp:Button ID="buttonAddQuestion" runat="server" CssClass="button" Visible="False"></asp:Button>
                                        </td>
                                        <td class="epi-noPadding">
                                            <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                                                <tr>
                                                    <th align="left" class="epi-width50">
                                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Questions.HeaderText") %>
                                                    </th>
                                                    <th align="left">
                                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Questions.HeaderImage") %>
                                                    </th>
                                                    <th align="left" class="epi-width50">
                                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Questions.HeaderDisplayOrder") %>
                                                    </th>
                                                    <th align="left">
                                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Questions.HeaderAlternatives") %>
                                                    </th>
                                                    <th>
                                                        &nbsp;
                                                    </th>
                                                </tr>
                                                <asp:DataList ID="dataListQuestions" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID" OnDeleteCommand="dataListQuestions_DeleteCommand" OnItemCommand="dataListQuestions_MoveCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td valign="top">
                                                                <a href="javascript:SCContestOpenQuestion(<%# DataBinder.Eval(Container.DataItem, "ID") %>, <%= ContestID %>, '');">
                                                                    <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Body")) %></a>
                                                            </td>
                                                            <td>
                                                                <asp:Image ID="imageTextQuestion" runat="server" Visible="False" ImageUrl=""></asp:Image>&nbsp;
                                                            </td>
                                                            <td valign="top">
                                                                <asp:ImageButton ID="imageButtonMoveUp" CommandName="MoveUp" runat="server" ImageUrl="../../Images/scrollup.gif" Width="16" Height="16"></asp:ImageButton>
                                                                <asp:ImageButton ID="imageButtonMoveDown" runat="server" CommandName="MoveDown" ImageUrl="../../Images/scrolldown.gif" Width="16" Height="16"></asp:ImageButton>&nbsp;
                                                            </td>
                                                            <td valign="top">
                                                                <asp:ListBox ID="listBoxAlternatives" runat="server" CssClass="input" Rows="3" SelectionMode="Single" Width="100%" Visible="False"></asp:ListBox>
                                                                <asp:DropDownList ID="dropDownAlternatives" runat="server" CssClass="input" Visible="False" Width="150">
                                                                </asp:DropDownList>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right" valign="top">
                                                                <asp:Button ID="buttonDelete" runat="server" Enabled='<%# AccessRights.Administrate %>' CssClass="button" CommandName="Delete" Visible='<%# !(bool) DataBinder.Eval(Container.DataItem, "HasAnswers") %>'></asp:Button>&nbsp;
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="buttonSaveQuestions" runat="server" CssClass="button" Visible="False"></asp:Button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" ID="pageviewSubmissions">
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <tr>
                        <td class="epi-noPadding">
                            <asp:Panel ID="panelSubmissionHeader" runat="server">
                                <strong>
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.NumSubmissions") %>:
                                    <%= SubmissionTotal %></strong>
                                <br />
                                <asp:Button ID="buttonDownloadSubmission" Enabled='<%# AccessRights.Administrate %>' runat="server" CssClass="button"></asp:Button>
                                <br />
                                <br />
                            </asp:Panel>
                            <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%;">
                                <tr>
                                    <th align="left">
                                        <asp:LinkButton ID="linkButtonSubmissionUserAlias" runat="server"></asp:LinkButton>
                                    </th>
                                    <th align="left">
                                        <asp:LinkButton ID="linkButtonSubmissionNumCorrectAnswers" runat="server"></asp:LinkButton>
                                    </th>
                                    <th align="left">
                                        <asp:LinkButton ID="linkButtonSubmissionDateSubmitted" runat="server"></asp:LinkButton>
                                    </th>
                                    <th align="left">
                                        &nbsp;
                                    </th>
                                    <th align="left">
                                        &nbsp;
                                    </th>
                                </tr>
                                <tr runat="server" id="rowPagingTop">
                                    <td colspan="5">
                                        <sc:PagingControl ID="pagingControlTop" runat="server" />
                                    </td>
                                </tr>
                                <asp:DataList ID="dataListSubmissions" runat="server" DataKeyField="ID" RepeatDirection="Horizontal" RepeatLayout="Flow" OnUpdateCommand="dataListSubmissions_UpdateCommand" OnDeleteCommand="dataListSubmissions_DeleteCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <a href="javascript:SCMyPageOpenEditUser(<%# DataBinder.Eval(Container.DataItem, "User.ID") %>);">
                                                    <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "User.Alias")) %></a>
                                            </td>
                                            <td>
                                                <%# DataBinder.Eval(Container.DataItem, "NumberOfCorrectAnswers") %>
                                            </td>
                                            <td>
                                                <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "SubmissionDate")) %>
                                            </td>
                                            <td>
                                                <a href="javascript:SCContestOpenSubmissionAnswers(<%# DataBinder.Eval(Container.DataItem, "ID") %>);">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Submission.textAnswers") %>
                                            </td>
                                            <td>
                                                <asp:Button ID="buttonSelectAsWinner" Enabled='<%# AccessRights.Administrate %>' runat="server" CssClass="button" CommandName="Update" Visible='<%# !(bool)DataBinder.Eval(Container.DataItem, "IsWinner") %>'></asp:Button>
                                                <asp:Label ID="labelWinner" runat="server" Visible='<%# (bool)DataBinder.Eval(Container.DataItem, "IsWinner") %>'><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.Winner") %>!</asp:Label>
                                                <asp:Button ID="buttonRemoveAsWinner" Enabled='<%# AccessRights.Administrate %>' runat="server" CssClass="button" CommandName="Delete" Visible='<%# (bool)DataBinder.Eval(Container.DataItem, "IsWinner") %>'></asp:Button>&nbsp;
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:DataList>
                                <tr runat="server" id="rowNoResult">
                                    <td colspan="5">
                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.NoResult") %>.
                                    </td>
                                </tr>
                                <tr runat="server" id="rowPagingBottom">
                                    <td colspan="5">
                                        <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ComponentArt:PageView>
        </ComponentArt:MultiPage>
    </div>
    
    <asp:PlaceHolder ID="placeHolderRedirectToEdit" runat="server" Visible="False">

    <script language="javascript">
        setTimeout('RedirectToEdit()', 1000);

        function RedirectToEdit() {
            if (window.opener) {
                window.opener.location.href = window.opener.location.href;
            }

            document.location.href = 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Contest/ContestInfoControl.ascx&contestId=<% = ContestID %>';            
        }
    </script>

    </asp:PlaceHolder>

    
    
</asp:Panel>
