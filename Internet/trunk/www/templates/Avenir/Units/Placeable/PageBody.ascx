<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PageBody.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.PageBody" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>

<%=GetBody %>
<episerver:property  id="pageBody" runat="server" propertyname="MainBody" Visible="true"></episerver:property>

