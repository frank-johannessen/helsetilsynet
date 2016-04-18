<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CategoryInformation.ascx.cs" Inherits="BVNetwork.EPiMss.Units.CategoryInformation" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:repeater id="rptCategories" runat="server" enableviewstate="False">
	<headertemplate>
		<div class="MssCategoryContainer">
			<div class="MssCategoryHeader">
				<episerver:translate text="/mondosearch/result/categoryinfo/caption" runat="server" />
			</div>
	</headertemplate>
	<itemtemplate>
		<div class="MssCategoryItem">
			<a class="MssCategoryLink" href="<%# RenderCategoryLink(DataBinder.Eval(Container.DataItem, "Name").ToString()) %>">
			<%# DataBinder.Eval(Container.DataItem, "Title") %></a>
			&nbsp;(<%# DataBinder.Eval(Container.DataItem, "PagesFound") %>)
		</div>
	</itemtemplate>
	<footertemplate>
		</div>
	</footertemplate>
</asp:repeater>