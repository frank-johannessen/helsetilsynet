<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SearchBlogs.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SearchBlogs" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />

<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.blog")%></h1>
<div id="tabStrip">
<ComponentArt:TabStrip id="tabStripBlog" 
		CssClass="topGroup"
		DefaultItemLookId="DefaultTabLook"
		DefaultSelectedItemLookId="SelectedTabLook"
		DefaultDisabledItemLookId="DisabledTabLook"
		DefaultGroupTabSpacing="0"
		ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		MultiPageId="multiPageBlog"
		runat="server">
		<ItemLooks>
			<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
		</ItemLooks>
		<Tabs>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabSearchBlogs"></ComponentArt:TabStripTab>
		</Tabs>
		</ComponentArt:TabStrip>
		<ComponentArt:MultiPage id="multiPageBlog" CssClass="multiPage" runat="server">
		
			<ComponentArt:PageView runat="server" ID="pageViewSearchBlogs">
			
				<asp:Panel ID="panelValidators" Runat="server">
				    <asp:RangeValidator ID="validatorMinEntries" runat="server" Display="None" EnableClientScript="false" ControlToValidate="textBoxMinNumOfEntries" MinimumValue="0" MaximumValue="1000" Type="Integer" />
				    <asp:RangeValidator ID="validatorMaxEntries" runat="server" Display="None" EnableClientScript="false" ControlToValidate="textBoxMaxNumOfEntries" MinimumValue="0" MaximumValue="1000" Type="Integer" />
				    <asp:CustomValidator ID="validatorCreateDateStart" runat="server" Display="None" EnableClientScript="false" OnServerValidate="validatorCreateDateStart_ServerValidate" />
				    <asp:CustomValidator ID="validatorCreateDateEnd" runat="server" Display="None" EnableClientScript="false" OnServerValidate="validatorCreateDateEnd_ServerValidate" />
				</asp:Panel>

				<table class="epi-default" cellpadding="0" cellspacing="0">
				<tr>
					<th>
						<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.MenuHeader") %>
					</th>
					<th colspan="6">&nbsp;</th>
				</tr>
				<tr>
				<td class="menu" rowspan="4">
						<button class="button" <% = (!AccessRights.Administrate ? "disabled" : "") %> onclick="SCBlogOpenBlog();"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.buttonCreateNewBlog") %></button>
				</td>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputName") %>:</td>
					<td><asp:TextBox ID="textBoxName" Runat="server" CssClass="input" Width="120" MaxLength="200" /></td>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputCategory") %>:</td>	
					<td><asp:DropDownList ID="dropDownCategory" Runat="server" Width="120" CssClass="input"></asp:DropDownList></td>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.Search.inputStatus") %>:</td>
                    <td><asp:DropDownList ID="dropDownStatus" runat="server" CssClass="input" Width="120" /></td>
				</tr>
				<tr>
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputMinNumEntries") %>:</td>
					<td><asp:TextBox ID="textBoxMinNumOfEntries" Runat="server" Width="120" MaxLength="10" CssClass="input"></asp:TextBox></td>
					<td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputMaxNumEntries") %>:</td>
					<td><asp:TextBox ID="textBoxMaxNumOfEntries" Runat="server" Width="120" MaxLength="10" CssClass="input"></asp:TextBox></td>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputBlogType") %>:</td>
					<td><asp:DropDownList ID="dropDownListBlogType" Runat="server" CssClass="input" Width="120" ></asp:DropDownList></td>					
				</tr>
				<tr>
					<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputCreationDate") %>:</td>
					<td colspan="5">
						<asp:DropDownList ID="dropDownListCreateDateYearStart" Runat="server" CssClass="input" />
						-
						<asp:DropDownList ID="dropDownListCreateDateMonthStart" Runat="server" CssClass="input" />
						-
						<asp:DropDownList ID="dropDownListCreateDateDayStart" Runat="server" CssClass="input" />
						&nbsp;
						<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.inputCreationDateAnd") %> 
						&nbsp;
						<asp:DropDownList ID="dropDownListCreateDateYearEnd" Runat="server" CssClass="input" />
						-
						<asp:DropDownList ID="dropDownListCreateDateMonthEnd" Runat="server" CssClass="input" />
						-
						<asp:DropDownList ID="dropDownListCreateDateDayEnd" Runat="server" CssClass="input" /></td>
				</tr>
				<tr>
					<td colspan="6" align="right"><asp:Button id="buttonSearch" Runat="server" CssClass="button" /></td>
				</tr>
				</tbody>
				</table>
				
				<br />
				
				<asp:PlaceHolder ID="placeHolderSearchResult" Runat="server" Visible="False">
				
				<table cellpadding="0" cellspacing="0" width="100%" class="epi-default">
				<thead>
					<tr>
						<th colspan="4"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.HeaderSearchResult") %> (<% = TotalHits %>)</th>
					</tr>
				</thead>
				<tr>
					<th align="left"><asp:LinkButton ID="linkButtonName" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonNumberOfEntries" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonStatus" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonCreated" Runat="server"></asp:LinkButton></th>				
				</tr>
				<tr runat="server" id="rowPagingTop">
					<td colspan="4"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
				</tr>
				
				<asp:DataList ID="dataListSearchResult" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID">
					<ItemTemplate>
					<tr>
						<td><a href="javascript:SCBlogOpenBlog(<%# DataBinder.Eval(Container.DataItem, "ID") %>);"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></a></td>
						<td><%# DataBinder.Eval(Container.DataItem, "NumEntries") %></td>
						<td><%# GetBlogStatus((EPiServer.Common.EntityStatus)(DataBinder.Eval(Container.DataItem, "Status"))) %></td>
						<td><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></td>
					</tr>
					</ItemTemplate>
				</asp:DataList>
				
				<tr runat="server" id="rowNoResult">
					<td colspan="4"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.SearchBlog.NoResult") %>.</td>
				</tr>
				<tr runat="server" id="rowPagingBottom">
					<td colspan="4"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
				</tr>
				
				</table>
				
				</asp:PlaceHolder>
			</ComponentArt:PageView>
	</ComponentArt:MultiPage>
</div>