<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyBookmarks.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MyBookmarks" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.BookmarkFramework" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:Panel runat="server" ID="plhInternalBookmarks2" CssClass="section my-links">
    <asp:PlaceHolder ID="plhInternalLinksHelp" runat="server" Visible="False">
        <div class="help">
            <span class="icon">i</span>
            <p class="help-popup"><%= Translate("/myTools/internalLinksHelpText")%></p>
        </div>
    </asp:PlaceHolder>
    
    <h2 class="heading"><%= Translate("/usercontrolheadings/myinternallinks") %></h2>
    <asp:ListView ID="lvBookmarks" ItemPlaceholderID="pnlItemContainer" runat="server"  >
        <LayoutTemplate>
            <ul>
                <asp:Panel ID="pnlItemContainer" runat="server" />
            </ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li>
                <asp:LinkButton 
                            ID="lbRemoveBookmark" 
                            CommandArgument="<%# ((BookmarkLink)Container.DataItem).UniqueID %>" 
                            OnCommand="lbRemoveBookmark_Command" 
                            OnClientClick="<%# GetConfirmDelete() %>"
                            runat="server" Visible="<%# ShowRemoveBtn() %>" CssClass="delete"><%= Translate("/general/remove")%></asp:LinkButton>
                <a href="<%# ((BookmarkLink)Container.DataItem).Link.Href %>" target="<%# ((BookmarkLink)Container.DataItem).Link.Target %>"><%# ((BookmarkLink)Container.DataItem).Link.Title %></a> 
            </li>
        </ItemTemplate>   
    </asp:ListView>
</asp:Panel>
<asp:Panel runat="server" CssClass="section my-links external" ID="pnlExternalLinksAndAddLink">
    <asp:PlaceHolder ID="plhExternalLinksHelp" runat="server" Visible="False">
        <div class="help">
            <span class="icon">i</span>
            <p class="help-popup"><%= Translate("/myTools/externalLinksHelpText")%></p>
        </div>
    </asp:PlaceHolder>    
    <h2 class="heading"><%= !IsClubBookMarks ? Translate("/usercontrolheadings/myexternallinks") : Translate("/usercontrolheadings/documentsandlinks")%></h2>
    <asp:PlaceHolder runat="server" ID="plhExternalLinks">
        <asp:ListView ID="lvExternalBookmarks" ItemPlaceholderID="pnlItemContainer" runat="server">
            <LayoutTemplate>
                <ul>
                    <asp:Panel ID="pnlItemContainer" runat="server" />
                </ul>
            </LayoutTemplate>
            <ItemTemplate>
                <li>
                    <asp:LinkButton 
                                ID="lbRemoveBookmark" 
                                CommandArgument="<%# ((BookmarkLink)Container.DataItem).UniqueID %>" 
                                OnCommand="lbRemoveBookmark_Command"
                                OnClientClick="<%# GetConfirmDelete() %>" 
                                runat="server" Visible="<%# ShowRemoveBtn() %>" CssClass="delete"><%= Translate("/general/remove")%></asp:LinkButton>
                    <a href="<%# ((BookmarkLink)Container.DataItem).Link.Href %>" target="<%# ((BookmarkLink)Container.DataItem).Link.Target %>"><%# ((BookmarkLink)Container.DataItem).Link.Title %></a> 
                </li>
            </ItemTemplate>
            <%--<EmptyDataTemplate >
                <p><a href="<%= CurrentUser.GetMyPageUri().ToString() %>" title="<%= CurrentUser.GetPresentationName() %>"><%= Translate("/bookmarks/addlinksonmypage")%></a></p>
            </EmptyDataTemplate> --%>      
        </asp:ListView>
    </asp:PlaceHolder>
    <asp:Panel runat="server" ID="pnlAddLinkSection">
        <fieldset class="add-external-link">
            <legend><%= Translate("/general/addnewexternallink") %></legend>
            <asp:Label runat="server" AssociatedControlID="tbNewLinkName"><%= Translate("/general/linkname") %></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="newBookmark" ControlToValidate="tbNewLinkName" />
            <asp:TextBox runat="server" ID="tbNewLinkName" ValidationGroup="newBookmark" />
            
            <asp:Label runat="server" AssociatedControlID="tbNewLinkUrl"><%= Translate("/general/linkurl") %></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ValidationGroup="newBookmark" ControlToValidate="tbNewLinkUrl" />
            <asp:TextBox runat="server" ID="tbNewLinkUrl" ValidationGroup="newBookmark" />
            <div class="actions">
                <a class="cancel"><%= Translate("/general/cancel") %></a>
                <asp:Button ID="Button1" runat="server" OnClick="btnAddBookmark_Clicked" ValidationGroup="newBookmark" Text="<%$ Resources: EPiServer, general.add %>" />
            </div>
        </fieldset>
        <script type="text/javascript">
            $(document).ready(function () {
                $('fieldset.add-external-link').bind('click', function (event) {
                    $(this).addClass('active');
                });
                $('fieldset.add-external-link .cancel').bind('click', function (event) {
                    $(this).closest('fieldset.add-external-link.active').removeClass('active');
                    return false;
                });
            });
        </script>
    </asp:Panel>
</asp:Panel>
