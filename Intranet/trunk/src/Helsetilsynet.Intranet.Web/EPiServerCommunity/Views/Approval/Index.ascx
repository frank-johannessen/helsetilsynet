<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ViewData>" %>
<%@ Import Namespace="EPiServer.Common" %>
<%@ Import Namespace="EPiServer.Community" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Approval" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<%@ Import Namespace="EPiServer.Shell.Web" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Shared" %>
<%= Html.ShellValidationSummary() %>
<%= Html.SetGadgetFeedback(Model.FeedbackMessage, false, new TimeSpan(0,0,5), true) %>
<% Html.BeginGadgetForm("UpdateStatus", new { currentStatus = Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection, pageNumber = Model.Paging.PageNumber }); %>
<div class="epi-padding-small epi-overflowHidden">
    <div class="epi-gadgetShortlinks epi-floatLeft">
        <%= Html.FilterButtons<EntityStatus>(Model.StatusFilters, "Index", "currentStatus", "epi-gadgetShortlinks-active", "",
                        new { sortField = Model.SortField, sortDirection = Model.SortDirection })%>
    </div>
    <%-- for further development
        <div class="epi-floatRight">
        <ul class="epi-gadget-iconSwitch">
            <li class="epi-gadget-iconSwitch-itemFirst epi-gadget-iconSwitch-active"><a href="#">
                <img src="/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-table.gif" /></a> </li>
            <li class="epi-gadget-iconSwitch-itemLast"><a href="#">
                <img src="/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-compact.gif" /></a> </li>
        </ul>
    </div>--%>
    <br /><br />

    <div class="epi-clear epi-floatLeft">
        <%=Html.ActionButtons<ApprovalAction>(Model.ApprovalButtons) %>
        <%=Html.Hidden("actionButtonValue") %>
    </div>
    <div class="epi-floatRight">
        <%= Html.ViewLink(Resource.ApprovalRefresh, Resource.ApprovalRefresh, "Index", "epi-linkBlue epi-approvalGadget-iconRefresh", new { }, new { currentStatus = Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection, pageNumber = Model.Paging.PageNumber })%>
    </div>
</div>
<div class="epi-clear epi-width100 epi-gadget-tableWrapper">
    <table class="epi-simple epi-gadgetTable">
        <thead>
		    <tr>
			    <th class="epi-alignMiddle"><%= Html.CheckBox("ApprovalGadget-AllSelected", false, new { title = Resource.SelectUnselectAll })%></th>
			    <%=Html.TableHeader(Resource.ApprovalContentHeader, "", 2, Model.SortDirection.Value, Model.SortField.Value, SortBy.Header, "Index", new { currentStatus = Model.CurrentStatus })%>
			    <%=Html.TableHeader(Resource.ApprovalTypeHeader, "epi-width10", 1, Model.SortDirection.Value, Model.SortField.Value, SortBy.Type, "Index", new { currentStatus = Model.CurrentStatus })%>
			    <%=Html.TableHeader(Resource.ApprovalAuthorHeader, "epi-width20", 2, Model.SortDirection.Value, Model.SortField.Value, SortBy.Author, "Index", new { currentStatus = Model.CurrentStatus })%>
			    <%=Html.TableHeader(Resource.ApprovalDateHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, SortBy.Modified, "Index", new { currentStatus = Model.CurrentStatus })%>
			    <%=Html.TableHeader(Resource.ApprovalStatusHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, SortBy.Status, "Index", new { currentStatus = Model.CurrentStatus })%>
		    </tr>
	    </thead>
        <tbody>
            <% foreach (ApprovalItem rowItem in Model.TableRows) { %>
            <tr class='<%= Html.GetRowCssClass(rowItem, "epi-gadget-defaultRow", "epi-gadget-adminUserRow", "epi-gadget-currentUserRow") %>'>
                <td class="epi-alignTop">
                    <%= Html.CheckBox("TableRows[" + Model.TableRows.IndexOf(rowItem) + "].IsSelected", rowItem.IsSelected, new { @class = "epi-gadget-checkboxAligned" })%>
                    <%= Html.Hidden("TableRows[" + Model.TableRows.IndexOf(rowItem) + "].Metadata", rowItem.Metadata, new { id = "Metadata" })%>                            
                    <%= Html.Hidden("TableRows[" + Model.TableRows.IndexOf(rowItem) + "].ID", rowItem.ID, new {id = "ItemId" }) %>
                    <%= Html.Hidden("TableRows[" + Model.TableRows.IndexOf(rowItem) + "].Status", rowItem.Status, new { id = "Status" }) %>
                </td>
                <td>
                    <div class="epi-gadget-previewImageWrapper">
                            <%= Html.ThumbnailWithDefault(rowItem.Image, 75, 55, Html.StripHtml(rowItem.Header).Ellipsis(20), rowItem.Metadata, "epi-floatLeft", "epi-gadget-previewImage")%>
                            <%= Html.GetSystemAuthorImage(rowItem.IsSystemEntity, "epi-abuseGadget-authorIcon")%>
                            <div class="epi-gadget-imagePopup">
                                <%= Html.Thumbnail(rowItem.Image, 400, 300, Html.StripHtml(rowItem.Header).Ellipsis(30), String.Empty)%>
                            </div>
                    </div>
                </td>
                <td class="epi-width50">
     			    <%= Html.ViewModeLink(rowItem.ViewModeUrl, Resource.ShowOnSiteLink, "epi-alignTop")%>
                    <%= Html.ModerateModeLink(rowItem, "<span class='epi-wrapNormal'>" + Html.StripHtml(rowItem.Header).Ellipsis(30) + "</span>", "epi-linkBlue")%>
                    <br />
                    <span class="epi-wrapNormal"><%= Html.StripHtml(rowItem.Body).Ellipsis(Model.PreviewLength)%></span>
                </td>
                <td>
                    <%= rowItem.Type %>
                </td>
                <td class="epi-width1">
                    <%= Html.Thumbnail(rowItem.Author.Image, 36, 36, Html.StripHtml(rowItem.Author.Header).Ellipsis(20), 
                        Html.GetDefaultAuthorImageUrl(),"epi-floatLeft", "epi-authorIcon") %>
                </td>
                <td class="epi-color-gray6 epi-width20">
                     <%= Html.AuthorLink(rowItem.Author) %>
                </td>
                <td class="epi-color-gray6">
                    <%=rowItem.Modified.Format()%>
                </td>
                <td>
                    <%=rowItem.StatusTitle %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
<% Html.EndForm(); %>

<%=Html.Pager(Model.Paging, "Index", Resource.PagerInfoTemplate, "pageNumber", new { currentStatus = Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection })%>
