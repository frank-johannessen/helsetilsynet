<%@ Page language="c#" Codebehind="PageTypeDefinitionUtil.aspx.cs" AutoEventWireup="false" Inherits="EPiCode.PageTypeUtil.Plugins.PageTypeDefinitionUtil" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>PageType Util</title>
		<link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet">
        <script src="/cms/Javascript/system.js" type="text/javascript"></script>    
	</head>
	<body>
		<form method="post" runat="server">
			<h1>Pagetype Properties Utility</h1>
			<asp:label font-bold="True" forecolor="red" enableviewstate="False" id="lblResult" visible="False"
				runat="server" />
			<asp:label id="lblPageTypeName" runat="server" font-bold="True" />
			<br>
			<asp:repeater id="rptPagetypesDef" runat="server" enableviewstate="true">
				<headertemplate>
					<h2>Properties</h2>
					<table border="0" cellpadding="2" cellspacing="0">
						<thead>
							<tr>
								<td style="border-bottom: 1px solid gray;"><b>Name (ID)</b>&nbsp;</td>
								<td style="border-bottom: 1px solid gray;"><b>Basetype</b>&nbsp;</td>
								<td style="border-bottom: 1px solid gray;"><b>TypeName</b>&nbsp;</td>
								<td style="border-bottom: 1px solid gray;"><b>Type Class Name</b>&nbsp;</td>
								<td style="border-bottom: 1px solid gray;"><b>AssemblyName</b>&nbsp;</td>
							</tr>
						</thead>
				</headertemplate>
				<itemtemplate>
					<tr>
							<td><%# DataBinder.Eval(Container.DataItem, "Name") %>&nbsp;(<asp:label id="lblPageTypeID" runat="server" enableviewstate="true" text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />)</td>
							<td><%# DataBinder.Eval(Container.DataItem, "Type.DataType") %></td>
							<td><%# DataBinder.Eval(Container.DataItem, "Type.Name") %></td>
							<td><%# DataBinder.Eval(Container.DataItem, "Type.TypeName") %></td>
							<td><%# DataBinder.Eval(Container.DataItem, "Type.AssemblyName") %></td>
					</tr>
				</itemtemplate>
				<footertemplate>
					</table>
				</footertemplate>
			</asp:repeater>
			<asp:placeholder runat="server" visible="False">
			<br />
			<asp:button id="cmdSave" runat="server" text="Save Changes" />
			</asp:placeholder>
			<br>
			<br>
			<h2>Available Import Files</h2>
			The list below shows the available importfiles found on this site. You can import one or more of the files by
			ticking the checkbox in front of the name and clicking the Import From Xml button.
			<br />
			<br />
			If one or more of the
			properties in the file already exists, those properties will not be imported to the Page Type. Also, if the
			file has properties with unknown types (not currently defined for this site), those properties will not be
			imported to the Page Type.
			<br /><br />
			<asp:repeater id="rptImportFiles" runat="server">
				<itemtemplate>
					<b>
					<asp:checkbox id="chkDoImportFile" checked="False" text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' runat="server" />
					</b>
					<br />
					<div style="padding-left: 20px;">
						<%# DataBinder.Eval(Container.DataItem, "Description") %>
						<br />
						<i>File: <asp:label id="lblImportPath" text='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' runat="server" /></i>
						<br />
						<asp:repeater datasource='<%# DataBinder.Eval(Container.DataItem, "Properties") %>' runat="server" >
							<headertemplate>
								<b>Properties that will be imported</b>
								<table border="0" cellpadding="2" cellspacing="0">
									<thead>
										<tr>
											<td style="border-bottom: 1px solid gray;"><b>Name (ID)</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>Basetype</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>TypeName</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>Type Class Name</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>AssemblyName</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>Required</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>Searchable</b>&nbsp;</td>
											<td style="border-bottom: 1px solid gray;"><b>Tab</b>&nbsp;</td>
										</tr>
									</thead>
							</headertemplate>
							<itemtemplate>
								<tr>
										<td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "BaseType") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "TypeName") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "FullType") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "AssemblyName") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "Required") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "Searchable") %></td>
										<td><%# DataBinder.Eval(Container.DataItem, "Tab") %></td>
								</tr>
							</itemtemplate>
							<footertemplate>
								</table>
							</footertemplate>

						</asp:repeater>
					</div>

					<br />
				</itemtemplate>				
			</asp:repeater>
			
			<asp:panel runat="server" id="pnlImportXml">
				<asp:button id="cmdImportXml" text="Import From Xml" runat="server" />
				<br>
				Note! Properties that already exist on the page type will not be imported.
			</asp:panel>
			
			<asp:repeater id="rptImportProps" runat="server">
				<itemtemplate>
					<%# DataBinder.Eval(Container.DataItem, "Name") %>
					<br />
				</itemtemplate>
			</asp:repeater>

			<br /><br />
<script language="javascript">
<!--
function hide(elemName)
{
	
	document.all[elemName].style.visibility = "hidden";
	document.all[elemName].style.display = "none";
	
}
function show(elemName)
{
	document.all[elemName].style.visibility = "visible";
	document.all[elemName].style.display = "inline";
}
function toggle(elemName)
{
	if (document.all[elemName].style.visibility == "visible")
		hide(elemName);
	else
		show(elemName);
}
//-->
</script>
<style>
	.hidden {
		visibility: hidden; 
		display: none;
	}
</style>

			<a href="#" onclick="toggle('divAllTypes')">See a list of all property types in the system</a>
			<div class="hidden" id="divAllTypes">
				<br />
				<asp:repeater id="rptTypes" runat="server" datasource='<%# EPiServer.DataAbstraction.PageDefinitionType.List() %>'>
					<headertemplate>
						<table border="0" cellpadding="2" cellspacing="0">
							<thead>
								<tr>
									<td style="border-bottom: 1px solid gray;"><b>Name (ID)</b>&nbsp;</td>
									<td style="border-bottom: 1px solid gray;"><b>TypeName</b>&nbsp;</td>
									<td style="border-bottom: 1px solid gray;"><b>DataType</b>&nbsp;</td>
									<td style="border-bottom: 1px solid gray;"><b>AssemblyName</b>&nbsp;</td>
								</tr>
							</thead>
					</headertemplate>
					<itemtemplate>
						<tr>
							<td><%# DataBinder.Eval(Container.DataItem, "Name") %> (<%# DataBinder.Eval(Container.DataItem, "ID") %>)</td>
							<td><%# DataBinder.Eval(Container.DataItem, "TypeName") %></td>
							<td><%# DataBinder.Eval(Container.DataItem, "DataType") %></td>
							<td><%# DataBinder.Eval(Container.DataItem, "AssemblyName") %></td>
						</tr>
					</itemtemplate>
					<footertemplate>
						</table>
					</footertemplate>
				</asp:repeater>
			</div>
		</form>
	</body>
</html>
