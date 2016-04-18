<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Community.Gadgets.Models.AbuseReport.UsersViewData>" %>
<%@ Import Namespace="EPiServer.Common.Reporting" %>
<%@ Import Namespace="EPiServer.Community" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.AbuseReport" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Web" %>
<div class="epi-margin-small epi-overflowHidden">

    <div class="epi-gadgetShortlinks epi-floatLeft">
       <%=Html.FilterButtons(Model.Perspectives, "ReportingReported", "currentPerspective", "epi-gadgetShortlinks-active", "", 
            new { sortField = Model.SortField, sortDirection = Model.SortDirection})%>
    </div>
    <div class="epi-floatRight">
        <ul class="epi-gadget-iconSwitch">
            <li class="epi-gadget-iconSwitch-itemFirst">
                <%=Html.ViewLink("<img src='" + VirtualPathUtilityEx.ToAbsolute("~/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-table.png") +"' />", 
                    "Abuse reports", "Index", new { title = Resource.ReportedItemsTooltip })%>
            </li>
            <li class="epi-gadget-iconSwitch-itemLast epi-gadget-iconSwitch-active">
                <a href="#">
                    <img src="<%=VirtualPathUtilityEx.ToAbsolute("~/EPiServerCommunity/ClientResources/SharedResources/Resources/layoutIcon-users-active.png") %>" title="<%= Resource.ReportingReportedUsersTooltip %>" />
                </a>
            </li>
        </ul>
    </div>
</div>
<div class="epi-marginHorizontal-small epi-marginBottom-small epi-clear">
    <h4><%=Model.TableHeader %></h4>
</div>

<table class="epi-simple epi-gadgetTable">
    <thead>
        <tr>
            <%=Html.TableHeader(Resource.AbuseUsersHeaderUser, "epi-width25", 2) %>
            <%=Html.TableHeader(Resource.AbuseUsersHeaderNew, "epi-width25", 1, Model.SortDirection.Value, Model.SortField.Value, UserReportsSortField.NumNewReports, "ReportingReported", new { currentPerspective = Model.CurrentPerspective })%>
            <%=Html.TableHeader(Resource.AbuseUsersHeaderIgnored, "epi-width25", 1, Model.SortDirection.Value, Model.SortField.Value, UserReportsSortField.NumIgnoredReports, "ReportingReported", new { currentPerspective = Model.CurrentPerspective })%>
            <%=Html.TableHeader(Resource.AbuseUsersHeaderHandled, "epi-width25", 1, Model.SortDirection.Value, Model.SortField.Value, UserReportsSortField.NumHandledReports, "ReportingReported", new { currentPerspective = Model.CurrentPerspective })%>
        </tr>
    </thead>
    <tbody>
        <% foreach (ReportUserItem userItem in Model.ReportUsers) {%> 
            <tr>
                <td class="epi-width1">
                    <div class="epi-gadget-previewImageWrapper">
                        <%= Html.ThumbnailWithDefault(userItem.Item.Image, 75, 55, userItem.Item.Header, "User", "epi-floatLeft", "epi-gadget-previewImage")%>
                        <div class="epi-gadget-imagePopup">
                            <%= Html.Thumbnail(userItem.Item.Image, 400, 300, userItem.Item.Header, String.Empty)%>
                        </div>
                    </div>
                </td>
                <td>
                    <%= Html.AuthorLink(userItem.Item) %>
                </td>
                <td>
                    <%=userItem.NewReports %>
                </td>
                <td>
                    <%=userItem.IgnoredReports %>
                </td>
                <td>
                    <%=userItem.HandledReports %>
                </td>
            </tr>
        <%} %>        
    </tbody>    
</table>
<div class="epi-clear epi-paddingHorizontal-small epi-color-gray6"><%=Resource.AbuseFilteringWarning%></div>
<%=Html.Pager(Model.Paging, "ReportingReported", Resource.PagerInfoTemplate, "pageNumber", new { currentPerspective = Model.CurrentPerspective, sortField = Model.SortField, sortDirection = Model.SortDirection })%>