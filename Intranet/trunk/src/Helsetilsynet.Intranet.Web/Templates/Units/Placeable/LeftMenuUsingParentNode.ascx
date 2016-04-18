<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuUsingParentNode.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.LeftMenuUsingParentNode" %>
<%@ Register tagPrefix="ht" tagName="archiveButton" src="~/Templates/Units/Placeable/ArticleArciveButton.ascx" %>
<%@ Import Namespace="EPiServer.Core" %>

<!--googleoff: index-->
<!--googleoff: snippet-->
<asp:PlaceHolder runat="server" ID="plhLeftMenu">
<div class="aside nav">
    <h2 class="heading"><span><%= GetHeader(GetNodeToListPagesFrom()) %></span></h2>
        <asp:PlaceHolder ID="plhExtraNodeForLvlTwo" runat="server">
            <ul class="sub-lvl-two-menu"><li class="mw-active-menu-with-sub-nav"><a href="" class="sub-lvl-two-placeholder"></a></li></ul>
        </asp:PlaceHolder>
    <EPiServer:PageList ID="plPages" runat="server" EnableVisibleInMenu="True" >
        <HeaderTemplate>
            <ul> 
        </HeaderTemplate>
        <ItemTemplate>
            <li class="<%# ((PageData)Container.DataItem).PageLink == CurrentPage.PageLink ? "mw-active-menu-with-sub-nav" : string.Empty %> <%# SetActiveOrNot((PageData)Container.DataItem) ? "active" : String.Empty %>">
                <EPiServer:Property runat="server" PropertyName="PageLink"/>
                <asp:PlaceHolder runat="server" Visible="<%# ((PageData)Container.DataItem).PageLink.ID == CurrentPage.PageLink.ID || ((PageData)Container.DataItem).PageLink == CurrentPage.ParentLink || CurrentPage.IsDescendantOf((PageData)Container.DataItem) %>">
                    <EPiServer:PageList runat="server" EnableVisibleInMenu="True" PageLink="<%# ((PageData)Container.DataItem).PageLink %>">
                        <HeaderTemplate><ul class="sub-article-menu"></HeaderTemplate>
                        <ItemTemplate><li <%# SetActiveOrNot((PageData)Container.DataItem) ? "class='active'" : String.Empty %>><EPiServer:Property runat="server" PropertyName="PageLink"/></li></ItemTemplate>
                        <FooterTemplate></ul></FooterTemplate>
                    </EPiServer:PageList>
                </asp:PlaceHolder>
            </li>
        </ItemTemplate> 
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </EPiServer:PageList>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $(".mw-active-menu-with-sub-nav").appendAnchorNavigation({ appendedUlClass: 'appended' });
    });

    (function ($) {
        $.fn.appendAnchorNavigation = function (options) {
            var settings, anchors, generatedMenu, idName;
            settings = {
                anchorSelector: '.article-body .show-in-menu',
                appendedUlClass: 'appendedSubNavigation'
            };
            if (options) {
                $.extend(settings, options);
            }
            anchors = $(settings.anchorSelector);
            if (anchors.length > 0) {
                generatedMenu = $('<ul />');
                generatedMenu.addClass(settings.appendedUlClass);
                anchors.each(function () {
                    idName = $(this).text().replace(/ /g, '');
                    if(idName.length > 0) {
                        while ($('#' + idName).length > 0) {
                            idName = idName + "1";
                        }
                        $(this).attr("id", idName);
                        generatedMenu.append('<li><a href="#' + $(this).attr("id") + '">' + $(this).text() + '</a></li>');
                    }
                });
                $(this).children().first().after(generatedMenu);
            }
            else {
                $(".sub-lvl-two-menu").remove();
            }
            $(".sub-lvl-two-placeholder").remove();
        };
    })(jQuery);	
</script>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="plhArchiveButton">
    <div class="aside nav">
        <h2 class="heading"><span>Interninfoarkiv</span></h2>
        <ul><li><ht:archiveButton ID="ArchiveButton1" runat="server" /></li></ul>
    </div>
</asp:PlaceHolder>
<!--googleon: snippet-->
<!--googleon: index-->