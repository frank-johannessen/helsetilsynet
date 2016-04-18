<%@ Page language="c#" Codebehind="PageTypeDefinitionCopy.aspx.cs" AutoEventWireup="false" Inherits="EPiCode.PageTypeUtil.Plugins.PageTypeDefinitionCopy" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>Copy Properties to another Page Type</title>
		<link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet">
        <script src="/cms/Javascript/system.js" type="text/javascript"></script>
	</head>
	<body>
		<form method="post" runat="server">
			<h1>Copy Properties to another Page Type</h1>
			<asp:label font-bold="True" forecolor="red" enableviewstate="False" id="lblResult" visible="False"
				runat="server" />
			<b>Source Page Type:</b> 
			<br />
			<div style="padding-left: 20px;">
				<asp:label id="lblPageTypeName" runat="server" />
			</div>
			<div style="padding-left: 20px;color: gray;">
				The source Page Type is the Page Type from where you will copy property definitions <b>from</b>.
				Select the properties you want to copy from the list below by ticking the checkboxes in front
				of the property name.
				<br /><br />
				The text inside the paranthesis is the localized name of the Page Type.
				If you need more information about the type of the property, see the tooltip on the type for
				each property in the list.								
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
				</headertemplate>
				<itemtemplate>
					<tr>
							<td><asp:checkbox runat="server" id="chkImport" enableviewstate="True" /></td>
							<td><%# DataBinder.Eval(Container.DataItem, "Name") %>&nbsp;(<asp:label id="lblPageTypePropertyID" runat="server" enableviewstate="true" text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />)</td>
							<td><span
title="BaseType: <%# DataBinder.Eval(Container.DataItem, "Type.DataType") %>
Class: <%# DataBinder.Eval(Container.DataItem, "Type.TypeName") %>
Assembly: <%# DataBinder.Eval(Container.DataItem, "Type.AssemblyName") %>"
								><%# DataBinder.Eval(Container.DataItem, "Type.Name") %></span>
							</td>
					</tr>
				</itemtemplate>
				<footertemplate>
					</table>
				</footertemplate>
			</asp:repeater>
			<h2>Destination Page Type</h2>
			<asp:dropdownlist id="cboDestPageType" runat="server" enableviewstate="True" />
			<div style="padding-left: 20px;padding-top: 5px; color: gray;">
				The destination Page Type is the Page Type from where you will copy property definitions <b>to</b>.
				Select it from the drop down list above, and click the "Copy Property Definitions" button below.
				<br /><br />
				If you want to copy the same properties to several Page Types, just select another destination
				Page Type after you have clicked the button, and click it again. The previous selection will
				be retained.
				<br /><br />
				Note! If the property already exists on the destination Page Type it will not be copied. You
				cannot copy properties from the same Page Type that has been selected as source.				
			</div>
			<br />
			<asp:button id="cmdSave" runat="server" text="Copy Property Definitions" />
		</form>
	</body>
</html>
