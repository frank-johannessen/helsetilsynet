<%@ Page language="c#" Codebehind="ExpiredPages.aspx.cs" AutoEventWireup="false" Inherits="development.ExpiredPages" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<HTML>
		<HEAD>
			<script language="JavaScript" src="../../util/javascript/system.js"></script>
			<script language="JavaScript" src="../../util/javascript/edit.js"></script>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			//Needed for standard EPiServer functionality
				function onNavigate(newPageLink)
				{
				return -1;
				}
				  
				function onCommand(newCommand)
				{
				return -1;
				}
			//-->
			</SCRIPT>
			<LINK href="../../util/styles/system.css" type="text/css" rel="stylesheet">
		</HEAD>
		<body bgcolor="#ffffff" text="#000000" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<form runat="server" id="Subscriptions">
				<h1 class="EP-systemHeading">Artikler som skal revideres</h1>
				<table cellpadding="3" cellspacing="0">
					<tr>
						<td>Start Dato</td>
						<td><input runat="server" name="DateStart" type="text" maxlength="20" size="20" id="DateStart" class="EPEdit-inputDate" /><input type="button" value="..." OnClick="onGetDate('/',document.all['DateStart']);" /></td>
					</tr>
					<tr>
						<td>Slutt Dato</td>
						<td><input runat="server" name="DateEnd" type="text" maxlength="20" size="20" id="DateEnd" class="EPEdit-inputDate" /><input type="button" value="..." OnClick="onGetDate('/',document.all['DateEnd']);" /></td>
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
							<episerver:PropertySearch PageLink=<%#EPiServer.Global.EPConfig.StartPage%> runat="server" ID="PropertySearchControl">
							</episerver:PropertySearch>
							<episerver:PageList SortBy="PageName" DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
								<ItemTemplate>
								<tr>
									<td><a target="_parent" href="/edit/default.aspx?id=<%#Container.CurrentPage.Property["PageLink"].Value%>"><episerver:property PropertyName="PageName" runat="server" ID="Property2"/></a>
										<br>Revideringsdato: <%#((DateTime) Container.CurrentPage.Property["Revision"].Value).ToString("dd.MM.yyyy")%>
										<br>Opprettet av: <episerver:property PropertyName="PageCreatedBy" runat="server" ID="Property3"/>									
									</td>
								</tr>
								</ItemTemplate>
							</episerver:PageList>
						</td>
					</tr>
				</table>
			</form>
		</body>
	</HTML>
