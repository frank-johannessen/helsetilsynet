<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Register.ascx.cs" Inherits="development.templates.Units.Register" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<table cellspacing="0" cellpadding="0" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td>
			<asp:Panel Runat="server" ID="SaveFailed" Visible="false">
				<H3>
					<episerver:translate id="Translate3" runat="server" Text="#couldnotsave"></episerver:translate></H3>
				<asp:Label id="ErrorMessage" Runat="server"></asp:Label>
			</asp:Panel>
			<asp:Panel Runat="server" ID="SaveSucceded" Visible="false">
				<H3>
					<episerver:translate id="Translate1" runat="server" Text="#saved"></episerver:translate></H3>
					<asp:Label id="savedMessage" Runat="server"></asp:Label>
					<br><a href="/util/login.aspx?ReturnUrl=<%#Server.UrlEncode("/templates/Subscribe____5972.aspx")%>">Logg inn.</a>
			</asp:Panel>
			<asp:Panel Runat="server" ID="DenyRegistring" Visible="false">
				<H3>
					<episerver:translate id="Translate2" runat="server" Text="#notallowed"></episerver:translate></H3>
			</asp:Panel>
			<asp:Panel Runat="server" ID="CreateEditUser">
				<EPiServerSys:propertydataform id="EditForm" runat="server" AutoLoadTabs="false">
					<CaptionTemplate>
						<%#Container.Property.DisplayName%>
					</CaptionTemplate>
				</EPiServerSys:propertydataform>
				<BR>
				<asp:Button id="ApplyButton" onclick="ApplyButton_Click" Runat="server" translate="/button/save"></asp:Button>
			</asp:Panel>
			<asp:Panel Runat="server" ID="Login"></asp:Panel>
		</td>
	</tr>
</table>
