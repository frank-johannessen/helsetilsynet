<%@ Page language="c#" Codebehind="PrintPage_old.aspx.cs" AutoEventWireup="false" Inherits="development.PrintPage_old" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!--TODO: ADD META TAGS -->
<title><asp:literal id="printtitle" runat="server"/></title>
<link rel="stylesheet" media="screen" type="text/css" href="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>styles/print.css">
<link rel="stylesheet" media="print" type="text/css" href="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>styles/print_paper.css">


<style>
	body {background:ffffff;}
</style>

<HTML>
	<HEAD>
		<title></title>
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
			document.all["screen"].style.display = "none";
			document.all["paper"].style.display = "";
			</script>
			<script for="window" event="onafterprint">
			document.all["header"].style.display = "";
			document.all["screen"].style.display = "";
			document.all["paper"].style.display = "none";
			</script>
			<table class=indent cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td>
									<p id="screen">
										<IMG SRC="/images/htillogo_skrivut_screen.gif" alt="">
									</p>
									<p id="paper" class="paper">
										<IMG SRC="/images/htillogo_skrivut.jpg" alt="" width="182">
									</p>
								</td>
							</tr>
							<tr>
								<td align="right">
									<table id="header" cellpadding="0" cellspacing="0" border="0" class="bt">
										<tr>
											<td>
												<!-- <a href="#" onclick="switchimageshow()">
													<asp:Label Runat="server" id="showimagetext">Skjul bilder</asp:Label></a>-->
											</td>
											<td><img src="/images/pxl.gif" height="1" width="30"></td>
											<td>
												<a href="javascript:print()">Skriv ut</a><br>
											</td>
											<td><img src="/images/pxl.gif" height="1" width="30"></td>
											<td>
												<a href="javascript:this.close()">Lukk</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/images/pxl.gif" width="1" height="5"></td>
							</tr>
							<tr>
								<td bgcolor="#cc0033"><img src="/images/pxl.gif" width="1" height="2"></td>
							</tr>
							<tr>
								<td><img src="/images/pxl.gif" width="1" height="20"></td>
							</tr>
							<tr>
								<td>
									<br><episerver:property PropertyName="PageName" CssClass="PrintTitle" runat="server" id="Property2" /><br><br>
									<episerver:property PropertyName="MainIntro" CssClass="PrintIntro" runat="server" id="Property1" />
									<episerver:property PropertyName="MainBody" runat="server" id="Property3" />
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</form>
	</body>
</HTML>
