<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayUserCollection.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.DisplayUserCollection" %>
<%@ Import Namespace="EPiServer.Common.Security" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:ListView ID="lvUsers" ItemPlaceholderID="pnlItemContainer" runat="server"  >
    <LayoutTemplate>
        <ul class="user-collection">
            <asp:Panel ID="pnlItemContainer" runat="server" />
        </ul>
    </LayoutTemplate>
    <ItemTemplate>
        <li>
            <a href="<%# ((IUser)Container.DataItem).GetMyPageUri() %>">
                <img src="<%# ((IUser)Container.DataItem).GetPortraitUri(Enums.ImageSize.Medium) %>" alt="<%# ((IUser)Container.DataItem).GetPresentationName() %>" />
                <span><%# ((IUser)Container.DataItem).GivenName %></span>
            </a> 

            <asp:LinkButton 
                        ID="lbRemoveContacts" 
                        CommandArgument="<%# ((IUser)Container.DataItem).ID %>" 
                        OnCommand="lbRemoveContacts_Command" 
                        runat="server"
                        CssClass="action delete"
                        OnClientClick="<%# GetConfirmDelete() %>"
                        Visible="<%# DisplayRemoveButton && CurrentUser == DisplayUser %>"><%= Translate("/general/remove")%></asp:LinkButton>

        </li>
    </ItemTemplate>   
</asp:ListView>