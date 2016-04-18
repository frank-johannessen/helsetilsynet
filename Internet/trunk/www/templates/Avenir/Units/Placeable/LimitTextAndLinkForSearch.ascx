<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LimitTextAndLinkForSearch.ascx.cs"
    Inherits="Helsetilsynet.templates.Avenir.Units.Placeable.LimitTextAndLinkForSearch" %>
    <p class="search-tip">
       <span class="has-tooltip" ><%=((EPiServer.PageBase)Page).CurrentPage.Property["LimitTxt"]%></span>
       <span class="is-tooltip" ><%= GetToolTipData() %></span>
    </p>
