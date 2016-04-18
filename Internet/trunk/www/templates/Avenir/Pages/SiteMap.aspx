<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" AutoEventWireup="false" Codebehind="SiteMap.aspx.cs" Inherits="Avenir.Templates.Pages.SiteMap" %>
<%@ Register TagPrefix="ht" TagName="MainBody" Src="~/Templates/Avenir/Units/Placeable/MainBody.ascx" %>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<asp:Content ContentPlaceHolderID="CenterArea" runat="server">

	<div id="MainBody">
	    <ht:MainBody runat="server" />
	    <EPiServer:PageTree runat="server" NumberOfLevels="2" ExpandAll="true" id="Topp" PageLink="<%# IndexTop %>">
			<HeaderTemplate>
				<div id="SiteMap"><ul><li>Toppmeny
			</HeaderTemplate>
			<IndentTemplate>
				<ul>
			</IndentTemplate>
			<ItemHeaderTemplate>
				<li>
			</ItemHeaderTemplate>
			<ItemTemplate>
				<EPiServer:Property ID="Property1" PropertyName="PageLink" runat="server" />
			</ItemTemplate>
			<ItemFooterTemplate>
				</li>
			</ItemFooterTemplate>
			<UnindentTemplate>
				</ul>
			</UnindentTemplate>
			<FooterTemplate>
				</li></ul></div>
			</FooterTemplate>
		</EPiServer:PageTree>

	    <EPiServer:PageTree runat="server" NumberOfLevels="3" ExpandAll="true" id="SiteMapTree" PageLink="<%# IndexRoot %>">
			<HeaderTemplate>
				<div id="SiteMap">
			</HeaderTemplate>
			<IndentTemplate>
				<ul>
			</IndentTemplate>
			<ItemHeaderTemplate>
				<li>
			</ItemHeaderTemplate>
			<ItemTemplate>
				<EPiServer:Property PropertyName="PageLink" runat="server" />
			</ItemTemplate>
			<ItemFooterTemplate>
				</li>
			</ItemFooterTemplate>
			<UnindentTemplate>
				</ul>
			</UnindentTemplate>
			<FooterTemplate>
				</div>
			</FooterTemplate>
		</EPiServer:PageTree>
    </div>
    
</asp:Content>