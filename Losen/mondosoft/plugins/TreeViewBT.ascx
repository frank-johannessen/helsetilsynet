<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="TreeViewBT.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.TreeViewBT" %>
<style>
.cat
{
	background:#e0e0e0;
	height:20px;
	width:100%;
	padding:3px;
	margin-top:10px;
	font-size:11px;
	font-weight:bold;
}
.row
{
	margin-bottom:3px;
	padding:2px;
	margin-top:3px;
	margin-left:15px;
	border:none;
	font:normal 11px tahoma;
}
.notfoundheading
{
	background:#e0e0e0;
	height:20px;
	width:100%;
	padding:5px;
	margin-top:10px;
	font-size:11px;
	font-weight:bold;
}
.notfoundbox
{
	border: 2px solid #e0e0e0;
	padding: 2px;
	background: #f0f0f0;
}
</style>

<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=10',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/overview/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=11',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/performancemap/menuname")%></a>
</div>
<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=20',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/searchesandclicks/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=21',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/topsearchterms/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=22',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/topnotfound/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=23',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/topnotclicked/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=24',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/toplinkschosen/menuname")%></a>
</div>

<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=30',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/searchsessions/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=31',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/mostrecentsessions/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=33',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/topvisitordomains/menuname")%></a>
</div>

<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=40',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/trends/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=41',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/searchtermstrends/menuname")%></a>
</div>
<div class="row">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=42',''));" >
<%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/behaviormatch/menuname")%></a>
</div>

<br />
<br />
<div class="notfoundheading"><%=EPiServer.Global.EPLang.Translate("/mondosoft/btreports/notfoundbox/heading")%></div>
<div class="notfoundbox">
	<asp:Repeater ID="NotFound" Runat="server">
		<ItemTemplate>
		<div class="row">
			<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/BTReportCenter.aspx?report=29&word=<%#System.Web.HttpUtility.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "Word"))%>',''));" >
			<div class="rowdescription"><%#DataBinder.Eval(Container.DataItem, "Word")%> (<%#DataBinder.Eval(Container.DataItem, "Count")%>)</div>
			</a>
		</div>
		</ItemTemplate>
	</asp:Repeater>
</div>

<asp:Label ID="ErrorMessage" Runat="server" Visable="False" />