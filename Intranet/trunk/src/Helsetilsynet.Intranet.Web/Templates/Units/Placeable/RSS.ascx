<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RSS.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.RSS" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable" %>
<asp:Repeater runat="server" ID="rptRss">
    <HeaderTemplate>
        <ul class="rss-feed-list <%= CssClass %>">
    </HeaderTemplate>
    <ItemTemplate>
            <li>
                <a href="<%# ((RssItem)Container.DataItem).Link %>" target="_blank">
                    <h3><%# ((RssItem)Container.DataItem).Title %></h3>
                    <p><%# ((RssItem)Container.DataItem).Description %></p>
                    <span class="pubdate"><%# ((RssItem)Container.DataItem).PubDate %></span>
                </a>
            </li>        
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>
<asp:Label ID="lblError" Text="Problem med å laste RSS" runat="server" Visible="false"></asp:Label>
<asp:Label ID="lblDebugError" ForeColor="Red" runat="server" Visible="false"></asp:Label>
  