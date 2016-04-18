<%@ Page language="c#" Codebehind="SubscriptionStatistics.aspx.cs" AutoEventWireup="false" Inherits="development.SubscriptionStatistics" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<HTML>
	<script language="JavaScript" src="../../util/javascript/system.js"></script>
	<script language="JavaScript" src="../../util/javascript/edit.js"></script>
	<LINK href="../../util/styles/system.css" type="text/css" rel="stylesheet">
		<body bgcolor="#ffffff" text="#000000" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<form runat="server" id="Subscriptions">
				<h1 class="EP-systemHeading">Statistikk på abonnering</h1>
				<table cellpadding="3" cellspacing="0">
					<tr>
						<td>Start Dato</td>
						<td><input runat="server" name="DateStart" type="text" maxlength="20" size="20" id="DateStart" class="EPEdit-inputDate"><input type="button" value="..." OnClick="onGetDate('/',document.all['DateStart']);"></td>
					</tr>
					<tr>
						<td>Slutt Dato</td>
						<td><input runat="server" name="DateEnd" type="text" maxlength="20" size="20" id="DateEnd" class="EPEdit-inputDate"><input type="button" value="..." OnClick="onGetDate('/',document.all['DateEnd']);"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="submit" value="Oppdater liste"></td>
					</tr>
				</table>
				<br>
				<br>
				<table cellpadding="5" cellspacing="0">
					<tr>
						<td>
							<asp:Literal id="output" Runat="server" />
						</td>
					</tr>
				</table>
			</form>
		</body>
</HTML>
