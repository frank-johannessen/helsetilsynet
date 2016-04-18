<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="ClubPage.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.ClubPage" %>
<%@ Register tagPrefix="Relate" tagName="ClubMembers" src="~/Templates/Units/Placeable/ClubMembers.ascx" %>
<%@ Register tagPrefix="Relate" tagName="Calendar" src="~/Templates/Units/Placeable/MinimalCalendarView.ascx" %>
<%@ Register tagPrefix="Relate" tagName="CreateBlogEntry" src="~/Templates/Units/Placeable/CreateBlogEntry.ascx" %>
<%@ Register tagPrefix="Relate" tagName="ClubBookmarks" src="~/Templates/Units/Placeable/MyBookmarks.ascx" %>
<%@ Register tagPrefix="ht" tagName="LeftMenu" src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>
<%@ Register TagPrefix="relate" TagName="AddNewClub" Src="~/Templates/Units/Placeable/AddNewClub.ascx" %>
<%@ Register TagPrefix="ht" TagName="pager" Src="~/Templates/Units/Placeable/ResultPager.ascx" %>
<%@ Import Namespace="EPiServer.Community.Blog" %>
<%@ Import Namespace="EPiServer.Community.Club" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="section main-content">
        <h1><span><%= CurrentClub.Header %></span></h1>
        <img src="<%= CurrentClub.GetPresentationImageUri(Enums.ImageSize.Large) %>" alt="<%= CurrentClub.Header %>" class="project-logo" />
        <dl class="project-meta">
            <dt><%= Translate("/general/admin") %></dt>
            <dd><%= CurrentClub.Owner.GetPresentationName() %></dd>
            <dt><%= Translate("/club/status") %></dt>
            <dd><%= CurrentClub.SecurityStatus != SecurityStatus.Open ? Translate("/club/securitystatusclosed") : Translate("/club/securitystatusopen") %></dd>
            <dt><%= Translate("/general/created") %></dt>
            <dd><%= CurrentClub.Created %></dd>
        </dl>

        <div class="project-description">
            <h2><%= Translate("/club/description") %></h2>
            <p><%= CurrentClub.Body %></p>
            <h3><%= Translate("/club/goal") %></h3>
            <p><%= CurrentClub.GetProjectGoal() %></p>
            <h3><%= Translate("/club/period") %></h3>
            <p><%= CurrentClub.GetProjectPeriod() %></p>
        </div>

        <div class="section feeds">
            <h2 id="accessible-tab-wall"><%= Translate("/club/projectwall") %></h2>
            <div class="tabbody wall">
                <div class="new-forum-entry-button-wrapper">
                    <asp:Button runat="server" CssClass="add-forum-entry" Text="<%$ Resources: EPiServer, club.createpost %>" />
                </div>
                <Relate:CreateBlogEntry runat="server" ID="ucCreateBlogEntryWall"  />
                <asp:ListView ID="lvProjectWall" ItemPlaceholderID="pnlItemContainer" runat="server">
                    <LayoutTemplate>
                        <ul class="news-list">
                            <asp:Panel ID="pnlItemContainer" runat="server" />
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li>
                            <asp:PlaceHolder runat="server" Visible="<%# ((Entry)Container.DataItem).Author.GetUser() == CurrentClub.Owner %>">
                                <a href="<%= CurrentClub.GetClubUri() %>" id="<%# string.Format("anchorNavBlogEntry{0}",((Entry)Container.DataItem).ID) %>" class="avatar">
                                    <img src="<%= CurrentClub.GetPresentationImageUri(Enums.ImageSize.Small) %>" alt="<%= CurrentClub.Header %>" />
                                    <span class="name"><%= CurrentClub.Header %></span>
                                </a>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder runat="server" Visible="<%# ((Entry)Container.DataItem).Author.GetUser() != CurrentClub.Owner %>">
                                <a class="avatar" href="<%# ((Entry)Container.DataItem).Author.GetMyPageUri() %>"  title="<%# ((Entry)Container.DataItem).Author.GetPresentationName() %>" id="<%# string.Format("anchorNavBlogEntry{0}",((Entry)Container.DataItem).ID) %>" class="avatar">
                                    <img src="<%# ((Entry)Container.DataItem).Author.GetPortraitUri(Enums.ImageSize.Small) %>" alt="<%# ((Entry)Container.DataItem).Author.GetPresentationName() %>"/>
                                    <span class="name"><%# ((Entry)Container.DataItem).Author.GetPresentationName() %></span>
                                </a>
                            </asp:PlaceHolder>
                            
                            <p class="body"><%# ((Entry)Container.DataItem).Header %></p>
                            <p class="body"><%# ((Entry)Container.DataItem).Body %></p>
                            <p class="pubdate"><%# ((Entry)Container.DataItem).Created %></p>
                            <asp:LinkButton runat="server" CssClass="action delete" Visible="<%# HasRemoveAccessRights(((Entry)Container.DataItem)) %>" CommandArgument="<%# ((Entry)Container.DataItem).ID %>" OnClientClick="<%# GetConfirmDelete() %>" OnCommand="lbDeleteEntry_OnClick"><%= Translate("/general/delete") %></asp:LinkButton>
                        </li>
                    </ItemTemplate>       
                </asp:ListView>
                <ht:pager runat="server" ID="newsPager" />
            </div>
            <asp:PlaceHolder runat="server" Visible="False" ID="plhClubForumTab">
                <h2 id="accessible-tab-forum"><%= Translate("/club/projectforum") %></h2>

                                                                                                                                                        <div class="tabbody forum">
                <div class="new-forum-entry-button-wrapper">
                    <asp:Button runat="server" CssClass="add-forum-entry" Text="<%$ Resources: EPiServer, club.createpost %>" />
                </div>
                <Relate:CreateBlogEntry runat="server" ID="ucCreateBlogEntryForum" />
                <asp:ListView ID="lvProjectForum" ItemPlaceholderID="pnlItemContainer" runat="server">
                    <LayoutTemplate>
                        <ul class="project-forum">
                            <asp:Panel ID="pnlItemContainer" runat="server" />
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li>
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="<%# ((Entry)Container.DataItem).Author.GetUser() == CurrentClub.Owner %>">
                                <a class="avatar" href="<%= CurrentClub.GetClubUri() %>" id="<%# string.Format("anchorNavBlogEntry{0}",((Entry)Container.DataItem).ID) %>">
                                    <img src="<%= CurrentClub.GetPresentationImageUri(Enums.ImageSize.Small) %>" alt="<%= CurrentClub.Header %>" />
                                    <span class="name"><%= CurrentClub.Header %></span>
                                </a>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="<%# ((Entry)Container.DataItem).Author.GetUser() != CurrentClub.Owner %>">
                                <a class="avatar" href="<%# ((Entry)Container.DataItem).Author.GetMyPageUri() %>"  title="<%# ((Entry)Container.DataItem).Author.GetPresentationName() %>" id="<%# string.Format("anchorNavBlogEntry{0}",((Entry)Container.DataItem).ID) %>">
                                    <img src="<%# ((Entry)Container.DataItem).Author.GetPortraitUri(Enums.ImageSize.Small) %>" alt="<%# ((Entry)Container.DataItem).Author.GetPresentationName() %>"/>
                                    <span class="name"><%# ((Entry)Container.DataItem).Author.GetPresentationName() %></span>
                                </a>
                            </asp:PlaceHolder>
                            
                            <p class="body"><%# ((Entry)Container.DataItem).Header %></p>
                            <p class="body"><%# ((Entry)Container.DataItem).Body %></p>
                            <p class="pubdate"><%# ((Entry)Container.DataItem).Created %></p>
                            <asp:LinkButton CssClass="action delete" ID="LinkButton1" runat="server" Visible="<%# HasRemoveAccessRights(((Entry)Container.DataItem)) %>" CommandArgument="<%# ((Entry)Container.DataItem).ID %>" OnClientClick="<%# GetConfirmDelete() %>" OnCommand="lbDeleteEntry_OnClick"><%= Translate("/general/delete") %></asp:LinkButton>
                        </li>
                    </ItemTemplate>       
                </asp:ListView>
                <ht:pager runat="server" ID="forumPager" />
            </div>
        </asp:PlaceHolder>
        </div>
    </div>
    <div class="aside related">
        <Relate:ClubMembers runat="server" ID="ucClubMembers" Visible="False" />
        <Relate:ClubBookmarks runat="server" ID="ucClubBookmarks" IsClubBookMarks="True" ShowRemoveButton="True" />
        <div class="section">
            <h2 class="heading"><%= Translate("/general/calendaractivitylist") %></h2>
            <Relate:Calendar runat="server" ID="ucCalendar" PageSize="100" PagePosition="1" />
        </div>
        <asp:LinkButton CssClass="settings-link" ID="btnEditClub" runat="server" OnClick="btnEditClub_OnClick" Text="<%$ Resources: EPiServer, createclub.edit %>" Visible="<%# IsCurrentUserAdminOrOwner(CurrentClub) %>" />
    </div>
    <ht:LeftMenu runat="server" />
    <relate:AddNewClub runat="server" ID="ucAddNewClub" Visible="False" />

    <script type="text/javascript" src="../scripts/lib/jquery.tabs.js"></script>
    <script type="text/javascript">
        var windowHash, container, losen = losen || {};
        losen.showNewEntryForm = function (event) {
            $(this).parent().nextAll('.new-forum-entry').show();
            $(this).hide();
            event.preventDefault();
        };

        $(document).ready(function () {
            losen.accessibleTabs = $('.section.feeds').accessibleTabs({ tabhead: 'h2', fx: 'fadeIn', currentInfo: 'Viser', autoAnchor: true });
            $('.section.feeds').addClass('tabbed');
            $('.section.feeds .tabs-list').wrap($('<div class="tabs-wrapper"/>'));
            windowHash = window.location.hash;
            if (windowHash) {
                if (windowHash === '#forum') {
                    losen.accessibleTabs.showAccessibleTabSelector('#accessible-tab-forum');
                } else if (windowHash === '#wall') {
                    losen.accessibleTabs.showAccessibleTabSelector('#accessible-tab-wall');
                } else {
                    container = $(windowHash).closest('.tabbody');
                    if (container.is('.forum')) {
                        losen.accessibleTabs.showAccessibleTabSelector('#accessible-tab-forum');
                    } else if (container.is('.wall')) {
                        losen.accessibleTabs.showAccessibleTabSelector('#accessible-tab-wall');
                    }
                }
            }
            $('.new-forum-entry').hide();
            $('.section.feeds').delegate('.add-forum-entry', 'click', losen.showNewEntryForm);
        });
    </script>
</asp:Content>
