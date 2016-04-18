<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.VideoListControl" %>
<%@ Register TagPrefix="sc" TagName="VideoItem" Src="VideoItemControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript">
	//Sys.Application.add_load(<% = this.ClientID %>_ResizeDocument);
	//EPiServerCommonAddResizeEvent(<% = this.ClientID %>_ResizeDocument);
	
	function <% = this.ClientID %>_MarkPublishState(val)
	{
		var i;
		for (i = 0; i < document.forms[0].elements.length; i++) {
			var elem = document.forms[0].elements[i];
			if (elem.name != null && elem.name.indexOf("<% = this.UniqueID %>") >= 0 && elem.name.indexOf("rblPublishState") >= 0)
			{
				if (elem.value == val)
					elem.checked = true;
			}
		}
	}
	
	function <% = this.ClientID %>_MarkRemove(val)
	{
		var i;
		for (i = 0; i < document.forms[0].elements.length; i++) {
			var elem = document.forms[0].elements[i];
			if (elem.name != null && elem.name.indexOf("<% = this.UniqueID %>") >= 0 && elem.name.indexOf("chbRemoveVideo") >= 0)
			{
                elem.checked = val;
			}
		}
	}
	/*
    function <% = this.ClientID %>_ResizeDocument() {
		var myWidth = 0, myHeight = 0;
		if( typeof( window.innerWidth ) == 'number' ) {
			//Non-IE
			myWidth = window.innerWidth;
			myHeight = window.innerHeight;
		} else if( document.documentElement &&
			( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
			//IE 6+ in 'standards compliant mode'
			myWidth = document.documentElement.clientWidth;
			myHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
			//IE 4 compatible
			myWidth = document.body.clientWidth;
			myHeight = document.body.clientHeight;
		}

        if(document.getElementById('<% = this.ClientID %>_videoGallery'))
		    document.getElementById('<% = this.ClientID %>_videoGallery').style.height = (myHeight - 150) + 'px';
	}*/
</script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <tr>
        <th>
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoList.MenuHeader") %>
        </th>
        <th>
        <asp:UpdatePanel ID="updNumVideos" runat="server">
            <ContentTemplate>
                <asp:Literal ID="litNumVideos" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>

        </th>
    </tr>
    <tr>
        <td class="menu">
            <button class="button" runat="server" id="btnUpload" visible="false">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoList.buttonUpload")%></button>
            <asp:Button ID="buttonDeleteSelectedPermanently" CssClass="button" runat="server" OnClick="buttonDeleteSelectedPermanently_Click" />
            <div class="section">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.VideoList.AccessHeader")%></div>
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoList.SetAllAs") %>:<br />
            <input type="radio" name="Status" value="Approved" onclick="<% = this.ClientID %>_MarkPublishState(this.value)"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.rblStatus_Approved")%></input><br />
            <input type="radio" name="Status" value="Pending" onclick="<% = this.ClientID %>_MarkPublishState(this.value)"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.rblStatus_Pending")%></input><br />
            <input type="radio" name="Status" value="Removed" onclick="<% = this.ClientID %>_MarkPublishState(this.value)"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoInfo.rblStatus_Removed")%></input><br />
            <asp:Button ID="buttonSave" runat="server" CssClass="button" OnClick="buttonSave_Click" />
            <hr />
            <input type="hidden" id="hdnScale" runat="server" />
            <input type="hidden" id="hdnSeparatorSize" runat="server" />
            <asp:ImageButton ID="imbScaleUp" runat="server" ImageUrl="images/big_view.png" />
            <asp:ImageButton ID="imbScaleDown" runat="server" ImageUrl="images/small_view.png" />
            <br />
            <asp:Button ID="buttonReload" runat="server" CssClass="button" OnClick="buttonReload_Click" />
        </td>
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                <tr>
                    <td valign="top">
                        <asp:UpdateProgress ID="updVideosProgress" runat="server">
                            <ProgressTemplate>
                                &nbsp;<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.VideoGallery.VideoList.ProgressTemplateText") %></ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:UpdatePanel ID="updVideos" runat="server">
                            <ContentTemplate>
                                <div id="<% = this.ClientID %>_videoGallery" style="position: relative; float: left; margin-left: -<% = SeparatorSize %>px; width: 100%; overflow: auto;">
                                    <asp:DataList ID="dlVideos" runat="server" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0" OnItemDataBound="dlVideos_ItemDataBound" OnItemCreated="dlVideos_ItemCreated" RepeatLayout="Flow" Style="float: left; width: 100%;">
                                        <ItemTemplate>
                                            <div style="float: left; margin-left: <% = SeparatorSize %>px; margin-bottom: <% = SeparatorSize %>px">
                                                <sc:VideoItem ID="videoItem" runat="server" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList><br />
                                    <br />
                                </div>
                                <br />
                                <div style="margin-top: 10px; float: right; clear: both;">
                                    <sc:PagingControl ID="pagingControl" runat="server" OnPageCommand="PagingControl_PageCommand" />
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="buttonSave" />
                                <asp:AsyncPostBackTrigger ControlID="buttonReload" />
                                <asp:AsyncPostBackTrigger ControlID="imbScaleUp" />
                                <asp:AsyncPostBackTrigger ControlID="imbScaleDown" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
