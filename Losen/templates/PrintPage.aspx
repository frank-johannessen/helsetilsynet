<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/Units/HeaderPrint.ascx"%>
<%@ Page language="c#" Codebehind="PrintPage.aspx.cs" AutoEventWireup="false" Inherits="development.PrintPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<HTML>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
		<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<script language="Javascript1.2">
		function printpage() 
		{
			window.print();  
			return false;
		}
	</script>
	<body onload="printpage();">
		<form runat="server" id="frm">
			<input type="hidden" id="bhideimage" name="bshowimage" runat="server" value="false">
			<script>
			/*function switchimageshow() {			
				if (document.frm.bhideimage.value == "true") {
					document.frm.bhideimage.value = "false"; 
				}
				else { 
					document.frm.bhideimage.value = "true";
				}				
				document.frm.submit();
			}*/
			</script>

			<script for="window" event="onbeforeprint">
			document.all["header"].style.display = "none";
			document.all["screen"].style.display = "none";
			document.all["paper"].style.display = "";
			</script>
			<script for="window" event="onafterprint">
			document.all["header"].style.display = "";
			document.all["screen"].style.display = "";
			document.all["paper"].style.display = "none";
			</script>

			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<p id="screen">
							<IMG SRC="/images/htillogo_skrivut_screen.gif" alt="">
						</p>
						<p id="paper" style="display:none">
							<IMG SRC="/images/htillogo_skrivut.jpg" alt="" width="182">
						</p>
					</td>
				</tr>
				<tr>
					<td align="right">
						<table id="header" cellpadding="0" cellspacing="0" border="0" class="bt">
							<tr>
								<td>
									<!--
									<a href="#" onclick="switchimageshow()">
										<asp:Label Runat="server" id="showimagetext">Skjul bilder</asp:Label></a>
									-->
								</td>
								<td><img src="/images/pxl.gif" height="1" width="30"></td>
								<td>
									<a href="javascript:print()"><episerver:property PropertyName="PrintPagePrintTxt" runat="server" ID="Property5" /></a><br>
								</td>
								<td><img src="/images/pxl.gif" height="1" width="30"></td>
								<td>
									<a href="javascript:this.close()"><episerver:property PropertyName="PrintPageCloseTxt" runat="server" ID="Property1" /></a>
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
