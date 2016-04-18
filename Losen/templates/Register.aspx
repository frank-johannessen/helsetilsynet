<%@ Page language="c#" Codebehind="Register.aspx.cs" AutoEventWireup="false" Inherits="development.Register" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Register"	Src="~/templates/Units/Register.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<development:DefaultFramework ID="Defaultframework1" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<development:Register id="Register1" runat="server"></development:Register>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>