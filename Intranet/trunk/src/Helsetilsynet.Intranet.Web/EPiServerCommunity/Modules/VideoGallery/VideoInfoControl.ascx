<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.VideoInfoControl" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<!-- script language="javascript" src="Administration.js"></script -->

<script type="text/javascript" src="<% = this.ResolveUrl("swfobject.js") %>"></script>

<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.js") %>"></script>

<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/js/StarSuite.js") %>"></script>

<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<style>
    .table .td
    {
        padding-left: 14px !important;
        padding-right: 14px !important;
    }
</style>

<div id="tabStrip" class="epi-marginVertical-small" style="width: 540px">
    <sc:SaveResultPanel id="saveResultPanel" runat="server" />

    <ComponentArt:TabStrip ID="tabStripApproveVideos" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook"
        DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
        MultiPageId="multiPageApproveVideos" ScrollingEnabled="true" ScrollLeftLookId="ScrollItem" ScrollRightLookId="ScrollItem"
        Width="530" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            <ComponentArt:ItemLook LookId="ScrollItem" CssClass="tabStripScrollItem" HoverCssClass="tabStripScrollItemHover" />
            <ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" Text="Video Information" />
            <ComponentArt:TabStripTab runat="server" Text="Image Samples" />
            <ComponentArt:TabStripTab runat="server" Text="Edit Comments" />
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageApproveVideos" Width="530" CssClass="multiPage" runat="server">
        <ComponentArt:PageView runat="server">
            <table class="epi-default" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3" style="padding: 14px">
                        <div id="flvplayer">
                            <a href="http://www.macromedia.com/go/getflashplayer">Get the Flash Player</a> to see this player.</div>

                        <script type="text/javascript">
	                    var s1 = new SWFObject('<% = this.ResolveUrl("flvplayer.swf") %>','single','488','366','7');
	                    s1.addParam('allowfullscreen','true');
	                    s1.addVariable('file','<% = CurrentVideo.Url %>');
	                    <% if(CurrentVideo.PreviewFrame != null) { %>
	                    s1.addVariable('image','<% = Page.ResolveUrl(EPiServer.Community.ImageGallery.ImageGalleryHandler.Instance.GetThumbnail(CurrentVideo.PreviewFrame, 488, 366, EPiServer.Community.ImageGallery.ThumbnailFormat.Proportional).Url) %>');
	                    <% } %>
	                    s1.addVariable('width','488');
	                    s1.addVariable('height','366');
	                    s1.addVariable('displayheight', '366');
	                    s1.addVariable('backcolor', '0xFFFFFF');
	                    s1.addVariable('overstretch', 'false');
                        s1.write("flvplayer");
                        </script>

                    </td>
                </tr>
                <tr>
                    <td style="border: 0px" colspan="3" style="padding-top: 14px">
                        <asp:Label ID="lblName" runat="server" CssClass="label" Style="font-size: 14pt" />
                    </td>
                </tr>
                <tr>
                    <td style="border: 0px">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.Description")%>
                    </td>
                    <td style="border: 0px" colspan="2">
                        <asp:Label ID="lblDescription" runat="server" CssClass="label" />
                    </td>
                </tr>
                <tr>
                    <td style="border: 0px">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.UploadedBy")%>
                    </td>
                    <td style="border: 0px" colspan="2">
                        <% = GetUploadedByLink() %>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.Uploaded")%>
                    </td>
                    <td style="padding-bottom: 14px">
                        <asp:Label ID="lblUploadedDate" runat="server" CssClass="label" />
                    </td>
                    <td style="padding-bottom: 14px" align="right">
                        <button onclick="window.open('<% = CurrentVideo.Url %>', '_blank'); return false;" class="button">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.ContestInfo.buttonDownloadSubmission")%></button>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="padding-top: 14px; padding-bottom: 14px">
                        <strong>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.SetStatusAs")%></strong>
                    </td>
                    <td style="padding-top: 14px; padding-bottom: 14px" colspan="2">
                        <asp:RadioButtonList ID="rblPublishStatus" runat="server" CssClass="input">
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 14px; padding-bottom: 14px">
                        <strong>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.RemoveVideo")%></strong>
                    </td>
                    <td style="padding-top: 14px; padding-bottom: 14px" colspan="2">
                        <asp:CheckBox ID="cbRemove" runat="server" /><td>
                </tr>
                <tr>
                    <td colspan="3" align="right" style="padding: 14px">
                        <asp:Button ID="btnSave" runat="server" CssClass="button" OnClick="btnSave_click" /><td>
                </tr>
            </table>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server">
            <asp:Repeater ID="rptImages" runat="server">
                <ItemTemplate>
                    <img src="<%# Page.ResolveUrl(EPiServer.Community.ImageGallery.ImageGalleryHandler.Instance.GetThumbnail((EPiServer.Community.ImageGallery.Image)Container.DataItem, 170, 127, EPiServer.Community.ImageGallery.ThumbnailFormat.ReduceAndCrop).Url) %>"
                        border="0" />
                </ItemTemplate>
            </asp:Repeater>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server">
            <input type="hidden" id="hiddenVideoId" runat="server" />
            <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
                <tr>
                    <td class="menu">
                        <div class="section top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.Comments.MenuHeader") %></div>
                        <asp:Panel ID="panelVideoMenu" runat="server">
                            <%--<button id="buttonAddComment" class="button" onclick="<% = CreateCommentJS %>">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.buttonAddComment") %>
                            </button>--%>
                            <asp:Button ID="buttonRemoveSelectedEntries" runat="server" CssClass="button" />
                        </asp:Panel>
                    </td>
                    <td valign="top">
                        <asp:PlaceHolder ID="placeHolderVideoComments" runat="server">
                            <div id="blog">
                                <sc:PagingControl ID="pagingControlTop" runat="server" />
                                <asp:Repeater ID="repeaterVideoComments" runat="server">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <input type="hidden" id="hiddenVideoCommentId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                        <div class="entry">
                                            <div class="date">
                                                <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></div>
                                            <br />
                                            <div class="title">
                                                <asp:CheckBox ID="checkBoxSelected" runat="server" /><a href="#" onclick="<%# EditCommentJS((EPiServer.Community.VideoGallery.VideoComment)Container.DataItem) %>"><%# GetHeaderText(Container) %></a></div>
                                            <br />
                                            <div class="content">
                                                <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Body")) %></div>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <sc:PagingControl ID="pagingControlBottom" runat="server" />
                            </div>
                        </asp:PlaceHolder>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
</div>
<asp:PlaceHolder ID="placeHolderCloseWindow" runat="server" Visible="False">

    <script language="javascript">
        setTimeout('CloseWindow()', 1000);

        function CloseWindow() {
            var refreshControlId = '<% = RefreshButtonId %>';
            if (window.opener && window.opener.document.getElementById(refreshControlId))
                RefreshOpenerList(window.opener.document.getElementById(refreshControlId));
            window.close();
        }

        function RefreshOpenerList(refreshControl) {
            if (navigator.appName.indexOf('Microsoft') > -1)
                refreshControl.click();
            else {
                var evObj = document.createEvent('MouseEvents');
                evObj.initEvent('click', true, true);
                refreshControl.dispatchEvent(evObj);
            }

        }
    </script>

</asp:PlaceHolder>
<sc:NoEntityError runat="server" ID="NoEntityError" />