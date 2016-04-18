<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<CustomRedirect>>" %>
<%@ Import Namespace="BVNetwork.FileNotFound.Redirects" %>
<%@ Import Namespace="BVNetwork.FileNotFound.RedirectGadget" %>
<%@ Import Namespace="EPiServer.Cms.Shell.UI.Models.ExternalLinks" %>
<%@ Import Namespace="EPiServer.Cms.Shell" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="BVNetwork.FileNotFound.RedirectGadget.Models" %>
<%@ Import Namespace="BVNetwork.FileNotFound.DataStore" %>
<div class="epi-padding">
    <div class="notfound about">
    </div>
    <h3>
        <%=LanguageManager.Instance.Translate("/gadget/redirects/title")%>
    </h3>

       <div class="epi-formArea">
            <fieldset>
               <%=string.Format(LanguageManager.Instance.Translate("/gadget/redirects/ignoredsuggestions"), Model.Count)%>
         
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
                                       new { })%> </li>
                     <li class="epi-tabView-navigation-item">
                     <%= Html.ViewLink(
                        "Suggestions",  // html helper
                        "",  // title
                        "Index", // Action name
                                                 "epi-tabView-tab", // css class
                                         "",
                                       new { isSuggestions = true })%> </li>
              
            </ul>
        </div>
    <table class="epi-default">
        <thead>
            <tr>
                <th>
                    <label>
                        <%=LanguageManager.Instance.Translate("/gadget/redirects/url")%></label>
                </th>
                <th>
                 <%=LanguageManager.Instance.Translate("/gadget/redirects/unignore")%>
                </th>
            </tr>
        </thead>
        <%foreach (CustomRedirect m in Model) { %>
        <tr>
            <td class="redirect-longer">
                <%= Html.Encode(m.OldUrl)%>
            </td>
            <td class="shorter delete">
                <%= Html.ViewLink(
                        "",  // html helper
                        "Delete",  // title
                        "Unignore", // Action name
                        "epi-quickLinksDelete epi-iconToolbar-item-link epi-iconToolbar-delete", // css class
                        "Index",
                        new { url =  m.OldUrl })%>
            </td>
        </tr>
        <%} %>
    </table>
</div>