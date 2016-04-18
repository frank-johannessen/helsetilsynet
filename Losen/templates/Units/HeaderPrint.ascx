<%@ Control Language="c#" AutoEventWireup="false" Codebehind="HeaderPrint.ascx.cs" Inherits="development.UserControls.HeaderPrint" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
<title>
	<%=((EPiServer.PageBase)Page).Configuration.SiteName%> - <%=((EPiServer.PageBase)Page).CurrentPage["PageName"]%>
</title>
<meta name="keywords" content="<%=((EPiServer.PageBase)Page).CurrentPage["MetaKeywords"]%>">

<% if (((EPiServer.PageBase)Page).CurrentPage["MetaDescription"] != null) { %>
<meta name="description" content="<%=((EPiServer.PageBase)Page).CurrentPage["MetaDescription"]%>">
<% } else { %>
<meta name="description" content="<%=((EPiServer.PageBase)Page).CurrentPage["MetaDescriptionAll"]%>">
<% } %>

<link href="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>styles/print.css" rel="stylesheet" type="text/css">