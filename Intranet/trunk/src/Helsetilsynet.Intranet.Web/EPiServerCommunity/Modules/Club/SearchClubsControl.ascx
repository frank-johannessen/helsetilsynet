<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="SearchClubsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SearchClubsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript" src="Administration.js"></script>

<!--<link rel="stylesheet" type="text/css" href="Administration.css" />-->
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<asp:Panel ID="panelValidators" runat="server">
    <asp:RegularExpressionValidator ID="validatorMinMembers" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxMinNumMembers" ValidationExpression="[0-9]{1,}"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="validatorMaxMembers" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxMaxNumMembers" ValidationExpression="[0-9]{1,}"></asp:RegularExpressionValidator>
</asp:Panel>
<table class="epi-default" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <th valign="top" colspan="5">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.MenuHeader") %>
            </th>
        </tr>
        <tr>
            <td class="menu" rowspan="4">
                <button class="button" onclick="SCClubOpenClubInfo(-1); return false;" runat="server" id="CreateClubButton"></button>
            </td>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputName") %>:
            </td>
            <td>
                <asp:TextBox ID="textBoxName" runat="server" CssClass="input" MaxLength="200" Width="120" />
            </td>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputDescription") %>:
            </td>
            <td>
                <asp:TextBox ID="textBoxDescription" runat="server" CssClass="input" MaxLength="2000" Width="120" />
            </td>
        </tr>
        <tr>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputMinMembers") %>:
            </td>
            <td>
                <asp:TextBox ID="textBoxMinNumMembers" runat="server" CssClass="input" MaxLength="200" Width="120" />
                <asp:RangeValidator Type="Integer" ID="rangeValidatorMinNumMembers" MinimumValue="0" MaximumValue = "9999999" Text="*" ControlToValidate="textBoxMinNumMembers" runat="server" />
            </td>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputMaxMembers") %>:
            </td>
            <td>
                <asp:TextBox ID="textBoxMaxNumMembers" runat="server" CssClass="input" MaxLength="200" Width="120" />
                <asp:RangeValidator Type="Integer" ID="rangeValidatorMaxNumMembers" MinimumValue="0" MaximumValue = "9999999" Text="*" ControlToValidate="textBoxMaxNumMembers" runat="server" />
            </td>

        </tr>
        <tr>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputStatus") %>:
            </td>
            <td>
                <asp:DropDownList ID="dropDownStatus" runat="server" CssClass="input" Width="120" />
            </td>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputHidden") %>:
            </td>
            <td>
                <asp:DropDownList ID="dropDownHidden" runat="server" CssClass="input" Width="120" />
            </td>
         </tr>
         <tr> 
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputSecurityStatus") %>:
            </td>
            <td>
                <asp:DropDownList ID="dropDownSecurityStatus" runat="server" CssClass="input" Width="120" />
            </td>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputCategory") %>
            </td>
            <td>
                <asp:DropDownList ID="dropDownCategory" runat="server" CssClass="input" Width="120" />
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:Button ID="buttonSearch" runat="server" CssClass="button" />
            </td>
        </tr>
    </tbody>
</table>
<br />
<asp:PlaceHolder ID="placeHolderSearchResult" runat="server" Visible="False">
    <table cellpadding="0" cellspacing="0" width="100%" class="epi-default">
        <tr>
            <th>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.MenuHeaderRemoval") %>
            </th>
            <th>
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.SearchResult") %>
                    (<% = TotalHits %>)
            </th>
        </tr>
        <tr>
            <td class="menu">
                <asp:Button ID="buttonRemoveClubs" runat="server" CssClass="button"></asp:Button>
                <br />
                <asp:CheckBox ID="checkBoxRemovePermanent" runat="server"></asp:CheckBox>
                <asp:PlaceHolder ID="placeHolderSearchExtensions" runat="server" Visible="true"></asp:PlaceHolder>
            </td>
            <td class="epi-noPadding">
                <table cellpadding="0" cellspacing="0" width="100%" class="epi-default" style="width:100%">
                    <thead>
                        <tr>
                            <th align="left">
                                &nbsp;
                            </th>
                            <th align="left">
                                <asp:LinkButton ID="linkButtonName" runat="server"></asp:LinkButton>
                            </th>
                            <th align="left">
                                <asp:LinkButton ID="linkButtonNumMembers" runat="server"></asp:LinkButton>
                            </th>
                            <th align="left">
                                <asp:LinkButton ID="linkCreatedBy" runat="server"></asp:LinkButton>
                            </th>
                            <th align="left">
                                <asp:LinkButton ID="linkButtonCreateDate" runat="server"></asp:LinkButton>
                            </th>
                            <th align="left">
                                <asp:LinkButton ID="linkButtonStatus" runat="server"></asp:LinkButton>
                            </th>
                            <th align="left">
                                &nbsp;
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr runat="server" id="rowPagingTop">
                                <td colspan="7">
                                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                                </td>
                            </tr>
                            <asp:DataList ID="dataListSearchResult" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID" OnUpdateCommand="dataListSearchResult_UpdateCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td class="icon">
                                            <asp:CheckBox ID="checkBoxAssociate" runat="server" Enabled='<%# (((EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status"))!=EPiServer.Common.EntityStatus.Removed) %>'></asp:CheckBox><input type="hidden" runat="server" id="hiddenClubId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenClubId">
                                        </td>
                                        <td>
                                            <a href="javascript:SCClubOpenClubInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>);">
                                                <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></a>
                                        </td>
                                        <td>
                                            <%# DataBinder.Eval(Container.DataItem, "NumberOfMembers") %>
                                        </td>
                                        <td>
                                            <%# (DataBinder.Eval(Container.DataItem, "Author") != null && DataBinder.Eval(Container.DataItem, "Author.User") != null) ? "<a href=\"javascript:SCMyPageOpenEditUser(" + DataBinder.Eval(Container.DataItem, "Author.User.ID") + ");\">" + AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) + "</a>" : (DataBinder.Eval(Container.DataItem, "Author") != null) ? AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) : ""%>
                                            
                                        </td>
                                        <td>
                                            <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %>
                                        </td>
                                        <td>
                                            <%# GetStatusForSearchResults((EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status"))%>
                                        </td>
                                        <td align="right">
                                            <asp:Button ID="buttonUndoRemove" runat="server" CssClass="button" CommandName="Update" Visible='<%# (((EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status"))==EPiServer.Common.EntityStatus.Removed) %>'></asp:Button>&nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:DataList>
                            <tr runat="server" id="rowNoResult">
                                <td colspan="6">
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.NoResult") %>.
                                </td>
                            </tr>
                            <tr runat="server" id="rowPagingBottom">
                                <td colspan="6">
                                    <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
</asp:PlaceHolder>
