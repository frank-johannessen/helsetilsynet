<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="QuestionListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.QuestionListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<!-- Question list control -->

<script language="javascript" src="Administration.js"></script>

<!--<link rel="stylesheet" type="text/css" href="Administration.css" />-->

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

<table class="epi-default" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <th>
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.MenuHeader") %>
        </th>
        <th>&nbsp;</th>
    </tr>
    <tr>
        <td class="menu" id="tdEdit" runat="server">
            <asp:Button ID="buttonReject" runat="server" CssClass="button" Visible="False" OnClick="buttonReject_Click"></asp:Button>
            <asp:Button ID="buttonPublish" runat="server" CssClass="button" Visible="False" OnClick="buttonPublish_Click"></asp:Button>
            <asp:Button ID="buttonRemove" runat="server" CssClass="button" Visible="False" OnClick="buttonRemove_Click"></asp:Button>
            <button id="buttonCheckAll" onclick="<% = this.ClientID %>_CheckUncheckAll(); return false;" class="button">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.CheckUncheckAll") %></button>
        </td>
        <td class="epi-noPadding">
            <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                <tr>
                    <th align="left">
                        <asp:LinkButton ID="linkButtonHeader" runat="server"></asp:LinkButton>
                    </th>
                    <th align="left">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.Header.Author") %>
                    </th>
                    <th align="left">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.Header.Status") %>
                    </th>
                    <th align="left">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.Header.Assigned") %>
                    </th>
                    <th align="left">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.Header.Answers") %>
                    </th>
                </tr>
                <tr runat="server" id="rowPagingTop">
                    <td colspan="5">
                        <sc:PagingControl ID="pagingControlTop" runat="server" />
                    </td>
                </tr>
                <asp:Repeater ID="repeaterQuestions" EnableViewState="True" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <input type="hidden" runat="server" id="hiddenQuestionId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenQuestionId">
                                <asp:CheckBox ID="checkBoxAssociate" runat="server" CssClass="checkboxInList"></asp:CheckBox>
                                <a href="javascript:SCExpertOpenQuestionInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<%# this.UniqueID %>', '<% = this.ResolveUrl("~/EPiServerCommunity/") %>');">
                                    <%# GetHeader((EPiServer.Community.Expert.Question)Container.DataItem) %></a>
                            </td>
                            <td>
                                <%# GetAuthorName((EPiServer.Community.Expert.Question)Container.DataItem) %>
                            </td>
                            <td>
                                <%# GetStatus((EPiServer.Community.Expert.Question)Container.DataItem) %>
                            </td>
                            <td>
                                <%# GetAssignments((EPiServer.Community.Expert.Question)Container.DataItem) %>
                            </td>
                            <td>
                                <%# GetAnswers((EPiServer.Community.Expert.Question)Container.DataItem) %>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr runat="server" id="rowNoResult">
                    <td colspan="5">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.QuestionList.NoResult") %>.
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
