<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LosenAlphabethicalIndexItem.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.LosenAlphabethicalIndexItem" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex" %>
<asp:Repeater runat="server" ID="rptItems">
    <HeaderTemplate>
        <div class="links">
    </HeaderTemplate>
    <ItemTemplate>
            <a href="<%# ((LosenAlphabethicalItem)Container.DataItem).Url %>"><%# ((LosenAlphabethicalItem)Container.DataItem).Title %></a>
    </ItemTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>