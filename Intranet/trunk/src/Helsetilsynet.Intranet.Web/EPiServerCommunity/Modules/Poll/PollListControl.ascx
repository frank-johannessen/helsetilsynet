<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="PollListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.PollListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PollControl" Src="PollControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript" src="Administration.js"></script>

<table border="0" cellspacing="0" cellpadding="0" class="epi-default">
    <tr>
        <th>
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollList.MenuHeader") %>
        </th>
        <th>
            <asp:PlaceHolder runat="server" ID="ResultsTitle">
                <%= EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.ResultsTitle") %>
            </asp:PlaceHolder>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="SCPollOpenPollInfo(-1, '<% = ModuleUniqueName %>', '<% = ClubID %>', '<% = MyPageID %>', '<% = PollListControlID %>');return false;">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollList.buttonCreateNew") %></button>
            <asp:Button ID="buttonRemoveSelected" runat="server" CssClass="button" />
        </td>
        <td valign="top">
            <div style="padding-bottom: 5px; padding-top: 2px;" id="pgDivTop" runat="server">
                <sc:PagingControl ID="pagingControlTop" runat="server" />
            </div>
            <asp:DataList ID="dataListPolls" runat="server">
                <ItemTemplate>
                    <sc:PollControl ID="pollControl" runat="server" />
                </ItemTemplate>
            </asp:DataList>
            <div style="padding-bottom: 2px; padding-top: 5px;" id="pgDivBottom" runat="server">
                <sc:PagingControl ID="pagingControlBottom" runat="server" />
            </div>
        </td>
    </tr>
</table>
