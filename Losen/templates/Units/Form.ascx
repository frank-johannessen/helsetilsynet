<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Form.ascx.cs" Inherits="development.templates.Units.Form" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
			<development:PageBody id="PageBody" runat="server"></development:PageBody>
			<asp:Literal runat="server" id="PostedMessage"></asp:Literal>
			<asp:Panel Runat="server" ID="FormPanel">
<!-- Print_start -->
				<episerver:property PropertyName="MainForm" runat="server" ID="FormProperty" />
<!-- Print_end -->
			</asp:Panel>
			<asp:Panel Runat="server" ID="StatisticsPanel" Visible="false">
				<p>
					<asp:literal id="NumberOfVotes" runat="server" />
					<!-- Set StatisticsType to format output: N=numbers only, P=percentage -->
					<episerver:formstatistics StatisticsType="N" runat="server" id="Statistics" PropertyName="MainForm" />
				</p>
			</asp:Panel>
			<br>
			<asp:LinkButton ID="Switch" runat="server" OnClick="SwitchView">
				<episerver:translate Text="#showstat" runat="server" ID="Translate3" />
			</asp:LinkButton>

