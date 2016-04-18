<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/Units/HeaderPrint.ascx"%>
<%@ Page language="c#" Codebehind="PrintPage2.aspx.cs" AutoEventWireup="false" Inherits="development.PrintPage2" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<HTML>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
		<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body>
		<form runat="server" id="frm">
			<input type="hidden" id="bhideimage" name="bshowimage" runat="server" value="false">
			<script>
			function switchimageshow() {			
				if (document.frm.bhideimage.value == "true") {
					document.frm.bhideimage.value = "false"; 
				}
				else { 
					document.frm.bhideimage.value = "true";
				}				
				document.frm.submit();
			}
			</script>
			<script for="window" event="onbeforeprint">
			document.all["header"].style.display = "none";
			</script>
			<script for="window" event="onafterprint">
			document.all["header"].style.display = "";
			</script>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td align="right">
						<table id="header" cellpadding="0" cellspacing="0" border="0" class="bt">
							<tr>
								<td>
									<a href="#" onclick="switchimageshow()">
										<asp:Label Runat="server" id="showimagetext">Skjul bilder</asp:Label></a>
								</td>
								<td><img src="/images/pxl.gif" height="1" width="30"></td>
								<td>
									<a href="javascript:print()">
										<episerver:Translate CssClass="EP-tableHeading" Text="/templates/printpage/print" runat="server" id="print" /></a><br>
								</td>
								<td><img src="/images/pxl.gif" height="1" width="30"></td>
								<td>
									<a href="javascript:this.close()">
										<episerver:Translate CssClass="EP-tableHeading" Text="/templates/printpage/close" runat="server" id="close" /></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><img src="/images/pxl.gif" width="1" height="5"></td>
				</tr>
				<tr bgcolor="#DC431F">
					<td><img src="/images/pxl.gif" width="1" height="2"></td>
				</tr>
				</script>
				<tr>
					<td><img src="/images/pxl.gif" width="1" height="20"></td>
				</tr>
			</table>
			<asp:label runat="server" id="output" />
		</form>
	</body>
</HTML>
