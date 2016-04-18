<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tags.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.Tags" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable" %>
<asp:Repeater runat="server" ID="rptTags">
    <HeaderTemplate>
        <p class="tags">
            <span class="label">kategorier: </span>
    </HeaderTemplate>
    <ItemTemplate>
            <a rel="tag" title="<%# ((TagItem)Container.DataItem).Description %>" class="<%# ((TagItem)Container.DataItem).ClassName %>"><%# ((TagItem)Container.DataItem).Description %></a>
    </ItemTemplate>
    <FooterTemplate>
        </p>
    </FooterTemplate>
</asp:Repeater>
