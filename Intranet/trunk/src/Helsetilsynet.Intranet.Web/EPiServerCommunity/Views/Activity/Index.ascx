<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Settings>" %>
<%@ Import Namespace="EPiServer.Common.EventCounter" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Models.Activity" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="EPiServer.Community.Gadgets.Resources" %>

<div class="epi-gadgetContent">
    <%=Html.Hidden("Resolution", (int)Model.Resolution) %>
    <%=Html.Hidden("DateFormatContainer", Resource.activity_DateFormat.Replace(",","$comma$"))%>
    <input id="CurrentCultureContainer" type="hidden" value="<%=Thread.CurrentThread.CurrentCulture.Name %>" />
    
    <input type="hidden" id="GadgetContext_<%=Model.GadgetID %>" />
    <div class="epi-padding">
        <h3 class="epi-floatLeft" id="label_<%=Model.GadgetID %>"></h3>
		<div class="epi-gadgetShortlinks epi-floatRight">
			<span class="epi-floatLeft"><%=Resource.ActivityGraphBy %>&nbsp;</span>
			<%=Html.ResolutionSelectors(Model.ResolutionsAvailability) %>
		</div>
		<div id="SilverlightActivityChartHost"  class="epi-floatLeft epi-paddingVertical" style="height:350px; width:100%"/>
        <iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
    </div>
</div>