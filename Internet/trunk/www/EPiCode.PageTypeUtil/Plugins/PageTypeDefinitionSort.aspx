<%@ Page language="c#" Codebehind="PageTypeDefinitionSort.aspx.cs" AutoEventWireup="false" Inherits="EPiCode.PageTypeUtil.Plugins.PageTypeDefinitionSort" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>Sort properties without moving one and one</title>
		<link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet">
        <script src="/cms/Javascript/system.js" type="text/javascript"></script>
	</head>
	<body>
		<form method="post" runat="server">
			<h1>Speedsort your properties</h1> 
			<asp:label font-bold="True" forecolor="red" enableviewstate="False" id="lblResult" visible="False"
				runat="server" />
			<div style="padding-bottom: 15px;color: gray;">
				Sort properties for a pagetype without clicking. Just enter a numeric value for each property and click [Sort Properties].
			</div>
			<div style="padding-bottom: 10px;color: black;">
				Properties for pagetype <b><asp:label id="lblPageTypeName" runat="server" /> </b>								
			</div>

			<asp:repeater id="rptPagetypesDef" runat="server" enableviewstate="true">
				<headertemplate>					
					<table border="0" cellpadding="0" cellspacing="0" width=300>
						<thead>
							<tr>															
								<td style="border-bottom: 1px solid gray;"><b>Sort Index</b></td>
								<td style="border-bottom: 1px solid gray;"><b>Name (ID)</b></td>
								<td style="border-bottom: 1px solid gray;"><b>Type</b></td>
							</tr>
						</thead>
				</headertemplate>
				<itemtemplate>
					<tr>
						<td style="border-bottom:1px solid #dddddd"><asp:TextBox Runat=server width="50" ID="txtFieldOrder" Text='<%# DataBinder.Eval(Container.DataItem, "FieldOrder") %>' /></td>
						<td style="border-bottom:1px solid #dddddd">
							<%# DataBinder.Eval(Container.DataItem, "Name") %>
							<asp:label id="lblPropertyId" runat="server" visible="False" enableviewstate="true" text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
						</td>
						<td style="border-bottom:1px solid #dddddd;border-right:1px solid #dddddd"><span style="color: gray;"
							title="BaseType: <%# DataBinder.Eval(Container.DataItem, "Type.DataType") %>
							Class: <%# DataBinder.Eval(Container.DataItem, "Type.TypeName") %>
							Assembly: <%# DataBinder.Eval(Container.DataItem, "Type.AssemblyName") %>">
							<%# DataBinder.Eval(Container.DataItem, "Type.Name") %></span>
						</td>
					</tr>
				</itemtemplate>
				<footertemplate>
					</table>
				</footertemplate>
			</asp:repeater>
			<br />
			<asp:button id="cmdSave" runat="server" text="Sort Properties" />
		</form>
	</body>
</html>
