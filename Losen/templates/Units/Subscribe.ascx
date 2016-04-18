<%@ Register TagPrefix="development" TagName="PageBody" Src="~/templates/Units/PageBody.ascx"%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Subscribe.ascx.cs" Inherits="development.templates.Units.Subscribe" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:panel id="ReceiptArea" runat="server">
	<episerver:property propertyname="ReceiptText" runat="server" id="Property1" name="Property1"/>
</asp:panel>
<asp:panel id="SubscribeArea" runat="server">
	<table id="subscribeSettings" XmlNs:episerver="http://schemas.episerver.com/WebControls">
		<tr>
			<td>
				<episerver:translate text="#email" runat="server" id="Translate1" name="Translate1"/>
			</td>
			<td>
				<asp:textbox cssclass="loginInput" id="txtEmail" runat="server"></asp:textbox>
			</td>
		</tr>
		<tr>
			<td>
				<episerver:translate id="Translate3" text="#interval" runat="server"></episerver:translate></td>
			<td>
				<asp:dropdownlist id="interval" runat="Server">
					<asp:listitem value="0">#fastaspossible</asp:listitem>
					<asp:listitem value="1">#daily</asp:listitem>
					<asp:listitem value="2">#everysecondday</asp:listitem>
					<asp:listitem value="7">#weekly</asp:listitem>
					<asp:listitem value="14">#everysecondweek</asp:listitem>
					<asp:listitem value="28">#everyfourthweek</asp:listitem>
				</asp:dropdownlist>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<episerver:translate id="Translate2" text="#subscriptions" runat="server"></episerver:translate>
			</td>
			<td>
				<episerver:subscriptionlist id="subList" enableviewstate="True" runat="server"></episerver:subscriptionlist>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<asp:button id="saveSub" onclick="Save_Click" runat="server" translate="/button/save"></asp:button>
				&nbsp;
				<asp:label id="lblErrorMessage" cssclass="errorlabel" runat="server" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br/>
				<development:pagebody runat="server" />
			</td>
		</tr>
	</table>
</asp:panel>
