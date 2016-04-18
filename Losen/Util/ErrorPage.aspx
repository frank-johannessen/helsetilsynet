<%@ Page language="c#" Codebehind="ErrorPage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.CustomErrorPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>ErrorPage</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="../styles/episerver3.css">
    	<script language="JavaScript" src="../util/javascript/system.js"></script>
		<script language="JavaScript">
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		// -->
		</script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="CustomErrorPage" method="post" action="http://www.episerver.com/system/FormPost.asp">
    <input type="hidden" name="__formid" value="21">
    <input type="hidden" name="f_redirect" value="/templates/Form.asp?id=2583&stat=1">

    <h2><asp:Label ID="ErrorHeading" Runat="server"></asp:Label></h2>
    
        <table width="100%" cellpadding=0 cellspacing=0 border=0>
    <asp:repeater ID="ErrorMessageRepeater" Runat="server">
		<HeaderTemplate>
			<tr bgcolor=#EEEEEE>
				<td width=200><b>Name</b></td>
				<td><b>Value</b></td>
			</tr>		
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
				<td><%#Container.DataItem%></td>
				<td><%#ErrorInfo[Container.DataItem.ToString()]%></td>
			</tr>
		</ItemTemplate>
		<AlternatingItemTemplate>
			<tr bgcolor=#EEEEEE>
				<td><%#Container.DataItem%></td>
				<td><%#ErrorInfo[Container.DataItem.ToString()]%></td>
			</tr>
		</AlternatingItemTemplate>
    </asp:repeater>
    <tr bgcolor=#EEEEEE>
		<td>Name</td>
		<td><input type="text" size="50" name="Name"></td>
    </tr>
    <tr>
		<td>E-mail</td>
		<td><input type="text" size="50" name="E-mail"></td>
    </tr>
    <tr bgcolor=#EEEEEE>
		<td>Description</td>
		<td><textarea cols="40" rows="10" name="Description"></textarea></td>
    </tr>    
    </table>
    <br>
    <input type="hidden" runat="server" id="ErrorMessage" name="ErrorMessage"/>
    <input type="submit" name="__formsave" value="Submit">
     </form>
	
  </body>
</html>
