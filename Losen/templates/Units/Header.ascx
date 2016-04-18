<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Header.ascx.cs" Inherits="development.Templates.Units.Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
<title>
	<%=((EPiServer.PageBase)Page).CurrentPage["PageName"]%>
</title>
<meta name="keywords" content="<%=((EPiServer.PageBase)Page).CurrentPage["MetaKeywords"]%>">
<% if (CurrentPage["MetaDescription"] != null) { %>
<meta name="description" content="<%#CurrentPage["MetaDescription"]%>">
<% } else { %>
<meta name="description" content="<%#CurrentPage["MetaDescriptionAll"]%>">
<% } %>
<asp:Literal ID="MetaTagGenerator" Runat="server"/>

<link href="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>styles/helsetilsynet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/mondosoft.css" />

<script language="JavaScript" src="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>util/javascript/system.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
//Used for pop-up windows 
 var my_popup;
   function MM_openBrWindow(theURL,winName,features) {
      if (my_popup) {
         if (my_popup.closed){
         }
         else {
            my_popup.close();
         }
      }
      my_popup = window.open(theURL,winName,features);
   } 
//-->
</SCRIPT>