<%@ Control Language="C#" AutoEventWireup="false" 
            CodeBehind="SistPubliserte.ascx.cs" 
            Inherits="Avenir.Templates.Webparts.Units.SistPubliserte" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/GoogleShortList.ascx" %>


	<div class="box">
		<h2>Sist publiserte</h2>
	    <ht:ChangedPages ID="ChangedPages" runat="server" />
		<p class="readMore"><a href="<%=getAlleSakerLink() %>"><%=((EPiServer.PageBase)Page).CurrentPage.Property["ShowAllTxt"]%></a></p>
	</div>


