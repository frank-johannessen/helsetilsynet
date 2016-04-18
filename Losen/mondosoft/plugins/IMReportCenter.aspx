<%@ Page language="c#" Codebehind="IMReportCenter.aspx.cs" AutoEventWireup="false" Inherits="Mondosoft.EPiServerIntegration.Plugins.IMReportCenter" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

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


	.headupdate
	{
		background:#e0e0e0;
		border:1px solid #a0a0a0;
		height:100%;

	}
	.rowupdate
	{
		display:block;
		border-left:1px solid #a0a0a0;
		border-right:1px solid #a0a0a0;
		border-bottom:1px solid #a0a0a0;
		height:100%;
		width:100%;

	}
	.colheadingleft
	{
		width:30%;
		height:100%;
		float:left;
		background:#e0e0e0;
		border-right:1px solid #a0a0a0;
		height:26px;
		padding-left:5px;
		padding-top:5px;
		padding-bottom:5px;
	}
	.colheadingright
	{
		width:65%;
		height:100%;
		float:left;
		background:#e0e0e0;
		padding-left:5px;
		padding-top:5px;
		padding-bottom:5px;
	}		
	.colupdateleft
	{
		width:30%;
		height:100%;
		float:left;
		background:#f0f0f0;
		border-right:1px solid #a0a0a0;
		padding-left:5px;
		padding-top:5px;
		padding-bottom:5px;
	}
	.colupdateright
	{
		width:65%;
		height:100%;
		float:left;
		padding-left:5px;
		padding-top:1px;
		padding-bottom:1px;
	}	

	</style>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Form1" method="post" runat="server">
		<h1><asp:Literal ID="Heading" Runat="server"/><%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%></h1>
		<asp:Label ID="GraphImageContainer" runat="server" CssClass="graph" Visible="False">
			<asp:Image ID="GraphImage" Runat="server" />
		</asp:Label>
		<asp:Literal ID="Description" Runat="server"/>
		<br />
		<br />

		<!-- Synonym Update -->
		<asp:PlaceHolder ID="UpdateTheSynonymContainer" runat="server"  >
			<div class="headupdate">
				<div class="colheadingleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updateitemcolumn")%></div>
				<div class="colheadingright"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updatevaluecolumn")%></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft""><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updatequery")%></div>
				<div class="colupdateright"><asp:TextBox ID="Query" Runat="server" Enabled="False" Width="300px" Text="<%#this.Synonym.Query%>" /></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updateexact")%></div>
				<div class="colupdateright"><asp:CheckBox ID="Exact" Runat="server" Checked="<%#this.Synonym.Exact%>" /></div>			
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updateinclude")%></div>
				<div class="colupdateright"><asp:CheckBox ID="Include" Runat="server" Checked="<%#this.Synonym.Include%>" /></div>			
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updateenable")%></div>
				<div class="colupdateright"><asp:CheckBox ID="Enable" Runat="server" Checked="<%#this.Synonym.Enable%>" /></div>			
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updateword")%></div>
				<div class="colupdateright"><asp:TextBox ID="Synonymword" Runat="server" Width="300px" Text="<%#this.Synonym.Word%>" /></div>			
			</div>
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="Save"  Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updatesave")%>' />&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="Delete" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updatedelete")%>'/>&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="Cancel" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/updatecancel")%>'/>
				</div>
			</div>
			<div style="width:100%;margin-top:10px;">
				<asp:Label ID="Message" Runat="server" ></asp:Label>
			</div>

		</asp:PlaceHolder>

		<!-- Search Header Update -->
		<asp:PlaceHolder ID="UpdateTheSearchHeaderContainer" runat="server"  >
			<div class="headupdate">
				<div class="colheadingleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updateitemcolumn")%></div>
				<div class="colheadingright"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatevaluecolumn")%></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft""><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updateword")%></div>
				<div class="colupdateright"><asp:TextBox ID="SearchHeaderWord" Runat="server" Enabled="False" Width="300px" Text="<%#this.SearchHeader.Word%>" /></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updateexact")%></div>
				<div class="colupdateright"><asp:CheckBox ID="ExactSH" Runat="server" Checked="<%#this.SearchHeader.Exact%>" /></div>			
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatepersonalize")%></div>
				<div class="colupdateright"><asp:TextBox ID="Personalize" Runat="server" Enabled="False" Text="<%#this.SearchHeader.Personalize%>" Width="50px"/>&nbsp;&nbsp;<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatepersonalizeinfo")%></div>			
			</div>

			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updateheader")%></div>
				<div class="colupdateright"><asp:PlaceHolder ID="EditorPlaceHolder" Runat="server" /></div>			
			</div>
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="SaveSH" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatesave")%>' />&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="DeleteSH" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatedelete")%>'/>&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="CancelSH" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/updatecancel")%>'/>
				</div>
			</div>
			
			<div style="width:100%;margin-top:10px;">
				<asp:Label ID="MessageSH" Runat="server" ></asp:Label>
			</div>
			
		</asp:PlaceHolder>

		<!-- Search Name Update -->
		<asp:PlaceHolder ID="UpdateTheSearchNameContainer" runat="server"  >
			<div class="headupdate">
				<div class="colheadingleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updateitemcolumn")%></div>
				<div class="colheadingright"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatevaluecolumn")%></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft""><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updateword")%></div>
				<div class="colupdateright"><asp:TextBox ID="SearchNameWord" Runat="server" Enabled="False" Width="300px" Text="<%#this.SearchName.Word%>" /></div>
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updateexact")%></div>
				<div class="colupdateright"><asp:CheckBox ID="ExactSN" Runat="server" Checked="<%#this.SearchName.Exact%>" /></div>			
			</div>
			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatepersonalize")%></div>
				<div class="colupdateright"><asp:TextBox ID="PersonalizeSN" Runat="server" Enabled="False" Text="<%#this.SearchName.Personalize%>" Width="50px"/>&nbsp;&nbsp;<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatepersonalizeinfo")%></div>			
			</div>

			<div class="rowupdate">
				<div class="colupdateleft"><%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updateurl")%></div>
				<div class="colupdateright"><asp:TextBox ID="Url" Runat="server" Width="300px" Text="<%#this.SearchName.URL%>" /></div>		
			</div>
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="SaveSN" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatesave")%>' />&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="DeleteSN" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatedelete")%>'/>&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button Runat="server" Width="110px" ID="CancelSN" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/updatecancel")%>'/>
				</div>
			</div>			
			
			<div style="width:100%;margin-top:10px;">
				<asp:Label ID="MessageSN" Runat="server" ></asp:Label>
			</div>

		</asp:PlaceHolder>

		<!-- List Template No 1 -->
		<asp:Repeater ID="ListNo1" Runat="server">
			<HeaderTemplate>
			<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstheading","") != "" ?
				 "<h2>" + EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstheading","") + "</h2>" : ""%>
			<div class="head">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol0width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol0","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol1width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol1","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol2width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol2","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol3width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol3","")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol4width","0")%>">
					<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol4","")%>
				</div>
			</div>
			</HeaderTemplate>
			<ItemTemplate>
			<div class="row">
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol0width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col0")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol1width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col1")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol2width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col2")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol3width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col3")%>
				</div>
				<div class="col<%#EPiServer.Global.EPLang.TranslateFallback("/mondosoft/imreports/" + reportsection + "/firstcol4width","0")%>">
					<%#DataBinder.Eval(Container.DataItem, "Col4")%>
				</div>
			</div>
			</ItemTemplate>
			<FooterTemplate><br /></FooterTemplate>
		</asp:Repeater>

		<!-- Add Synonym Button -->
		<asp:PlaceHolder ID="AddSynonymContainer" Runat="server" >		
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="AddSynonym"  Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/synonyms/addsynonym")%>' />
				</div>
			</div>
		</asp:PlaceHolder>

		<!-- Add Search Header Button -->
		<asp:PlaceHolder ID="AddSearchHeaderContainer" Runat="server" >		
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="AddSearchHeader" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchheaders/addsearchheader")%>' />
				</div>
			</div>
		</asp:PlaceHolder>

		<!-- Add Search Name Button -->
		<asp:PlaceHolder ID="AddSearchNameContainer" Runat="server" >		
			<div style="width:100%;margin-top:10px;">
				<div style="text-align:right">
					<asp:Button Runat="server" Width="110px" ID="AddSearchName" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/imreports/searchnames/addsearchname")%>' />
				</div>
			</div>
		</asp:PlaceHolder>

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
		
		<asp:Label ID="ErrorMessage" Runat="server" Visable="True" />
		
		<script language="javascript">

		<!-- JavaScript code to set the correct focus -->
	
		var queryElement = document.getElementById('<%=Query.ClientID%>');
		var synonymwordElement = document.getElementById('<%=Synonymword.ClientID%>');
		var searchHeaderElement = document.getElementById('<%=SearchHeaderWord.ClientID %>');
		var editorElement = document.getElementById('<%=EditorPlaceHolder.ClientID%>');
		var searchNameElement = document.getElementById('<%=SearchNameWord.ClientID%>');
		var urlElement = document.getElementById('<%=Url.ClientID%>');
		
	
		if(synonymwordElement!=null && !synonymwordElement.disabled)
			synonymwordElement.focus();
		if(queryElement!=null && !queryElement.disabled)
			queryElement.focus();

		if(editorElement!=null && !editorElement.disabled)
			editorElement.focus();
		if(searchHeaderElement!=null && !searchHeaderElement.disabled)
			searchHeaderElement.focus();

		if(urlElement!=null && !urlElement.disabled)
			urlElement.focus();
		if(searchNameElement!=null && !searchNameElement.disabled)
			searchNameElement.focus();
		</script>
		
     </form>
	
  </body>
</html>
