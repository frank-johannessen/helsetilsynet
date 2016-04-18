<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="ImageGalleryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ImageGalleryControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript">
	function <% = this.ClientID %>_MarkPublishState(val)
	{
		var i;
		for (i = 0; i < document.forms[0].elements.length; i++) {
			var elem = document.forms[0].elements[i];
			if (elem.name != null && elem.name.indexOf("<% = this.UniqueID %>") >= 0 && elem.name.indexOf("radioButtonListImagePublishState") >= 0)
			{
				if (elem.value == val)
					elem.checked = true;
			}
		}
	}
	
	function <% = this.ClientID %>_GetPublishStateValue()
	{
		var rdoList = document.getElementById('<% = radioButtonListPublishState.ClientID %>');
		var e;
		for(e = 0; e < rdoList.childNodes.length; e++)
		{
			if(rdoList.childNodes[e].checked)
				return rdoList.childNodes[e].value;
		}
		
		return null;
	}
</script>

<asp:Panel ID="panelMain" runat="server">
    <input type="hidden" id="hiddenImageGalleryId" runat="server" />
    <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
        <tr>        
            <th>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.MenuHeader") %>
            </th>
            <th>&nbsp;</th>
        </tr>
        <tr>
            <td class="menu">
        
                <button <% = (!AccessRights.Administrate ? "disabled" : "") %> onclick="SCImageGalleryOpenUploadWindow('<% = ImageGallery.ID %>', '<% = this.UniqueID %>');return false;" class="button">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.buttonUpload") %></button>
                <asp:Button ID="buttonRemoveSelected" runat="server" CssClass="button" />
                <div class="section">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.AccessHeader") %></div>
                <asp:Button ID="buttonSave" runat="server" CssClass="button" />
                <button <% = (!AccessRights.Administrate ? "disabled" : "") %> onclick="<% = this.ClientID %>_MarkPublishState(<% = this.ClientID %>_GetPublishStateValue());return false;" class="button">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.buttonMarkAll") %></button><br />
                <asp:RadioButtonList ID="radioButtonListPublishState" CssClass="input" runat="server" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow" CellPadding="0" CellSpacing="0">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:RadioButtonList>
                <div class="section">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.SubGalleries") %></div>
                <asp:LinkButton ID="linkButtonParentGallery" runat="server" OnCommand="LinkButtonSubGallery_Command" Visible="False" CssClass="input"></asp:LinkButton>
                <asp:Repeater ID="repeaterSubGalleries" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="linkButtonSubGallery" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="LinkButtonSubGallery_Command" CssClass="input"><img src="images/folder_small.gif" border="0" />&nbsp;<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></asp:LinkButton><br />
                    </ItemTemplate>
                </asp:Repeater>
            </td>
            <td valign="top">
                <asp:PlaceHolder ID="placeHolderDirectEdit" runat="server" Visible="false">
                    <table width="100%">
                        <tr>
                            <td class="label">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.imageGalleryName") %>:<br />
                                <asp:TextBox ID="textBoxImageGalleryName" runat="server" CssClass="input" Width="300" />
                            </td>
                            <td class="label" align="right">
                                <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.RemoveImageGallery.confirm") %>');">
                                    <asp:Button ID="buttonRemove" runat="server" CssClass="button" OnCommand="ButtonRemoveImageGallery_Command" /></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" colspan="2">
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageGallery.imageGalleryDescription") %>:<br />
                                <asp:TextBox ID="textBoxImageGalleryDescription" TextMode="MultiLine" runat="server" CssClass="input" Width="300" Height="50" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr size="1" noshade />
                            </td>
                        </tr>
                    </table>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="placeHolderImageGallery" runat="server">
                    <div id="imageGallery">
                        <sc:PagingControl ID="pagingControlTop" runat="server" />
                        <asp:DataList ID="dataListImages" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <input type="hidden" id="hiddenImageId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                <div class="image">
                                    <asp:CheckBox ID="checkBoxSelected" runat="server" CssClass="imageSelector" />
                                    <img src="<%# this.ResolveUrl(EPiServer.Community.ImageGallery.ImageGalleryHandler.Instance.GetThumbnail((EPiServer.Community.ImageGallery.Image)Container.DataItem, 100, 100, EPiServer.Community.ImageGallery.ThumbnailFormat.ReduceAndCrop, true).Url) %>" border="0" title="<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %>" onclick="SCImageGalleryOpenImageInfoWindow(<%# DataBinder.Eval(Container.DataItem, "ID") %>)" /><br />
                                </div>
                                <asp:RadioButtonList ID="radioButtonListImagePublishState" CssClass="input" runat="server" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:RadioButtonList>
                            </ItemTemplate>
                        </asp:DataList>
                        <sc:PagingControl ID="pagingControlBottom" runat="server" />
                    </div>
                </asp:PlaceHolder>
            </td>
        </tr>
    </table>
</asp:Panel>
