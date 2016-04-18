<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CompareLanguages.ascx.cs" Inherits="EPiServer.Edit.CompareLanguages" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Table Runat="server" Width="100%" Height="100%">
	<asp:TableRow Runat="server">
		<asp:TableCell Runat="server">
			<episerver:translate runat="server" text="/multilanguageruntime/firstlanguage" />:&nbsp;<asp:DropDownList ID="FirstLanguageSelection" Runat="Server" AutoPostBack="True" />
			<episerver:translate runat="server" text="/multilanguageruntime/secondlanguage" />:&nbsp;<asp:DropDownList ID="SecondLanguageSelection" Runat="Server" AutoPostBack="True" />
			<episerver:translate runat="server" text="/multilanguageruntime/verticaldisplay" /><asp:checkbox id="VerticalDisplay" runat="server" AutoPostBack="True" />
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow Runat="server" Height="100%">
		<asp:TableCell Runat="server">
			<div Runat="server" ID="FirstLanguageDiv" />
			<div Runat="server" ID="SecondLanguageDiv" />
		</asp:TableCell>		
	</asp:TableRow>
</asp:Table>