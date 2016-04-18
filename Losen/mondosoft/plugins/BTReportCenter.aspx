<%@ Page language="c#" Codebehind="BTReportCenter.aspx.cs" AutoEventWireup="false" Inherits="Mondosoft.EPiServerIntegration.Plugins.BTReportCenter" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>BTReportCenter</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="/util/styles/system.css">
    <script type='text/javascript' src="/util/javascript/system.js"></script>
    <script type='text/javascript'>
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function RunOfficeInstaller()
		{		
			window.open('/util/ActiveX/EPiServerOfficeAddin.msi');
		}

		function TestOfficeAddin()
		{
			if(!document.all['componentTable'])
					return;
		}
	
		// -->
	</script>
	<style>
	.head
	{
		background:#e0e0e0;
		border:1px solid #a0a0a0;
		height:100%;
		padding:4px;
	}
	.row
	{
		display:block;
		border-left:1px solid #a0a0a0;
		border-right:1px solid #a0a0a0;
		border-bottom:1px solid #a0a0a0;
		height:100%;
		width:100%;
		padding:4px;
	}


	.graph
	{
		display:block;
		text-align:center;
		margin-top:20px;
		margin-bottom:20px;
	}
	.col0{ width:0%;float:left;display:none;}	
	.col4{ width:4%;float:left;}	
	.col5{ width:5%;float:left;}	
	.col6{ width:6%;float:left;}	
	.col7{ width:7%;float:left;}	
	.col8{ width:8%;float:left;}	
	.col9{ width:9%;float:left;}	
	.col10{ width:10%;float:left;}	
	.col15{ width:15%;float:left;}	
	.col20{ width:20%;float:left;}	
	.col25{ width:25%;float:left;}	
	.col30{ width:30%;float:left;}	
	.col35{ width:35%;float:left;}	
	.col40{ width:40%;float:left;}	
	.col45{ width:45%;float:left;}	
	.col50{ width:50%;float:left;}	
	.col55{ width:55%;float:left;}	
	.col60{ width:60%;float:left;}	
	.col65{ width:65%;float:left;}	
	.col70{ width:70%;float:left;}	

	.col4r{ width:4%;float:left;text-align:right;}	
	.col5r{ width:5%;float:left;text-align:right;}	
	.col6r{ width:6%;float:left;text-align:right;}	
	.col7r{ width:7%;float:left;text-align:right;}	
	.col5r{ width:8%;float:left;text-align:right;}	
	.col9r{ width:9%;float:left;text-align:right;}	
	.col10r{ width:10%;float:left;text-align:right;}	
	.col15r{ width:15%;float:left;text-align:right;}	
	.col20r{ width:20%;float:left;text-align:right;}	
	.col25r{ width:25%;float:left;text-align:right;}	
	.col30r{ width:30%;float:left;text-align:right;}	
	.col35r{ width:35%;float:left;text-align:right;}	
	.col40r{ width:40%;float:left;text-align:right;}	
	.col45r{ width:45%;float:left;text-align:right;}	
	.col50r{ width:50%;float:left;text-align:right;}	
	.col55r{ width:55%;float:left;text-align:right;}	
	.col60r{ width:60%;float:left;text-align:right;}	
	.col65r{ width:65%;float:left;text-align:right;}	
	.col70r{ width:70%;float:left;text-align:right;}	


	</style>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Form1" method="post" runat="server">
		<h1><asp:Literal ID="Heading" Runat="server"/><%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%>
		</h1>
		<asp:Label ID="GraphImageContainer" runat="server" CssClass="graph" Visible="False">
			<asp:Image ID="GraphImage" Runat="server" />
		</asp:Label>
		<asp:Literal ID="Description" Runat="server"/>
		<br />
		<br />
		
		<!-- List Template No 1 -->
		<asp:Repeater ID="ListNo1" Runat="server">
			<HeaderTemplate>
			<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstheading","") != "" ?
				 "<h2>" + EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstheading","") + "</h2>" : ""%>
			<div class="head">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol0width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol0","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol1width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol1","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol2width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol2","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol3width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol3","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol4width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol4","")%>
				</div>
			</div>
			</HeaderTemplate>
			<ItemTemplate>
			<div class="row">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol0width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col0")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol1width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col1")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol2width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col2")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol3width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col3")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/firstcol4width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col4")%>
				</div>
			</div>
			</ItemTemplate>
			<FooterTemplate><br /></FooterTemplate>
		</asp:Repeater>

		<!-- List Template No 2 -->
		<asp:Repeater ID="ListNo2" Runat="server">
			<HeaderTemplate>
			<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondheading","") != "" ?
				 "<h2>" + EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondheading","") + "</h2>" : ""%>
			<div class="head">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol0width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol0","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol1width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol1","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol2width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol2","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol3width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol3","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol4width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol4","")%>
				</div>
			</div>
			</HeaderTemplate>
			<ItemTemplate>
			<div class="row">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol0width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col0")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol1width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col1")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol2width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col2")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol3width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col3")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/secondcol4width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col4")%>
				</div>
			</div>
			</ItemTemplate>
			<FooterTemplate><br /></FooterTemplate>
		</asp:Repeater>

		<!-- List Template No 3 -->
		<asp:Repeater ID="ListNo3" Runat="server">
			<HeaderTemplate>
			<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdheading","") != "" ?
				 "<h2>" + EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdheading","") + "</h2>" : ""%>
			<div class="head">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol0width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol0","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol1width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol1","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol2width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol2","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol3width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol3","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol4width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol4","")%>
				</div>
			</div>
			</HeaderTemplate>
			<ItemTemplate>
			<div class="row">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol0width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col0")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol1width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col1")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol2width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col2")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol3width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col3")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/btreports/" + reportsection + "/thirdcol4width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col4")%>
				</div>
			</div>
			</ItemTemplate>
			<FooterTemplate><br /></FooterTemplate>
		</asp:Repeater>
		
		<asp:Label ID="NoOfItemsLabel" Visible="True" runat="server" >
			<%#EPiServer.Global.EPLang.Translate("/mondosoft/btreports/general/noofitems")%>&nbsp;
			<asp:DropDownList ID="DropDown" Runat="server">
				<asp:ListItem Value="10">10</asp:ListItem>
				<asp:ListItem Value="20">20</asp:ListItem>
				<asp:ListItem Value="50">50</asp:ListItem>
				<asp:ListItem Value="100">100</asp:ListItem>
				<asp:ListItem Value="500">500</asp:ListItem>
			</asp:DropDownList>&nbsp;
			<asp:Button ID="Refresh" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/btreports/general/refresh")%>' Runat="server"></asp:Button>
		</asp:Label>
		
		<asp:Label ID="ErrorMessage" Runat="server" Visible="False" />
     </form>
	
  </body>
</html>
