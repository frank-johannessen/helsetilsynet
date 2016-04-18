<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MinimalCalendarViewDateItems.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MinimalCalenderViewItem" %>
<%@ Register TagPrefix="ht" TagName="tags" Src="~/Templates/Units/Placeable/Tags.ascx" %>
<%@ Import Namespace="EPiServer.Community.Calendar" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>
<asp:Repeater runat="server" ID="rptItems">
    <HeaderTemplate>
        <ol>
    </HeaderTemplate>
    <ItemTemplate>
            <li class="vevent">
                <div class="vevent-details">
                    <abbr class="dtstart" title="<%# ((Event)Container.DataItem).StartDate.ToString("yyyy-MM-dd hh:mm:sszz") %>"><%# ((Event)Container.DataItem).StartDate.ToString("HH:mm") %></abbr>
                    <abbr class="dtend" title="<%# ((Event)Container.DataItem).EndDate.ToString("yyyy-MM-dd hh:mm:sszz") %>"><%# ((Event)Container.DataItem).EndDate.ToString("HH:mm") %></abbr>
                    <ht:tags ID="Tags1" runat="server" Categories="<%# ((Event)Container.DataItem).GetServiceAreas() %>" />
                </div>
                <div class="vevent-summary">
                    <span class="summary">
                        <asp:PlaceHolder runat="server" Visible="<%# ((Event)Container.DataItem).GetArticleLink() != string.Empty && ((Event)Container.DataItem).GetArticleLink() != null %>"><a href="<%# ((Event)Container.DataItem).GetArticleLink() %>" title="<%# ((Event)Container.DataItem).Header %>"><%# ((Event)Container.DataItem).Header %></a></asp:PlaceHolder>
                        <asp:PlaceHolder runat="server" Visible="<%# ((Event)Container.DataItem).GetArticleLink() == string.Empty || ((Event)Container.DataItem).GetArticleLink() == null %>"><%# ((Event)Container.DataItem).Header %></asp:PlaceHolder>
                    </span>
                    <p class="description"><%# ((Event)Container.DataItem).Body %></p>
                    <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="<%# IsCurrentUserAdminOrOwner(((Event)Container.DataItem)) %>">
                        <div class="actions">
                            <asp:LinkButton runat="server" ID="lbEditEvent" Visible="<%# IsCurrentUserAdminOrOwner(((Event)Container.DataItem)) %>" OnCommand="lbEditEvent_OnCommand" CommandArgument="<%# ((Event)Container.DataItem).ID %>" Text="<%$ Resources: EPiServer, general.edit %>" /> &nbsp; <asp:LinkButton runat="server" ID="lbDeleteEvent" Visible="<%# IsCurrentUserAdminOrOwner(((Event)Container.DataItem)) %>" OnClientClick="<%# GetConfirmDelete()  %>" OnCommand="lbDeleteEvent_OnCommand" CommandArgument="<%# ((Event)Container.DataItem).ID %>" Text="<%$ Resources: EPiServer, general.delete %>" />
                        </div>
                    </asp:PlaceHolder>
                </div>
            </li>        
    </ItemTemplate>
    <FooterTemplate>
        </ol>
    </FooterTemplate>
</asp:Repeater>