<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MediaWatch.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.MediaWatch" %>
<div class="section">
    <h2 class="heading">Medieovervåking</h2>
    <asp:Repeater runat="server" ID="rptMediaWatch">
        <ItemTemplate>
            <p><a target="_blank" class="media-monitor-link" href="<%# ((EPiServer.SpecializedProperties.LinkItem)Container.DataItem).Href %>"><%# ((EPiServer.SpecializedProperties.LinkItem)Container.DataItem).Text %></a></p>
        </ItemTemplate>
    </asp:Repeater>
</div>