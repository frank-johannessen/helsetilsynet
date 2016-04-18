<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Settings>" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util"%>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Activity" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>
<div class="epi-paddingHorizontal-small epi-formArea">
    <%= Html.ShellValidationSummary() %>
    
    <% Html.BeginGadgetForm("EditSettings"); %>
    <%=Html.Hidden("ShortDatePattern", Html.JqueryShortDatePattern())%>
    <fieldset>
        <legend><%=  Resource.Settings %></legend>
		<div class="cms-XFormsViewer-fieldListPanel epi-floatLeft epi-noMargin epi-activityGadget-block-activities">
			<div class="cms-XFormsViewer-fieldListPanel epi-noMargin">
				<fieldset class="epi-noMargin">
					<legend class="epi-gadget-infoIcon" title="<%=Resource.activity_segments_info %>"><%=Resource.Segments %></legend>
                    <%=Html.ActivityTree(Model.ActivityItem, "segments", "epi-checkboxTree")%>
				</fieldset>
			</div>
		</div>

		<div class="cms-XFormsViewer-fieldListPanel epi-floatLeft epi-noMargin">
			<div class="cms-XFormsViewer-fieldListPanel epi-noMargin">
				<fieldset class="epi-noMargin">
					<legend><%=Resource.TimeInterval %></legend>
					<div class="epi-size5">
                        <div>
                            <%=Html.LabeledCheckBox("UseDateInterval", Resource.ShowDateInterval, Model.UseDateInterval, new {}, new { @class = "epi-nowrap " })%>
                        </div>
                        <div>
                            <label for="FromDate"><%=Resource.From %></label>
                            <%=Html.TextBox("FromDate", Html.ShortDate(Model.FromDate), new { @class = "epi-size3 required" })%>
                        </div>
                        <div>
                            <label for="ToDate"><%=Resource.To %></label>
                            <%=Html.TextBox("ToDate", Model.ToDate.HasValue ? Html.ShortDate(Model.ToDate.Value) : string.Empty, new { @class = "epi-size3" })%>
                        </div>
                    </div>
				</fieldset>
			</div>
		</div>
    </fieldset>
    <div class="epi-buttonContainer-simple">
            <% =Html.AcceptButton(new { @class="epi-button-child-item"}) %>
            <% =Html.CancelButton(new { @class="epi-button-child-item"}) %>
    </div>    
    <% Html.EndForm(); %>
</div>
