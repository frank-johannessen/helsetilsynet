<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="ClubMemberListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ClubMemberListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript" src="Administration.js"></script>

<script language="javascript">
<!--
	function <% = this.ClientID %>_MarkApproval(val)
	{
		var i;
		for (i = 0; i < document.forms[0].elements.length; i++) {
			var elem = document.forms[0].elements[i];
			if (elem.name != null && elem.name.indexOf("<% = this.UniqueID %>") >= 0 && elem.name.indexOf("radioButtonListMemberApproval") >= 0)
			{
				if (elem.value == val && !elem.disabled)
					elem.checked = true;
			}
		}
	}
	
	function <% = this.ClientID %>_GetApprovalValue()
	{
		var rdoList = document.getElementById('<% = radioButtonListApproval.ClientID %>');
		var e;
		for(e = 0; e < rdoList.childNodes.length; e++)
		{
			if(rdoList.childNodes[e].checked)
				return rdoList.childNodes[e].value;
		}
		
		return null;
	}
//-->
</script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <thead>
        <tr>
            <th>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubMemberList.MenuHeader") %>
            </th>
            <th>
                <asp:Literal ID="literalMemberHeader" runat="server" />
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="menu">
                <asp:Label ID="labelNewClubMember" runat="server"></asp:Label>
                <asp:Button ID="buttonRemoveSelected" runat="server" CssClass="button" />
                <div class="section">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubMemberList.MenuManageStatus") %></div>
                <asp:Button ID="buttonSave" runat="server" CssClass="button" />
                <button onclick="<% = this.ClientID %>_MarkApproval(<% = this.ClientID %>_GetApprovalValue());return false;" class="button">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubMemberList.buttonMarkAll") %></button><br />
                <asp:RadioButtonList ID="radioButtonListApproval" runat="server" CssClass="input" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow" CellPadding="0" CellSpacing="0">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        
            <td class="epi-noPadding">
                <asp:PlaceHolder ID="placeHolderClubMembers" runat="server">
                    <div id="imageGallery">
                        <%--      <div class="section">
                            <asp:Literal ID="literalMemberHeader" runat="server" /></div>--%>
                        <table cellpadding="0" cellspacing="0" border="0" class="epi-default" style="width: 100%">
                            <tr>
                                <th>&nbsp;</th>
                                <th align="left" width="25%">
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubMemberList.HeaderAlias") %>
                                </th>
                                <th align="left" width="25%">
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubMemberList.HeaderDate") %>
                                </th>
                                <th align="left" width="50%">
                                    &nbsp;
                                </th>
                            </tr>
                            <tr runat="server" id="rowPagingTop">
                                <td colspan="4">
                                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                                </td>
                            </tr>
                            <asp:Repeater ID="repeaterMembers" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <input type="hidden" id="hiddenUserId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "User.ID") %>' name="hiddenUserId" />
                                            <asp:CheckBox ID="checkBoxSelected" runat="server" CssClass="input" Enabled='<%# (bool)(DataBinder.Eval(Container.DataItem, "Club.Owner.ID") == null ? true : ((int)DataBinder.Eval(Container.DataItem, "User.ID") != (int)DataBinder.Eval(Container.DataItem, "Club.Owner.ID"))) && (bool)((int)DataBinder.Eval(Container.DataItem, "User.ID") != AuthorUserID) %>' />
                                        </td>
                                        <td width="25%">
                                            <a href="javascript:SCMyPageOpenEditUser(<%# DataBinder.Eval(Container.DataItem, "User.ID") %>);">
                                                <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "User.Alias")) %></a>
                                        </td>
                                        <td width="25%">
                                            <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "MemberSince")) %>
                                        </td>
                                        <td width="50%" align="right">
                                            <asp:RadioButtonList ID="radioButtonListMemberApproval" CssClass="input" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled='<%# (bool)(DataBinder.Eval(Container.DataItem, "Club.Owner.ID") == null ? true : ((int)DataBinder.Eval(Container.DataItem, "User.ID") != (int)DataBinder.Eval(Container.DataItem, "Club.Owner.ID"))) && (bool)((int)DataBinder.Eval(Container.DataItem, "User.ID") != AuthorUserID) %>'>
                                                <asp:ListItem></asp:ListItem>
                                                <asp:ListItem></asp:ListItem>
                                                <asp:ListItem></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr runat="server" id="rowPagingBottom">
                                <td colspan="4">
                                    <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:PlaceHolder>
            </td>
        </tr>
    <tbody>
</table>
