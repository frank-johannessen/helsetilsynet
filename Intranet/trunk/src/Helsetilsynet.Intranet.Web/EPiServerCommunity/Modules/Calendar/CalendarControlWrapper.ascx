<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarControlWrapper.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarControlWrapper" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="CalendarControl" Src="CalendarControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript" src="Administration.js"></script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<sc:CalendarControl id="calendarControl" runat="server"></sc:CalendarControl>
