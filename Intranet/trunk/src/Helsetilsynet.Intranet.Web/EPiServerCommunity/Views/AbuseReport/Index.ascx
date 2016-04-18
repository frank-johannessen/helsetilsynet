<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ViewData>" %>
<%@ Import Namespace="EPiServer.Community" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.AbuseReport" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Shell.Web" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<%@ Import Namespace="EPiServer.Common.Reporting" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Shared" %>
<%@ Import Namespace="EPiServer.Web" %>
<%= Html.ShellValidationSummary() %>
<%= Html.SetGadgetFeedback(Model.FeedbackMessage, false, new TimeSpan(0, 0, 5), true) %>
<% Html.BeginGadgetForm("UpdateStatus", new { currentStatus = Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection, pageNumber = Model.Paging.PageNumber }); %>
<div class="epi-padding-small epi-overflowHidden">
    <div class="epi-gadgetShortlinks epi-floatLeft">
        <%=Html.FilterButtons<ReportCaseStatus>(Model.StatusFilters, "Index", "currentStatus", "epi-gadgetShortlinks-active", "", 
            new { sortField = Model.SortField, sortDirection = Model.SortDirection})%>
    </div>
    <div class="epi-floatRight">
        <ul class="epi-gadget-iconSwitch">
            <li class="epi-gadget-iconSwitch-itemFirst epi-gadget-iconSwitch-active">
                <a href="#">
                    <img src="<%=VirtualPathUtilityEx.ToAbsolute("~/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-table-active.png") %>" title="<%= Resource.ReportedItemsTooltip %>" />
                </a>
            </li>
            <li class="epi-gadget-iconSwitch-itemLast">
                <%=Html.ViewLink("<img src='" + VirtualPathUtilityEx.ToAbsolute("~/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-users.png") + "' />", 
                    "", "ReportingReported", new { title = Resource.ReportingReportedUsersTooltip})%>
            </li>
        </ul>
    </div>
 
    <br /><br />
    <div class="epi-clear epi-floatLeft">
        <%=Html.ActionButtons<AbuseHandlingAction>(Model.ActionButtons)%>
        <%=Html.Hidden("abuseHandlingAction")%>
    </div>
