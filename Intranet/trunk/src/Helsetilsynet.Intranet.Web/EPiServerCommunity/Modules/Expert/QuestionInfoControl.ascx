<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="QuestionInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.QuestionInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript" src="Administration.js"></script>

<script language="javascript">
<!--
function <% = this.ClientID %>_CheckUncheckAll()
{
	var totalCount = 0;
	var checkCount = 0;
	
	var i;
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf("checkBoxAssociate") >= 0)
		{
			totalCount = totalCount + 1;
			if (elem.checked)
			{
				checkCount = checkCount + 1;
			}
		}
	}
		
	var j;
	for (j = 0; j < document.forms[0].elements.length; j++) {
		var elem = document.forms[0].elements[j];
		if (elem.name.indexOf("checkBoxAssociate") >= 0)
		{
			if (checkCount < totalCount)
			{
				elem.checked = true;
			}
			else
			{
				elem.checked = false;
			}
		}
	}
}
//-->
</script>

<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>" />

<script language="javascript">
    document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.Title") %>'
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<div id="tabStrip">
    <ComponentArt:TabStrip ID="tabStripQuestionInfo" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageQuestionInfo" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabQuestionDetails">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabQuestionAssignments">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabRelatedQuestions">
            </ComponentArt:TabStripTab>
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageQuestionInfo" CssClass="multiPage" runat="server">
        <ComponentArt:PageView runat="server" ID="pageViewEditQuestionInfo">
            <!-- Question details. -->
            <asp:Panel ID="panelValidators" runat="server" Visible="False">
            </asp:Panel>
            <table class="epi-default" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.inputAuthor") %>:
                    </td>
                    <td>
                        <asp:Label ID="labelAuthor" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.inputStatus") %>:
                    </td>
                    <td>
                        <asp:Label ID="labelStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.inputHeader") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxHeader" runat="server" MaxLength="100" CssClass="input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.inputBody") %>:
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="textBoxBody" runat="server" CssClass="input" TextMode="MultiLine" Height="80" Width="400"></asp:TextBox><br>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <asp:Button ID="buttonReject" runat="server" CssClass="button" Visible="False" OnClick="buttonReject_Click"></asp:Button>
                        <asp:Button ID="buttonPublish" runat="server" CssClass="button" Visible="False" OnClick="buttonPublish_Click"></asp:Button>
                        <asp:Button ID="buttonRevokePublication" runat="server" CssClass="button" Visible="False" OnClick="buttonRevokePublication_Click"></asp:Button>
                        <asp:Button ID="buttonRemove" runat="server" CssClass="button" Visible="False" OnClick="buttonRemove_Click"></asp:Button>
                        <asp:Button ID="buttonSave" runat="server" CssClass="button" OnClick="buttonSave_Click"></asp:Button>&nbsp;
                    </td>
                </tr>
            </table>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewAssignments">
            <!-- A list of all assigned experts for the current question, and an add assignment box. -->
            <table class="epi-default" cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th colspan="2">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.Header") %>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td width="100">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.inputExpert") %>:
                        </td>
                        <td>
                            <asp:DropDownList ID="dropDownListExperts" runat="server" CssClass="input">
                            </asp:DropDownList>
                            &nbsp;
                            <asp:Button ID="buttonAssignQuestion" runat="server" CssClass="button" Visible="True" OnClick="buttonAssignQuestion_Click"></asp:Button>&nbsp;
                            <asp:CustomValidator ID="validatorAssignExpert" runat="server" EnableClientScript="False" Display="None" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <div>
                &nbsp;</div>
            <table class="epi-default" cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.MenuHeader") %></th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="menu">
                            <asp:Button ID="buttonRemoveAssignment" runat="server" CssClass="button" Visible="True" OnClick="buttonRemoveAssignment_Click"></asp:Button>
                            <button id="buttonCheckAll" onclick="<% = this.ClientID %>_CheckUncheckAll(); return false;" class="button">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.CheckUncheckAll") %></button>
                        </td>
                        <td class="epi-noPadding">
                            <table class="epi-default" cellpadding="0" cellspacing="0" border="0" width="100%" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>
                                            <asp:LinkButton ID="linkButtonName" runat="server"></asp:LinkButton>
                                        </th>
                                        <th>
                                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.Header.AssignedDate") %>
                                        </th>
                                        <th>
                                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.Header.Answer") %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="rowPagingTop">
                                        <td colspan="4">
                                            <sc:PagingControl ID="pagingControlTop" runat="server" />
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="repeaterAssignedExperts" EnableViewState="True" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <input type="hidden" runat="server" id="hiddenAssignedQuestionId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenAssignedQuestionId">
                                                    <asp:CheckBox ID="checkBoxAssociate" runat="server" CssClass="checkboxInList"></asp:CheckBox>
                                                    <a href="javascript:SCExpertOpenExpertInfo(<%# DataBinder.Eval(Container.DataItem, "Expert.ID") %>, '<%# this.UniqueID %>');">
                                                        <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Expert.GivenName")) %>&nbsp;<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Expert.SurName")) %></a>
                                                </td>
                                                <td>
                                                    <span class="<%# GetDateClass((EPiServer.Community.Expert.AssignedQuestion)Container.DataItem) %>">
                                                        <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></span>&nbsp;
                                                </td>
                                                <td>
                                                    <%# GetAnswer((EPiServer.Community.Expert.AssignedQuestion)Container.DataItem) %>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <tr runat="server" id="rowNoResult">
                                        <td colspan="3">
                                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionInfo.AssignedExperts.NoResult") %>.
                                        </td>
                                    </tr>
                                    <tr runat="server" id="rowPagingBottom">
                                        <td colspan="4">
                                            <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </ComponentArt:PageView>
        <ComponentArt:PageView ID="pageViewRelatedQuestions" runat="server">
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
    <asp:PlaceHolder ID="placeHolderCloseWindow" runat="server" Visible="False">

        <script language="javascript">
            setTimeout('CloseWindow()', 1000);

            function CloseWindow() {
                if (window.opener)
                    window.opener.__doPostBack('<% = QuestionListControlId %>', '<% = EPiServer.Community.Web.Administration.QuestionListControl.POSTBACK_REFRESH_ARGUMENT %>');
                window.close();
            }
        </script>

    </asp:PlaceHolder>
</div>
