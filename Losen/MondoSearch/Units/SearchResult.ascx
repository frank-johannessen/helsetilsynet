<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SearchResult.ascx.cs" Inherits="BVNetwork.EPiMss.Units.SearchResult" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:placeholder id="pnlSearchedButNoResults" visible="<%# HasDoneSearch && HasResult == false %>" runat="server">
	<div class="nohitsheading">
		<episerver:translate text="/mondosearch/result/caption" runat="server" />
		<%# " \"" + HttpContext.Current.Request.QueryString["searchquery"] + "\" "%>
		<episerver:translate text="/mondosearch/result/nohits" runat="server" />
	</div>
	<episerver:property cssclass="nohitstext" propertyname="SearchResultEmpty" runat="server" ID="Property1"/> 
</asp:placeholder>
<asp:Placeholder id="pnlResultArea" runat="server" visible="<%# HasDoneSearch && HasResult == true %>">
	<asp:repeater id="rptResultPages" runat="server" enableviewstate="False">
		<headertemplate>
			<div class="MssSearchResultHeading">
				<episerver:translate text="/mondosearch/result/resultlist" runat="server" />
			</div>
			<div class="searchresulttext">
				<episerver:translate text="/mondosearch/result/caption" runat="server" />
				<%# "\"" + HttpContext.Current.Request.QueryString["searchquery"] + "\""%>
				<episerver:translate text="/mondosearch/result/caption2" runat="server" />
				<%# SearchInstance.NumberOfPagesFound %> <episerver:translate text="/mondosearch/search/summary/pages" runat="server"/>
				<%# HttpContext.Current.Request.QueryString["viewallcategories"] != null ? RenderViewAllPagesInCategoryLink() : ""%>
			</div>			 
			<div class="MssSearchResultContainer">
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
			</div>
		</footertemplate>		
	</asp:repeater>
</asp:Placeholder>