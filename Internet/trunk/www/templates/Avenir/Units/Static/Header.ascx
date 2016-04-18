<%@ Control Language="C#" EnableViewState="false" AutoEventWireup="False" CodeBehind="Header.ascx.cs" Inherits="Avenir.Templates.Units.Static.Header" %>
<%@ Import Namespace="SquishIt.Framework" %>
<meta name="verify-v1" content="984V3ST1A?TKywaJsDm47/1MpOvW0P49sNPvHjkU/s=" />
<meta name="google-site-verification" content="jHIQ2svFnq91_8V_K6F65JdG_7pr601qepuZs_IDc60" />
<meta name="HandheldFriendly" content="True" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta content='width=device-width, initial-scale=1.0 user-scalable=1' name='viewport' />
<asp:Literal ID="meta" runat="server"></asp:Literal>
<script src="https://speech.leseweb.dk/script/98hsd55sdghg.js" type="text/javascript"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<link rel="SHORTCUT ICON" href="<%= ResolveUrl("~/htil.ico") %>" /> 
 
<%= Bundle.Css()
        .Add("~/Templates/Avenir/Styles/base.css")
        .Add("~/Templates/Avenir/Styles/main-menu.css")
        .Add("~/Templates/Avenir/Styles/helsetilsynet.css")
        .Add("~/templates/Avenir/styles/webparts.css")
        .Add("~/templates/Avenir/styles/responsive-tables.css")
        .Render("~/templates/Avenir/styles/combined_#.css")
%>

<link rel="alternate" type="application/rss+xml" href="/ts/rss/?r=true&g=dokumenttype:Nyhet" title="Nyheter" />  
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=kode%3ahtil&r=true" title="Tilsynsrapporter" />  
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3a%c3%98stfold&r=true" title="Tilsynsrapporter Østfold" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke:Akershus&r=true" title="Tilsynsrapporter Akershus" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aOslo&r=true" title="Tilsynsrapporter Oslo" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aHedmark&r=true" title="Tilsynsrapporter Hedmark" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aOppland&r=true" title="Tilsynsrapporter Oppland" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aBuskerud&r=true" title="Tilsynsrapporter Buskerud" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aVestfold&r=true" title="Tilsynsrapporter Vestfold" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aTelemark&r=true" title="Tilsynsrapporter Telemark" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aAust-Agde&r=true" title="Tilsynsrapporter Aust-Agder" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aVest-Agder&r=true" title="Tilsynsrapporter Vest-Agder" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aRogaland&r=true" title="Tilsynsrapporter Rogaland" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aSogn+og+Fjordane&r=true" title="Tilsynsrapporter Sogn og Fjordane" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aM%c3%b8re+og+Romsdal&r=true" title="Tilsynsrapporter Møre og Romsdal" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aS%c3%b8r-Tr%c3%b8ndelag&r=true" title="Tilsynsrapporter Sør-Trøndelag" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aNordland" title="Tilsynsrapporter Nordland&r=true" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aTroms" title="Tilsynsrapporter Troms&r=true" />
<link rel="alternate" type="application/rss+xml" href="/ts/rss?g=fylke%3aFinnmark" title="Tilsynsrapporter Finnmark&r=true" />
<EPiServer:PageList ID="RssList" PageLinkProperty="RssContainer" runat="server">
    <ItemTemplate>
        <%#GetRss(Container.CurrentPage)%>
    </ItemTemplate>
</EPiServer:PageList>   
