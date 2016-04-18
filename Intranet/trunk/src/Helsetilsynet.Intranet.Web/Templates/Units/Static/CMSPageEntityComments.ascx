<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMSPageEntityComments.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.CMSPageEntityComments" %>
<%@ Register TagPrefix="ht" TagName="pager" Src="~/Templates/Units/Placeable/ResultPager.ascx" %>
<%@ Import Namespace="EPiServer.Common.Comments" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>
<div class="section comments">
    <h2>Kommentarer</h2>
    <asp:Panel ID="pnlSendComment" runat="server" DefaultButton="btnSendComment">
        <p>Har du kommentarer til denne artikkelen? Skriv dem inn her...</p>
        <div class="new-comment">
            <asp:TextBox ID="txtCommentContent" TextMode="MultiLine" runat="server" CssClass="commentTextBox" />
            <asp:Button ID="btnSendComment" runat="server" Text="<%$ Resources: EPiServer, general.add %>" OnClick="btnSendComment_Click" ValidationGroup="commentGroup" CssClass="red buttonSmall" />
        </div>
    </asp:Panel>
    <asp:ListView ID="lvEntries" runat="server" ItemPlaceholderID="pnlItemContainer">
        <LayoutTemplate>
            <ul class="comments-list">
                <asp:Panel ID="pnlItemContainer" runat="server" />
            </ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li class="comment">
                <div class="avatar">
                    <a href="<%# ((IComment)Container.DataItem).Author.GetMyPageUri() %>" id="<%# string.Format("anchorNavComment{0}",((IComment)Container.DataItem).ID) %>" >
                        <img src="<%# ((IComment)Container.DataItem).Author.GetPortraitUri(Enums.ImageSize.Small).ToString() %>" height="50" width="50" alt="<%# ((IComment)Container.DataItem).Author.GetPresentationName(100, true) %>" />
                    </a>
                </div>
                <div class="comment-text">
                    <p class="meta">
                        <asp:HyperLink CssClass="author" runat="server" NavigateUrl="<%# ((IComment)Container.DataItem).Author.GetMyPageUri() %>" Text="<%# ((IComment)Container.DataItem).Author.GetPresentationName() %>"></asp:HyperLink>
                        <span class="date pubdate"><%# ((IComment)Container.DataItem).Created.Date.ToString("dd.MM.yyyy") %></span>
                    </p>
                    <p class="comment-body"><%# ((IComment)Container.DataItem).Body %></p>
                </div>
                <div class="actions">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnCommand="lbDelete_Command" OnClientClick="<%# GetConfirmDelete() %>" CommandArgument="<%# ((IComment)Container.DataItem).ID %>" Text="<%$ Resources: EPiServer, general.delete %>" Visible="<%# HasRemoveAccessRights((IComment)Container.DataItem)%>" CausesValidation="false" CssClass="delete" />
                </div>
            </li>
        </ItemTemplate>
    </asp:ListView>
    <ht:pager runat="server" ID="pager" />
</div>
