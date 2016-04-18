<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportedContentInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ReportedContentInfoControl" %>
<script src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css">

<table class="table" cellpadding="0" cellspacing="0" width="100%">
    <thead>
	    <tr>
		    <th class="td"><%=GetTranslation("EPiServer.Community.Reporting.headingReportInformation")%></th>
	    </tr>
	</thead>
	    <tbody>
	        <tr>
	            <td class="label"><i><% = GetTranslation("EPiServer.Community.Reporting.firstReportBy") %></i> <asp:Label ID="labelCreated" runat="server" /></td>
	        </tr>
	        <tr>
	            <td class="td">URL: <asp:Label ID="labelCreatedBy" runat="server" /></td>
	        </tr>
	        <tr>
	            <td class="td"><% =GetTranslation("EPiServer.Community.Reporting.labelItemType")%> <asp:Label ID="labelItemType" runat="server" /></td>
	        </tr>
	        <tr style="padding-top:10px;">
	            <th><% = GetTranslation("EPiServer.Community.Reporting.ReportedContent") %></th>
	        </tr>
	        <tr>
	            <td class="td"><% = GetTranslation("EPiServer.Community.Reporting.Title") %> <asp:Label ID="labelTitle" runat="server" /></td>
	        </tr>
            <tr>
                <td class="td">
                    <asp:Panel ID="panelReportedContent" runat="server" />
                </td>
            </tr>
        </tbody>
    <thead>
	<tr>
		<td class="td"><% = GetTranslation("EPiServer.Community.Reporting.Log") %></td>
	</tr>
	</thead>
	<tbody>
	    <table class="table">
	        <tr>
	            <td class="td"><% = GetTranslation("EPiServer.Community.Reporting.type") %></td>
	            <td class="td"><% = GetTranslation("EPiServer.Community.Reporting.Date") %></td>
	            <td class="td"><% = GetTranslation("EPiServer.Community.Reporting.User") %></td>
	            <td class="td">IP</td>
	        </tr>
	        <asp:Repeater ID="repeaterLog" runat="server">
	            <ItemTemplate>
	                <tr>
	                    <td class="td"><%# DataBinder.Eval(Container.DataItem, "LogType") %></td>
	                    <td class="td"><%# GetDate(Container.DataItem) %></td>
	                    <td class="td"><%# GetUser(Container.DataItem) %></td>
	                    <td class="td"><%# DataBinder.Eval(Container.DataItem, "IP") %></td>
	                </tr>
	            </ItemTemplate>
	        </asp:Repeater>
	    </table>
	</tbody>
</table>