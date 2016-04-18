<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="ExpertListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ExpertListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript">
<!--
function <% = this.ClientID %>_GetCheckBoxCount(checkBoxId)
{
    var totalCount = 0;
	var checkCount = 0;
	
	var i;
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf(checkBoxId) >= 0)
		{
			totalCount = totalCount + 1;
			if (elem.checked)
			{
				checkCount = checkCount + 1;
			}
		}
	}
    return {total: totalCount, checked: checkCount};
}

function <% = this.ClientID %>_CheckUncheckAll(checkBoxId)
{
    var checkboxes = <% = this.ClientID %>_GetCheckBoxCount(checkBoxId);
		
	var j;
	for (j = 0; j < document.forms[0].elements.length; j++) {
		var elem = document.forms[0].elements[j];
		if (elem.name.indexOf(checkBoxId) >= 0)
		{
			if (checkboxes.checked < checkboxes.total)
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

function <%= this.ClientID %>_ExpertDeleteConfirmation(checkBoxId, message)
{
    var checkboxes = <% = this.ClientID %>_GetCheckBoxCount(checkBoxId);

	if (checkboxes.checked > 0){
	    return confirm(message);
	}
	return false;
}
//-->
</script>

<script language="javascript" src="Administration.js"></script>

<!--<link rel="stylesheet" type="text/css" href="Administration.css" />-->
<table class="epi-default" cellpadding="0" cellspacing="0">
    <thead>
        <tr>
            <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertList.MenuHeader") %></th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="menu">
                <div class="epi-paddingVertical-xsmall">
                <button id="buttonCheckAll" onclick="<% = this.ClientID %>_CheckUncheckAll('<%=GetCheckBoxName() %>');return false;" class="button" <% if (!AdminAccess) { %>disabled<% } %>>
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertList.CheckUncheckAll") %></button>
                <asp:Button ID="buttonRefresh" runat="server" CssClass="button" Visible="true" />                    
                </div>
                <div class="epi-paddingVertical-xsmall">
                <asp:Button ID="buttonApprove" runat="server" CssClass="button" Visible="True"></asp:Button>
                <asp:Button ID="buttonRemove" runat="server" CssClass="button"></asp:Button>
                <asp:Button ID="buttonActivate" runat="server" CssClass="button" Visible="False"></asp:Button>
                <asp:Button ID="buttonDeactivate" runat="server" CssClass="button" Visible="False"></asp:Button>
                </div>
                <div class="epi-paddingVertical-xsmall">
                <button id="buttonCreate" onclick="SCExpertOpenCreateExpert('<%# this.UniqueID %>'); return false;" class="button" <% if (!AdminAccess) { %>disabled<% } %> >
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertList.buttonCreateNewExpert") %></button>
                </div>
            </td>
            <td class="epi-noPadding">
                <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                    <thead>
                        <tr>
                            <th>
                                <asp:LinkButton ID="linkButtonName" runat="server"></asp:LinkButton>
                            </th>
                            <th>
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertList.Header.Email") %>
                            </th>
                            <th>
                                <asp:LinkButton ID="linkButtonAlias" runat="server"></asp:LinkButton>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr runat="server" id="rowPagingTop">
                            <td colspan="3">
                                <sc:PagingControl ID="pagingControlTop" runat="server" />
                            </td>
                        </tr>
                        <asp:Repeater ID="repeaterExperts" EnableViewState="True" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input type="hidden" runat="server" id="hiddenExpertId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenExpertId">
                                        <asp:CheckBox ID="checkBoxAssociateApplied" runat="server" CssClass="checkboxInList" Enabled="<%# AdminAccess %>"></asp:CheckBox>
                                        <asp:CheckBox ID="checkBoxAssociateActive" runat="server" CssClass="checkboxInList" Enabled="<%# AdminAccess %>"></asp:CheckBox>
                                        <asp:CheckBox ID="checkBoxAssociateInactive" runat="server" CssClass="checkboxInList" Enabled="<%# AdminAccess %>"></asp:CheckBox>
                                        <a style="vertical-align: middle;" href="javascript:SCExpertOpenExpertInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<%# this.UniqueID %>');">
                                            <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "GivenName")) %>&nbsp;<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "SurName")) %></a>
                                    </td>
                                    <td>
                                        <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "EMail")) %>&nbsp;
                                    </td>

                                    <td>
                                        <a href="javascript:SCMyPageOpenEditUser(<%# GetUserID((EPiServer.Community.Expert.ExpertBase)Container.DataItem) %>);">
                                            <%# AdministrationUtils.FormatString(GetUserAlias((EPiServer.Community.Expert.ExpertBase)Container.DataItem)) %></a>&nbsp;
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <tr runat="server" id="rowNoResult">
                            <td colspan="3">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertList.NoResult") %>.
                            </td>
                        </tr>
                        <tr runat="server" id="rowPagingBottom">
                            <td colspan="3">
                                <sc:PagingControl ID="pagingControlBottom" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>
