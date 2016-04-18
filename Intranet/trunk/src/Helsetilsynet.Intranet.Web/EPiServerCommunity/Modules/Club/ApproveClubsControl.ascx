<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="ApproveClubsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ApproveClubsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript">
<!--
function <% = this.ClientID %>_CheckUncheckAll()
{
	var totalCount = 0;
	var checkCount = 0;
	var i;
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf("checkBoxAssociate") >= 0 && elem.id.indexOf('<% = this.ClientID %>') >= 0)
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
		if (elem.name.indexOf("checkBoxAssociate") >= 0 && elem.id.indexOf('<% = this.ClientID %>') >= 0)
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

<script language="javascript" src="Administration.js"></script>

<!--<link rel="stylesheet" type="text/css" href="Administration.css" />-->
<table class="epi-default" cellpadding="0" cellspacing="0">
    <tr>
        <th colspan="2">
            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ApproveClubs.MenuHeader") %>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <asp:Button ID="buttonApprove" runat="server" CssClass="button" Visible="True"></asp:Button>
            <asp:Button ID="buttonDisapprove" runat="server" CssClass="button" Visible="False"></asp:Button>
            <asp:Button ID="buttonRemove" runat="server" CssClass="button"></asp:Button>
            <button id="buttonCheckAll" onclick="<% = this.ClientID %>_CheckUncheckAll(); return false;" class="button">
                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ApproveClubs.buttonCheckAll") %></button>
        </td>
        <td class="epi-noPadding">
            <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                <tr>
                    <th align="left" class="icon">
                        &nbsp;
                    </th>
                    <th align="left">
                        <asp:LinkButton ID="linkButtonName" runat="server"></asp:LinkButton>
                    </th>
                    <th align="left">
                        <asp:LinkButton ID="linkButtonCreator" runat="server"></asp:LinkButton>
                    </th>
                    <th align="left">
                        <asp:LinkButton ID="linkButtonCreateDate" runat="server"></asp:LinkButton>
                    </th>
                </tr>
                <tr runat="server" id="rowPagingTop">
                    <td colspan="4">
                        <sc:PagingControl ID="pagingControlTop" runat="server" />
                    </td>
                </tr>
                <asp:Repeater ID="repeaterClubs" EnableViewState="True" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:CheckBox ID="checkBoxAssociate" runat="server"></asp:CheckBox>
                            </td>
                            <td>
                                <input type="hidden" runat="server" id="hiddenClubId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenClubId">
                                <a href="javascript:SCClubOpenClubInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>);">
                                    <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></a>
                            </td>
                            <td>
                            
                                <%# (DataBinder.Eval(Container.DataItem, "Author") != null && DataBinder.Eval(Container.DataItem, "Author.User") != null) ? "<a href=\"javascript:SCMyPageOpenEditUser(" + DataBinder.Eval(Container.DataItem, "Author.User.ID") + ");\">" + AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) + "</a>" : (DataBinder.Eval(Container.DataItem, "Author") != null) ? AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) : ""%>   
                                
                                
                            </td>
                            <td>
                                <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr runat="server" id="rowNoResult">
                    <td colspan="4">
                        <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ApproveClubs.NoResult") %>.
                    </td>
                </tr>
                <tr runat="server" id="rowPagingBottom">
                    <td colspan="4">
                        <sc:PagingControl ID="pagingControlBottom" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
