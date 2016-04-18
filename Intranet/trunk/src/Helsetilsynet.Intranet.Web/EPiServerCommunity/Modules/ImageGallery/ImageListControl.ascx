<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="ImageListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ImageListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
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

<input type="hidden" id="hiddenImageGalleryId" runat="server" name="hiddenImageGalleryId" />
<table border="0" cellpadding="0" cellspacing="0" class="epi-default epi-noMargin">
   <tr>
        <th>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageList.MenuHeader") %>
        </th>
        <th colspan="6">
                <asp:Literal ID="literalGalleryName" runat="server" />
        </th>


    </tr>
    <tr>
       <td class="menu">
            <div>
                <asp:Button ID="buttonRemoveSelected" runat="server" CssClass="button" />
                <div class="section">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageList.AccessHeader") %></div>
                <asp:Button ID="buttonSave" runat="server" CssClass="button" />
                <button onclick="<% = this.ClientID %>_MarkPublishState(<% = this.ClientID %>_GetPublishStateValue());return false;" class="button">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageList.buttonMarkAll") %></button><br />
                <asp:RadioButtonList ID="radioButtonListPublishState" runat="server" CssClass="input" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow" CellPadding="0" CellSpacing="0">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </td>
        <td valign="top">
            <asp:PlaceHolder ID="placeHolderImageGallery" runat="server">
                <div id="imageGallery">
                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                    <asp:DataList ID="dataListImages" runat="server" RepeatDirection="Horizontal" RepeatColumns="6">
                        <ItemTemplate>
                            <input type="hidden" id="hiddenImageId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hiddenImageId" />
                            <div class="image">
                                <asp:CheckBox ID="checkBoxSelected" runat="server" CssClass="imageSelector" />
                                <img src="<%# GetThumbnailUrl((EPiServer.Community.ImageGallery.Image)Container.DataItem) %>" border="0" title="<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Body")) %>" onclick="SCImageGalleryOpenImageInfoWindow(<%# DataBinder.Eval(Container.DataItem, "ID") %>)" /><br />
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
