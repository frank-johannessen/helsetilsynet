<%@ Control Language="c#" AutoEventWireup="false" Codebehind="RenderCategoryList.ascx.cs" Inherits="BVNetwork.EPiMss.Units.RenderCategoryList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:repeater id="rptResultPagesCategorized" runat="server" enableviewstate="False">		
	<headertemplate>		
		<div class="MssSearchCategoryHeading">
			<span class="MssSearchCategoryHeadingText"><%# CategoryInfo %></span>		
		</div>
		<div class="MssSearchCategoryContainer">
	</headertemplate>
	<itemtemplate>
		<div class="MssSearchItem">
			<div>
				<span class="itemheading">
					<a class="MssSearchResultTitle" href="<%= Configuration.RootDir %>MondoSearch/Click.aspx?LinkClick='<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem, "LinkClick").ToString())%>'"><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
					<%# FileType(DataBinder.Eval(Container.DataItem, "@HTTP_MIMETYPE").ToString()) %>
				</span>
				<span class="aligntop"><%# ((DateTime)DataBinder.Eval(Container.DataItem, "Date")).ToString("dd.MM.yyyy") %></span>
			</div>
			<asp:placeholder visible='<%#Request["showdescription"] != null ? Convert.ToBoolean(Request["showdescription"]) : true%>' runat="server">
				<div class="MssSearchResultDesc">
					<span><%# DataBinder.Eval(Container.DataItem, "Description") %></span>
				</div>
			</asp:placeholder>
		</div>
	</itemtemplate>
	<alternatingitemtemplate>
		<div class="MssSearchItemAlt">
			<div>
				<span class="itemheading">
					<a class="MssSearchResultTitle" href="<%= Configuration.RootDir %>MondoSearch/Click.aspx?LinkClick='<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem, "LinkClick").ToString())%>'"><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
					<%# FileType(DataBinder.Eval(Container.DataItem, "@HTTP_MIMETYPE").ToString()) %>
				</span>
				<span class="aligntop"><%# ((DateTime)DataBinder.Eval(Container.DataItem, "Date")).ToString("dd.MM.yyyy") %></span>
			</div>
			<asp:placeholder visible='<%#Request["showdescription"] != null ? Convert.ToBoolean(Request["showdescription"]) : true%>' runat="server">
				<div class="MssSearchResultDesc">
					<span><%# DataBinder.Eval(Container.DataItem, "Description") %></span>
				</div>
			</asp:placeholder>
		</div>	
	</alternatingitemtemplate>		
	<footertemplate>		
		<asp:PlaceHolder id="pnlViewHitsInCategoryBottom" Visible='<%# Convert.ToInt32(this.PagesFoundForCurrentCategory) > BVNetwork.EPiMss.Library.Configuration.SearchConfiguration.CategoryNumberOfHitsOnPage%>' Runat="server" EnableViewState="False">
			<div class="MssSearchShowAllPagesInCategory">			
				<a href="<%# RenderCategoryLink()%>"><img style="border:none;" src="/images/icon-leftmenu-child.gif"/>&nbsp;<episerver:translate text="/mondosearch/result/showallpagesincategory1" runat="server"/>&nbsp;<%# PagesFoundForCurrentCategory %>&nbsp;<episerver:translate text="/mondosearch/search/summary/pages" runat="server"/></a>
			</div>
		</asp:PlaceHolder>
		</div>
	</footertemplate>		
</asp:repeater>
