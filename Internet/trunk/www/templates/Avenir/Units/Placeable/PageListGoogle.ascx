<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageListGoogle.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.PageListGoogle" %>
<%@ Register TagPrefix="ht" TagName="PageList"	Src="~/templates/Avenir/Units/Placeable/PageList.ascx" %>
	<%=GetGoogleList() %>
	<%=GetEpiList() %>
   <%-- <ht:PageList ID="PageList"
        PageLinkProperty="MainListRoot"
        ShowTopRuler="true" 
        runat="server" />--%>
