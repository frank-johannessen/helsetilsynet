<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ExpertAssignedQuestionsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ExpertAssignedQuestionsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<!-- A list of assigned quesions for an expert. -->

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
    <thead>
        <tr>
            <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.AssignedQuestions.MenuHeader") %></th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
		    <td class="menu">
			    <asp:Button ID="buttonRemoveAssignment" Runat="server" CssClass="button" Visible="True"></asp:Button>
			    <button ID="buttonCheckAll" OnClick="<% = this.ClientID %>_CheckUncheckAll(); return false;" Class="button"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.AssignedQuestions.CheckUncheck") %></button>
		    </td>
		    <td class="epi-noPadding">
		        <table class="epi-default" cellpadding="0" cellspacing="0" border="0" width="100%" style="width: 100%">
		            <thead>
	                    <tr>
		                    <th align="left"><asp:LinkButton ID="linkButtonHeader" Runat="server"></asp:LinkButton></th>
		                    <th align="left"><asp:LinkButton ID="linkButtonCreated" Runat="server"></asp:LinkButton></th>
		                    <th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.AssignedQuestions.Header.Answer") %></th>
	                    </tr>
		            </thead>
		            <tbody>
	                    <tr runat="server" id="rowPagingTop">
		                    <td colspan="3"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
	                    </tr>
	                    <asp:Repeater ID="repeaterAssignedQuestions" EnableViewState="True" Runat="server">
		                    <ItemTemplate>
			                    <tr>
				                    <td>
					                    <input type="hidden" runat="server" id="hiddenAssignedQuestionId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenAssignedQuestionId">
					                    <asp:CheckBox ID="checkBoxAssociate" Runat="server" CssClass="checkboxInList"></asp:CheckBox>
					                    <%# GetQuestionHeader((EPiServer.Community.Expert.AssignedQuestion)Container.DataItem) %>
				                    </td>
				                    <td>
					                    <span class="<%# GetDateClass((EPiServer.Community.Expert.AssignedQuestion)Container.DataItem) %>">
						                    <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %>
					                    </span>&nbsp;
				                    </td>
				                    <td>
				                        <button id="btnAddAnswer" class="button" runat="server"></button>
				                        <%# GetAnswer((EPiServer.Community.Expert.AssignedQuestion)Container.DataItem) %>
				                    </td>
			                    </tr>
		                    </ItemTemplate>
	                    </asp:Repeater>	
	                    <tr runat="server" id="rowNoResult">
		                    <td colspan="3" style="height: 200px" valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.AssignedQuestions.NoResult") %>.</td>
	                    </tr>
	                    <tr runat="server" id="rowPagingBottom">
		                    <td colspan="3"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
	                    </tr>
		            </tbody>
		        </table>
		    </td>
        </tr>
    </tbody>
</table>