<%@ Register TagPrefix="cc1" Namespace="ComponentArt.Charting" Assembly="ComponentArt.Charting.WebChart" %>
<%@ Page language="c#" Codebehind="Start.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.Start.Start" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.AtAGlance.Title") %></title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Administration.css" >
    <link rel="stylesheet" type="text/css" href="../Styles/Main.css" >

  </head>
  
  <body id="adminPage">
	
    <form id="startPage" method="post" runat="server">
       
        <h1><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.AtAGlance.Header") %></h1>
        
        <table class="epi-atAGlance-table">
            <tbody>
                <asp:Repeater ID="StatisticsRepeater" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Key") %></td>
                            <td><%# Eval("Value")  %></td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="epi-table-evenRow">
                            <td><%# Eval("Key")  %></td>
                            <td><%# Eval("Value")  %></td>
                        </tr>
                    </AlternatingItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
     </form>
  </body>
</html>
