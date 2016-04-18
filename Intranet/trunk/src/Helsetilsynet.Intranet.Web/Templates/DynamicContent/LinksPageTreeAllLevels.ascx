<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinksPageTreeAllLevels.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.LinksPageTreeAllLevels" %>

<!--googleoff: index-->

<EPiServer:PageList ID="plPages" runat="server" EnableVisibleInMenu="True" >
    <ItemTemplate>
        <EPiServer:Property runat="server" CustomTagName="li" PropertyName="PageLink" />
    </ItemTemplate>
</EPiServer:PageList>

<!--googleon: index-->