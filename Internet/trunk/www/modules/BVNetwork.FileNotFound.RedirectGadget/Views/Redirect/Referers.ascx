<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dictionary<string,int>>" %>
<%@ Import Namespace="BVNetwork.FileNotFound.RedirectGadget" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="epi-padding">
    <h3>
        <%=LanguageManager.Instance.Translate("/gadget/redirects/title")%>
    </h3>
    <div class="epi-formArea">
        <fieldset>
            Referers for <i>
                <%=ViewData["refererUrl"].ToString() %></i>
        </fieldset>
    </div>
    <div class="notfound epi-tabView">
        <ul class="epi-tabView-navigation">
            <li class="epi-tabView-navigation-item">
                <%= Html.ViewLink(
                        "Custom Redirects",  // html helper
                        "",  // title
                        "Index", // Action name
                                                 "epi-tabView-tab", // css class
                                         "",
                                       new { })%>
            </li>
            <li class="epi-tabView-navigation-item">
                <%= Html.ViewLink(
                        "Suggestions",  // html helper
                        "",  // title
                        "Index", // Action name
                                                 "epi-tabView-tab", // css class
                                         "",
                                       new { isSuggestions = true })%>
            </li>
        </ul>
    </div>
    <table class="epi-default">
        <thead>
            <tr>
                <th>
                    Referers
                </th>
            </tr>
        </thead>
        <%   foreach (var referer in Model)
             {
        %>
        <tr>
            <td class="longer">
                <span><a style="color: #398AC9; cursor: pointer" href="<%= Html.Encode(referer.Key)%>">
                    <%= Html.Encode(referer.Key)%></a><%= string.Format("<i> ({0} errors)</i>", referer.Value)%></span>
            </td>
        </tr>
        <%
             } %>
    </table>
</div>
