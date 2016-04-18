<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Settings>" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Approval" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Shared" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<div class="epi-paddingHorizontal-small epi-formArea">
    <%= Html.ShellValidationSummary() %>
    <% Html.BeginGadgetForm("EditSettings"); %>
    <fieldset>
        <legend><%=  Resource.Settings %></legend>
		<div class="epi-size20">
			<div>
			    <%=Html.LabeledTextBox("PageSize", Resource.PageSize, Model.PageSize, new { @class = "epi-size3 required" }, new { })%>
			</div>
			<div>
			    <%=Html.LabeledTextBox("PreviewLength", Resource.ApprovalPreviewLength, Model.PreviewLength, new { @class = "epi-size3 required"}, new { })%>
			</div>
			<div>
			    <%=Html.LabeledCheckBox("IsSystemContentShown", Resource.ApprovalShowSystemGeneratedContent, Model.IsSystemContentShown) %>
			</div>
			<div class="cms-XFormsViewer-fieldListPanel">
				<div class="cms-XFormsViewer-fieldListPanel">
					<fieldset>
						<legend><%=Resource.ItemsToShow %></legend>
						<ul>
						<% foreach (ContentTypeItem item in Model.ApprovalTypeItems){ %>
                            <li class="epi-paddingVertical-xsmall">
                                <%=Html.LabeledCheckBox("ApprovalTypeItems[" + Model.ApprovalTypeItems.IndexOf(item)+ "].Selected", item.Title, item.Selected)%>
                                <%=Html.Hidden("ApprovalTypeItems[" + Model.ApprovalTypeItems.IndexOf(item) + "].Name", item.Name)%>
                            </li>
                        <% } %>
						</ul>
					</fieldset>
				</div>
			</div>
		</div>
    </fieldset>
    <div class="epi-buttonContainer-simple">
        <% =Html.AcceptButton(new { @class="epi-button-child-item"}) %>
        <% =Html.CancelButton(new { @class="epi-button-child-item"}) %>
    </div>
    <% Html.EndForm(); %>
</div>
