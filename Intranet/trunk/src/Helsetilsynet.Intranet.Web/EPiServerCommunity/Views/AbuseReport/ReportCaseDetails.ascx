<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ReportCaseDetailsData>" %>
<%@ Import Namespace="EPiServer.Community" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.AbuseReport" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Shell.Web" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Shared" %>
<% Html.BeginGadgetForm("UpdateStatus", new { currentStatus = Model.ViewData.CurrentStatus, sortField = Model.ViewData.SortField, sortDirection = Model.ViewData.SortDirection, pageNumber = Model.ViewData.PageNumber }); %>
<div class="epi-margin-small epi-floatLeft">
    <%= Html.ViewLink(Resource.BackLinkText, Resource.BackLinkDescription, "Index", "epi-linkBlue", null, new { currentStatus = Model.ViewData.CurrentStatus, sortField = Model.ViewData.SortField, sortDirection = Model.ViewData.SortDirection, pageNumber = Model.ViewData.PageNumber} )%>
</div>
<div class="epi-marginHorizontal-small epi-marginBottom-small epi-clear epi-floatLeft">
    <div class="epi-floatLeft">
        <%=Html.ActionButtons<AbuseHandlingAction>(Model.ReportCase.AbuseHandlingLinks)%>
        <%=Html.Hidden("abuseHandlingAction")%>
        <%= Html.Hidden("ReportCases[0].IsSelected", true, new { id = "IsSelected" })%>
        <%= Html.Hidden("ReportCases[0].ReportCaseID", Model.ReportCase.ReportCaseID, new { id = "ReportCaseID" })%>
        <%= Html.Hidden("ReportCases[0].Status", Model.ReportCase.Status, new { id = "Status" })%>
    </div>
    <span class="epi-floatLeft epi-gadgets-actionButtonsLabel"><span class="epi-color-gray6"><%= Resource.AbuseStatusHeader %></span>: <%= Model.ReportCase.StatusTitle %></span>
</div>
<div class="epi-marginHorizontal-small epi-clear epi-overflowHidden epi-abuseGadget-snapshotWrapper">
    <h4><%= Resource.AbuseReportedItemSummary %></h4>
    <table class="epi-simple epi-gadgetTable epi-abuseGadget-snapshotItem epi-noMargin">
        <tbody>
            <tr>
                <td class="epi-width1">
                    <div class="epi-gadget-previewImageWrapper">
                        <%= Html.ThumbnailWithDefault(Model.ReportCase.SnapshotItem.Image, 75, 55, Model.ReportCase.SnapshotItem.Title.Ellipsis(20), Model.ReportCase.Item.Metadata, "epi-floatLeft", "epi-gadget-previewImage")%>
                        <div class="epi-gadget-imagePopup">
                            <%= Html.Thumbnail(Model.ReportCase.SnapshotItem.Image, 400, 300, Html.StripHtml(Model.ReportCase.SnapshotItem.Title).Ellipsis(30), String.Empty)%>
                        </div>
                    </div>
                    <%= Model.ReportCase.Item.Type %>
                </td>
                <td class="epi-abuseGadget-snapshotDescription">
                    <%= Html.ViewModeLink(Model.ReportCase.Item.ViewModeUrl, Resource.ShowOnSiteLink, "epi-alignTop")%>
                    <%= Html.ModerateModeLink(Model.ReportCase.Item, "<span class='epi-wrapNormal'>" + Html.Encode(Model.ReportCase.SnapshotItem.Title) + "<span>", "epi-linkBlue")%>
                    <br />
                    <div class="epi-abuseGadget-snapshotContentWrapper epi-wrapNormal">
                        <%= Model.ReportCase.SnapshotItem.Html %>
                    </div>
                </td>
                <td class="epi-width1" style="min-width: 150px;">
                    <%= Html.ModerateModeLink(Model.ReportCase.SnapshotItem.Author,
                                              Html.Thumbnail(Model.ReportCase.SnapshotItem.Author.Image, 36, 36,
                                                             Model.ReportCase.SnapshotItem.Author.Header.Ellipsis(20),
                                                             Html.GetDefaultAuthorImageUrl(Model.ReportCase.Item.IsSystemEntity), "epi-floatLeft", "epi-authorIcon", "epi-marginRight-small", "epi-wrapNormal"),
                                              "epi-linkBlue")%>
                    <%= Html.AuthorLink(Model.ReportCase.SnapshotItem.Author)%>
                    <br />                    
                    <span class="epi-color-gray6"><%= Model.ReportCase.ReportDate.Format() %></span>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="epi-overflowHidden epi-margin-small">
    <div class="epi-floatLeft epi-width50">
        <h4><%= Resource.AbuseReportNumberLabel %> (<%= Model.ReportCase.ReportCount %>)</h4>
        <div class="epi-marginRight-small epi-abuseGadget-vScroll" style="overflow-x: hidden;">
            <table class="epi-abuseGadget-commentsTable" id="abuseGadgetItemReports" width="100%">
                <tbody>
                    <% foreach (ReportItem reportItem in Model.ReportCase.Reports)
                       { %>
                    <tr>
                        <td>
                            <%= Html.ModerateModeLink(reportItem.Author,
                                    Html.Thumbnail(reportItem.Author.Image, 36, 36, reportItem.Author.Header.Ellipsis(20),
                                        Html.GetDefaultAuthorImageUrl(), "epi-floatLeft"),
                                    "epi-linkBlue")%>
                            <div class="epi-abuseGadget-commentTeaser">
                                <%= Html.AuthorLink(reportItem.Author)%>
                                &nbsp; <span class="epi-color-gray6"><%= reportItem.ReportDate.Format()%></span>&nbsp; 
                                <%--<%= Html.ViewModeLink(reportItem.Url, Resource.AbuseReportFoundOnPageDescription, Resource.AbuseReportFoundOnPageText, "epi-linkBlue")%>--%>
                                <br />
                                <span class="epi-wrapNormal"><%= Html.StripHtml(reportItem.Description).Ellipsis(100) %></span>
                                <%= Html.ScriptData("ReportID", reportItem.ReportID.ToString()) %>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="epi-floatRight epi-width50" style="_margin-left: -0.8em;">
        <h4><%= Resource.AbuseReportText %></h4>
        <div class="epi-abuseGadget-vScroll">
            <div class="epi-abuseGadget-reportDetailed"></div>
    </div>
</div>
<% Html.EndForm(); %>
