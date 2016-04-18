<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BVNetwork.FileNotFound.RedirectIndexViewData>" %>
<%@ Import Namespace="BVNetwork.FileNotFound" %>
<%@ Import Namespace="EPiServer.Cms.Shell" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="cms-externalLinks">
    <%
        
        if(Model.IsSuggestions)
            Html.RenderPartial("Suggestions", Model);
        else
            Html.RenderPartial("Redirects", Model);

        Html.RenderPartial("Pager", Model);
    %>
</div>
    