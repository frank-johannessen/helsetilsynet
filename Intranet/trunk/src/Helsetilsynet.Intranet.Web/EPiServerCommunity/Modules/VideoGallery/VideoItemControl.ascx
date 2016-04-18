<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoItemControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.VideoItemControl" %>
<script language="javascript">
    Sys.Application.add_load(<% = this.ClientID %>_StartFrames);
    
    function <% = this.ClientID %>_StartFrames()
    {
        var frames = document.getElementById('<% = hdnFrames.ClientID %>');
        if(frames && frames.value)
        {    
            <% = this.ClientID %>_setFrame(frames.value, document.getElementById('<% = imgPreviewFrame.ClientID %>'));
            var videos = document.getElementById('<% = Parent.Parent.Parent.FindControl("dlVideos").ClientID %>');
            var standard = document.getElementById('<% = videoItemStandard.ClientID %>');
            var zoomed = document.getElementById('<% = videoItemZoomed.ClientID %>');

            var zoomedPos = (standard.offsetLeft + zoomed.offsetLeft + zoomed.clientWidth);
            if(videos.clientWidth < zoomedPos)
                zoomed.style.left = -(zoomed.clientWidth - standard.clientWidth) - 1; // margin is 1
        }
    }

    var <% = this.ClientID %>_currentFrame = 0;
    function <% = this.ClientID %>_setFrame(frameStr, img)
    {
        if(!img || !frameStr)
            return;
        var frames = frameStr.split(',');
        if(<% = this.ClientID %>_currentFrame == frames.length)
            <% = this.ClientID %>_currentFrame = 0;
        
        img.src = frames[<% = this.ClientID %>_currentFrame];
        <% = this.ClientID %>_currentFrame++;
        setTimeout("<% = this.ClientID %>_setFrame('" + frameStr + "', document.getElementById('" + img.id + "'));", 800);
    }
</script>
<asp:UpdatePanel ID="updVideoItem" runat="server">
    <ContentTemplate>
        <asp:Panel style="position: relative; float: left;" runat="server" id="videoItemStandard">
            <asp:DataList ID="dlFrames" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" CellPadding="0" CellSpacing="0" ItemStyle-Width="<%# FrameSize.Width + 1 %>" ItemStyle-Height="<%# FrameSize.Height + 1 %>">
                <ItemTemplate><asp:Image ID="Image1" runat="server" ImageUrl="<%# EPiServer.Community.ImageGallery.ImageGalleryHandler.Instance.GetThumbnail((EPiServer.Community.ImageGallery.Image)Container.DataItem, FrameSize.Width, FrameSize.Height, EPiServer.Community.ImageGallery.ThumbnailFormat.ReduceAndCrop).Url %>" Width="<%# FrameSize.Width %>" Height="<%# FrameSize.Height %>" /></ItemTemplate>
            </asp:DataList>
            <asp:Panel id="preview" runat="server" style="visibility:hidden; width: 100%; height: 100%; left: 0px; top: 0px; position:absolute; background-color: #333333; z-index: 20; -moz-opacity:0.8;-khtml-opacity: 0.8;opacity: 0.8; color: White;">
                <div style="padding: 5px;">
                    <asp:CheckBox ID="chbRemoveVideo" runat="server" /><strong><asp:Label ID="labelRemoveVideo" runat="server" /></strong><br />
                    <br />
                    <strong><asp:Label ID="labelSetStatus" runat="server" /></strong><br />
                    <asp:RadioButtonList ID="rblPublishState" runat="server" CssClass="input" ForeColor="white" Font-Bold="true">
                    </asp:RadioButtonList>
                    <div style="position: absolute; bottom: 5px; right: 5px;"><asp:LinkButton ID="lbZoomIn" runat="server" OnClick="lbZoomIn_Click" style="text-decoration: none; background: url(../EPiServerCommunity/Modules/videogallery/images/zoom.png) 0 -3px no-repeat; padding-left: 25px;"><asp:Label ID="labelZoomIn" runat="server" ForeColor="white" /></asp:LinkButton></div>
                </div>
            </asp:Panel>
            <asp:Panel runat="server" id="videoItemZoomed" CssClass="videoItemZoomed" visible="false" style="left: 0px; top: 0px; position:absolute; width: 390px; height: 165px; background-color: #333333; z-index: 21; margin-right: 1px; padding: 5px; color: White; overflow: hidden;">
                <asp:HiddenField id="hdnFrames" runat="server" />
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td>
                            <a href="javascript:<% = EPiServer.Community.Web.Administration.AdministrationModule.GetAdminPageReference(CurrentVideo, EPiServer.Community.Web.Administration.OpenTarget.Popup, EPiServer.Community.Web.Administration.AdminMode.Update, "refreshButtonId=" + RefreshButtonClientID) %>; void(0);"><asp:Image ID="imgPreviewFrame" runat="server" Width="200" Height="145" /></a>
                        </td>
                        <td align="right" class="epi-alignTop">
                            <asp:LinkButton ID="lbZoomOut" runat="server" OnClick="lbZoomOut_Click"><img src="../EPiServerCommunity/Modules/videogallery/images/close.png" border="0" alt="close" /></asp:LinkButton><br />
                            <a href="javascript:<% = EPiServer.Community.Web.Administration.AdministrationModule.GetAdminPageReference(CurrentVideo, EPiServer.Community.Web.Administration.OpenTarget.Popup, EPiServer.Community.Web.Administration.AdminMode.Update, "refreshButtonId=" + RefreshButtonClientID) %>; void(0);" style="text-decoration: none;"><asp:Label CssClass="label" ID="labelViewVideo" runat="server" ForeColor="white" /></a>

                            <asp:CheckBox ID="chbRemoveVideoZoom" runat="server" OnCheckedChanged="chbRemoveVideoZoom_CheckedChanged" AutoPostBack="true" /><strong><asp:Label ID="labelRemoveVideoZoom" runat="server" CssClass="label" ForeColor="white" /></strong><br />
                            <br />
                            <strong><asp:Label ID="labelSetStatusZoom" runat="server" CssClass="label" ForeColor="white" /></strong><br />
                            <asp:RadioButtonList ID="rblPublishStateZoom" runat="server" CssClass="input" ForeColor="white" Font-Bold="true" OnSelectedIndexChanged="rblPublishStateZoom_SelectedIndexChanged" AutoPostBack="true">
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
