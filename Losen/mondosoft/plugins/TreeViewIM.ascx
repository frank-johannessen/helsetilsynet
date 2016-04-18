<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="TreeViewIM.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.TreeViewIM" %>
<style>
.cat
{
	background:#e0e0e0;
	height:20px;
	width:100%;
	padding:5px;
	margin-top:10px;
	font-size:11px;
	font-weight:bold;
}
.row
{
	margin-bottom:5px;
	padding:2px;
	margin-top:5px;
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

<asp:Label ID="SynonymsContainer" Runat="server">
	<div class="cat">
	<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/IMReportCenter.aspx?report=10',''));" >
	<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/menuname")%></a>
	</div>
</asp:Label>

<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/IMReportCenter.aspx?report=11',''));" >
<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/menuname")%></a>
</div>
<div class="cat">
<a href="#" OnClick="window.parent.commandEvent(window, new window.parent.commandDescriptor('','<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/plugins/IMReportCenter.aspx?report=12',''));" >
<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/menuname")%></a>
</div>
