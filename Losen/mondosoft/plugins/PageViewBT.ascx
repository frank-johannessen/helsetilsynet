<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="PageViewBT.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.PageView" %>
<%@ Register TagPrefix="Mondosoft" Namespace="Mondosoft.EPiServerIntegration.WebControls" Assembly="Mondosoft.EPiServerIntegration" %>
<style>
.page
	{
	margin-bottom:5px;
		padding:2px;
	margin:2px;
	border:none;
	font:normal 11px tahoma;
	}

.cat
{
	background:#e0e0e0;
	height:20px;
	width:99%;
	padding:5px;
	margin-top:20px;
	font-size:11px;
	font-weight:bold;
}
.column
{
	height:100%;
}
.chartimage
{
	overflow:hidden;
}
</style>

<asp:PlaceHolder ID="DataExists" Runat="server" Visible="True">
	<div style="padding:0px; margin:0px;width:300px; float:left; margin-right:10px;">
		<div >
			<div class="cat">
				<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/pageinfo")%> <%=DemoMode%>
				<%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%>
			</div>
			<div class="page">
				<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/pageurl")%> <%=PageUrl%> 
			</div>
			<div class="page">
				<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/totalclicks")%> <%=TotalClicks%>
			</div>
			<div class="page">
				<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/avgdailyclick")%> <%=AvgDailyClick%>
			</div>
		</div>
		<br />
		<div class="cat">
			<b><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/searchphrases")%></b>
		</div>
		<div>
		<asp:repeater id="WordList" runat="server">
			<ItemTemplate>
				<div class="page">
					<a href="<%#EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=29&word=<%#DataBinder.Eval(Container.DataItem, "Word") %>" >
					<%#DataBinder.Eval(Container.DataItem, "Word")%> (<%#DataBinder.Eval(Container.DataItem, "Count")%>)
					</a>
				</div>
			</ItemTemplate>
		</asp:repeater>
		</div>
		<br />
		<div class="cat">
			<b><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/expectedphrases")%></b>
		</div>
		<div>
			<Mondosoft:RelatedWordList Id="RelatedWords" runat="server"/>
		</div>
		<br />
		<br />
		<asp:Button ID="Save" runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/savebutton")%>' />
		<asp:Button ID="Publish" runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/publishbutton")%>' /><br/><br />
		<asp:Button ID="CheckChildrenClickDataButton" OnClick="CheckChildrenClickData" runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/checkchildrenbutton")%>' />
		<asp:repeater id="ChildListData" runat="server">
			<ItemTemplate>
				<div class="page">
					<a href="<%#EPiServer.Global.EPConfig.EditUrl%>EditPanel.aspx?id=<%#((EPiServer.Core.PageReference)DataBinder.Eval(Container.DataItem, "EPiServerPageLink")).ID%>" >
					<%#DataBinder.Eval(Container.DataItem, "PageName")%> (<%#DataBinder.Eval(Container.DataItem, "Count")%>)
					</a>
				</div>
			</ItemTemplate>
		</asp:repeater>

	</div>
	<div class="column">
		<div >
			<div class="cat">
				<b><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/searchtrend")%></b>
			</div>
			<br />
			<div class="chartimage">
				<asp:Image ID="GraphImage" Runat="server" />
			</div>
		</div>
	</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="NoData" Runat="server" Visible="False">
	<div class="cat">
		<b><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/nodata")%></b>
		<asp:Button ID="CheckChildrenNoDataButton"  OnClick="CheckChildrenClickNoData" runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/pageviewbt/checkchildrenbutton")%>' />
		<asp:repeater id="ChildListNoData" runat="server">
			<ItemTemplate>
				<div class="page">
					<a href="/edit/EditPanel.aspx?id=<%#((EPiServer.Core.PageReference)DataBinder.Eval(Container.DataItem, "EPiServerPageLink")).ID%>" >
					<%#DataBinder.Eval(Container.DataItem, "PageName")%> (<%#DataBinder.Eval(Container.DataItem, "Count")%>)
					</a>
				</div>
			</ItemTemplate>
		</asp:repeater>
	</div>
</asp:PlaceHolder>
<asp:Label ID="ErrorMessage" Runat="server" />
<%=SetPageVersionScript()%>
<asp:Button ID="Refresh" Visible="false"  Runat="server"></asp:Button>