</div>
<div class="epi-clear epi-width100 epi-gadget-tableWrapper">
    <table class="epi-simple epi-gadgetTable">
        <thead>
            <tr>
                <th class="epi-alignMiddle"><%= Html.CheckBox("AbuseGadget-AllSelected", false, new { title = Resource.SelectUnselectAll })%></th>
                <%=Html.TableHeader(Resource.AbuseContentHeader, "", 2)%>
                <%=Html.TableHeader(Resource.AbuseTypeHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, ReportCaseSortField.TypeID, "Index", new { currentStatus = Model.CurrentStatus })%>
                <%=Html.TableHeader(Resource.AbuseReportsHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, ReportCaseSortField.NumReports, "Index", new { currentStatus = Model.CurrentStatus })%>
                <%=Html.TableHeader(Resource.AbuseReportDateHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, ReportCaseSortField.Created, "Index", new { currentStatus = Model.CurrentStatus })%>
                <%=Html.TableHeader(Resource.AbuseStatusHeader, "", 1, Model.SortDirection.Value, Model.SortField.Value, ReportCaseSortField.ReportCaseStatus, "Index", new { currentStatus = Model.CurrentStatus })%>
            </tr>
        </thead>
        <tbody>
            <% foreach (ReportCaseItem caseItem in Model.ReportCases)
               { %>
            <tr class='<%= Html.GetRowCssClass(caseItem.Item, "epi-gadget-defaultRow", "epi-gadget-adminUserRow", "epi-gadget-currentUserRow") %>'>
                <td class="epi-alignTop">
                    <%= Html.CheckBox("ReportCases[" + Model.ReportCases.IndexOf(caseItem) + "].IsSelected", caseItem.IsSelected, new { @class="epi-gadget-checkboxAligned" })%>
                    <%= Html.Hidden("ReportCases[" + Model.ReportCases.IndexOf(caseItem) + "].ReportCaseID", caseItem.ReportCaseID, new { id = "ReportCaseID" })%>
                    <%= Html.Hidden("ReportCases[" + Model.ReportCases.IndexOf(caseItem) + "].Status", caseItem.Status, new { id = "Status" })%>
                </td>
                <td>
                    <div class="epi-gadget-previewImageWrapper">
                        <%= Html.ThumbnailWithDefault(caseItem.SnapshotItem.Image, 75, 55, Html.StripHtml(caseItem.SnapshotItem.Title).Ellipsis(20), caseItem.Item.Metadata, "epi-floatLeft", "epi-gadget-previewImage")%>
                        <%= Html.ModerateModeLink(caseItem.SnapshotItem.Author,
                            Html.Thumbnail(caseItem.SnapshotItem.Author.Image, 36, 36, Html.StripHtml(caseItem.SnapshotItem.Author.Header).Ellipsis(20), Html.GetDefaultAuthorImageUrl(caseItem.Item.IsSystemEntity), "epi-abuseGadget-authorIcon"),
                            "epi-linkBlue")%>
                        <div class="epi-gadget-imagePopup">
                            <%= Html.Thumbnail(caseItem.SnapshotItem.Image, 400, 300, Html.StripHtml(caseItem.SnapshotItem.Title).Ellipsis(30), String.Empty)%>
                        </div>
                    </div>
                </td>
                <td class="epi-width40">
                    <%= Html.ViewModeLink(caseItem.Item.ViewModeUrl, Resource.ShowOnSiteLink, "epi-alignTop")%>
                    <%= Html.ModerateModeLink(caseItem.Item, "<span class='epi-wrapNormal' title='" + Html.StripHtml(caseItem.SnapshotItem.Title) + "'>" + Html.StripHtml(caseItem.SnapshotItem.Title).Ellipsis(30) + "</span>", "epi-linkBlue")%>
                    <br />
                    <span class="epi-wrapNormal"><%= Html.StripHtml(caseItem.SnapshotItem.Html).Ellipsis(150)%></span>
                </td>
                <td>
                    <%= caseItem.Item.Type %>
                </td>
                <td class="epi-width60">
                    <table class="epi-abuseGadget-commentsTable" cellpadding="0" cellspacing="0" border="0">
                        <thead>
                            <tr>
                                <th colspan="2">
                                    <%= Html.ViewLink(Resource.AbuseReportNumberLabel + " (" + caseItem.ReportCount + ")", Resource.AbuseReportCaseShowDetailsDescription, "ReportCaseDetails", "epi-linkBlue", null, 
                                        new { reportCaseID = caseItem.ReportCaseID, currentStatus = Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection, pageNumber = Model.PageNumber })%>
                                </th>
                            </tr>                        
                        </thead>
                        <tbody>
                            <% foreach (ReportItem reportItem in caseItem.Reports)
                               { %>
                            <tr>
                                <td>
                                    <%= Html.ModerateModeLink(reportItem.Author,
                                            Html.Thumbnail(reportItem.Author.Image, 36, 36, reportItem.Author.Header.Ellipsis(20),
                                                Html.GetDefaultAuthorImageUrl(), "epi-floatLeft"),
                                        "epi-linkBlue")%>
                                </td>
                                <td class="epi-width100">
                                   <%= Html.AuthorLink(reportItem.Author) %>
                                   <span class="epi-wrapNormal"><%= Html.StripHtml(reportItem.Description).Ellipsis(100)%></span>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </td>
                <td class="epi-color-gray6">
                    <%= caseItem.ReportDate.Format() %>
                </td>
                <td>
                    <%= caseItem.StatusTitle %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
<% Html.EndForm(); %>
<%=Html.Pager(Model.Paging, "Index", Resource.PagerInfoTemplate, "pageNumber", new {currentStatus=Model.CurrentStatus, sortField = Model.SortField, sortDirection = Model.SortDirection })%>
