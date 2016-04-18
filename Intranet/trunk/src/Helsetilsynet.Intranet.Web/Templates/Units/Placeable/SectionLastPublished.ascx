<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SectionLastPublished.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.SectionLastPublished" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Util.GoogleMini" %>

<div class="section feeds">
    <h2>Sist publisert på Losen</h2>
    
        <asp:Repeater runat="server" ID="rptLastPublishedLosen">
            <HeaderTemplate><ul class="rss-feed-list tabbody"></HeaderTemplate>
            <ItemTemplate>
            <li>
                <a href="<%# ((ResultElement)Container.DataItem).Url %>">
                    <h3><%# ((ResultElement)Container.DataItem).Title %></h3>
                    <p class="summary"><%# ((ResultElement)Container.DataItem).Description %></p>
                    <span class="pubdate"><%# FormatDateTime(((ResultElement)Container.DataItem).Date, "dd.MM.yyyy", "") %></span>
                </a>
            </li>   
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
        
    <h2>Sist publisert på htil.no</h2>
    
        <asp:Repeater runat="server" ID="rptLastPublishedHtil">
            <HeaderTemplate><ul class="rss-feed-list tabbody"></HeaderTemplate>
            <ItemTemplate>
            <li>
                <a href="<%# ((ResultElement)Container.DataItem).Url %>">
                    <h3><%# ((ResultElement)Container.DataItem).Title %></h3>
                    <p class="summary"><%# ((ResultElement)Container.DataItem).Description %></p>
                    <span class="pubdate"><%# FormatDateTime(((ResultElement)Container.DataItem).Date, "dd.MM.yyyy", "") %></span>
                </a>
            </li>  
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
    
   
</div>