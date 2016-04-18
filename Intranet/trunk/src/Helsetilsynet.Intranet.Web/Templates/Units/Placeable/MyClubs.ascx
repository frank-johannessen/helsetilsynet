<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyClubs.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MyClubs" %>
<%@ Import Namespace="EPiServer.Community.Club" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<div class="section my-project-rooms">
    <h2 class="heading"><%= CurrentUser != DisplayUser ? Translate("/usercontrolheadings/othersprojectrooms") : Translate("/usercontrolheadings/myprojectrooms")%></h2>
    <asp:ListView ID="lvMyClubs" ItemPlaceholderID="pnlItemContainer" runat="server"  >
        <LayoutTemplate>
            <asp:Panel ID="pnlItemContainer" runat="server" />
        </LayoutTemplate>
        <ItemTemplate>
            <ul>
                <li><a href="<%# ((Club)Container.DataItem).GetClubUri() %>" title="<%# ((Club)Container.DataItem).Header %>"><%# ((Club)Container.DataItem).Header %></a></li>
            </ul>
        </ItemTemplate>
        <%--<EmptyDataTemplate >
            <p><a href="<%= RelateTemplatePage<BasePage>.ClubHomePage.LinkURL %>" title="<%= RelateTemplatePage<BasePage>.ClubHomePage.PageName %>"><%= Translate("/club/addroomsonclubpage")%></a></p>
        </EmptyDataTemplate> --%>      
    </asp:ListView>
</div>