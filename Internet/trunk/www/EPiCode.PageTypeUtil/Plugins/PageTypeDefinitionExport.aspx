<%@ Page language="c#" Codebehind="PageTypeDefinitionExport.aspx.cs" AutoEventWireup="false" Inherits="EPiCode.PageTypeUtil.Plugins.PageTypeDefinitionExport" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Export Properties to XML File</title>
	<link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet">
    <script src="/cms/Javascript/system.js" type="text/javascript"></script>

  </head>
  <body>
	<form id="Form1" method="post" runat="server">
		<h1>Export Properties to XML File</h1>
		<asp:label font-bold="True" forecolor="red" enableviewstate="False" id="lblResult" visible="False"
			runat="server" />
		<b>Source Page Type:</b> 
		<br />
		<div style="padding-left: 20px;">
			<asp:label id="lblPageTypeName" runat="server" /><br />
			<br />
		</div>
		<div style="padding-left: 20px;color: gray;">
			Select the properties you wish to export.<br />
			Click <asp:LinkButton Runat="server" ID="LinkButtonSelectAll">Select All</asp:LinkButton> and <asp:LinkButton Runat="server" ID="LinkButtonSelectNone">Select None</asp:LinkButton> to toggle the selected checkboxes.
		</div>
		<asp:repeater id="rptPagetypesDef" runat="server" enableviewstate="true">
			<headertemplate>
				<h2>Properties</h2>
				<table border="0" cellpadding="2" cellspacing="0">
					<thead>
						<tr>
							<td style="border-bottom: 1px solid gray;">&nbsp;</td>
							<td style="border-bottom: 1px solid gray;"><b>Name (ID)</b></td>
							<td style="border-bottom: 1px solid gray;"><b>Type</b></td>
						</tr>
					</thead>
					<tbody>
			</headertemplate>
			<itemtemplate>
				<tr>
					<td><asp:checkbox runat="server" id="chkImport" enableviewstate="true" checked="True" /></td>
					<td><asp:label id="LabelName" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' /></td>
					<td>
						<asp:label id="LabelEditCaption" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "EditCaption") %>' Visible="False" />
						<asp:label id="LabelHelpText" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "HelpText") %>' Visible="False" />
						<asp:label id="LabelRequired" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Required") %>' Visible="False" />
						<asp:label id="LabelSearchable" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Searchable") %>' Visible="False" />
						<asp:label id="LabelLanguageSpecific" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "LanguageSpecific") %>' Visible="False" />
						<asp:label id="LabelTab" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Tab.Name") %>' Visible="False" />
						<asp:label id="LabelTypeName" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Type.Name") %>' />
						<asp:label id="LabelTypeDataType" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Type.DataType") %>' Visible="False" />
						<asp:label id="LabelTypeTypeName" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Type.TypeName") %>' Visible="False" />
						<asp:label id="LabelTypeAssemblyName" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Type.AssemblyName") %>' Visible="False" />
					</td>
				</tr>
			</itemtemplate>
			<footertemplate>
					</tbody>
				</table>
			</footertemplate>
		</asp:repeater>
		<h2>XML File Details</h2>
		<div style="padding-left: 20px;padding-top: 5px; color: gray;">
			The file will be saved in the <%= System.Web.HttpContext.Current.Server.MapPath(EPiCode.PageTypeUtil.PropertyImport.Configuration.VirtualImportDirectory) %> folder.
		</div>
		<table>
			<tr>
				<td>File Name:</td>
				<td><asp:TextBox Runat="server" ID="TextboxFileName" Width="300"></asp:TextBox></td>
			</tr>
			<tr>
				<td>Import Info Name:</td>
				<td><asp:TextBox Runat="server" ID="TextboxInfoName" Width="300"></asp:TextBox></td>
			</tr>
			<tr>
				<td>Import Info Description:</td>
				<td><asp:TextBox Runat="server" ID="TextboxInfoDesc" TextMode="MultiLine" Width="300" Height="50"></asp:TextBox></td>
			</tr>
		</table>
		<asp:button id="cmdSave" runat="server" text="Create XML File" />
	</form>
	
  </body>
</html>
