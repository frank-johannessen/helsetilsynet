<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="EditDynPropField.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditDynPropField" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditPageTypeField</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="stylesheet" type="text/css" href="../util/styles/system.css">
		<script language="JavaScript" src="../util/javascript/system.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="EditDynPropField" method="post" runat="server">
			<EPiServerSys:systemprefix id="PagePrefix" runat="server"/>
			<p>
				<EPiServerSys:ValidationSummary ID="Summary" Runat="server"/>
			</p>
			<EPiServerSys:propertydataform id="DefinitionForm" runat="server"/>
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save" />
			<asp:Button id="DeleteButton" CausesValidation="False" Runat="server" translate="/button/delete" />
			<asp:Button id="CancelButton" CausesValidation="False" Runat="server" translate="/button/cancel" />
		</form>
	</body>
</HTML>
