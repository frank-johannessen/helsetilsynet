<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CalmeyersCorner.ascx.cs"
    Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.CalmeyersCorner" %>
<%@ Import Namespace="EPiServer.Community.Blog" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>
<div class="section club-news">
    <h2 class="heading">
        <a href="<%= CalmeyersCornerClub.GetClubUri() %>" title="<%= CalmeyersCornerClub.Header %>">
            <%= CalmeyersCornerClub.Header %></a></h2>
    <asp:ListView ID="lvNews" ItemPlaceholderID="pnlItemContainer" runat="server">
        <LayoutTemplate>
            <ul>
                <asp:Panel ID="pnlItemContainer" runat="server" />
            </ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li class="article">
                <div class="content">
                    <asp:PlaceHolder runat="server" Visible="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetUser() == CalmeyersCornerClub.Owner %>">
                        <a href="<%= CalmeyersCornerClub.GetClubUri() %>">
                            <img src="<%= CalmeyersCornerClub.GetPresentationImageUri(Enums.ImageSize.Small) %>"
                                alt="<%= CalmeyersCornerClub.Header %>" />
                        </a><a class="article-source" href="<%= CalmeyersCornerClub.GetClubUri() %>">
                            <%= CalmeyersCornerClub.Header %>
                        </a></asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" Visible="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetUser() != CalmeyersCornerClub.Owner %>">
                        <a href="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetMyPageUri() %>" title="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetPresentationName() %>">
                            <img src="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetPortraitUri(Enums.ImageSize.Small) %>"
                                alt="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetPresentationName() %>" />
                        </a><a class="article-source" href="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetMyPageUri() %>"
                            title="<%# ((CalmayerCornerItem)Container.DataItem).Author.GetPresentationName() %>">
                            <%# ((CalmayerCornerItem)Container.DataItem).Author.GetPresentationName()%>
                        </a></asp:PlaceHolder>
                    <h5 class="title">
                        <a href="<%# ((CalmayerCornerItem)Container.DataItem).Link %>">
                            <%# ((CalmayerCornerItem)Container.DataItem).Header %></a></h5>
                    <%--<p><%# ((CalmayerCornerItem)Container.DataItem).Body.Crop(200) %></p>--%>
                    <p>
                        <%# ((CalmayerCornerItem)Container.DataItem).Body %></p>
                        </div>
            </li>
        </ItemTemplate>
        <EmptyDataTemplate>
        </EmptyDataTemplate>
    </asp:ListView>
</div>
