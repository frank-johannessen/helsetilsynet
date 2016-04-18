<%@ Page language="c#" Codebehind="ActiveLicense.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.Netstar.Admin.ActiveLicense" %>
<!DOCTYPE HTML> 
<html>
  <head>
    <title>Active License</title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="../styles/main.css" type="text/css" rel="stylesheet" />
    <link href="../styles/tabstrip.css" type="text/css" rel="stylesheet">
    <link href="../Administration.css" type="text/css" rel="stylesheet" />
  </head>
  <script type='text/javascript'>
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function TestOfficeAddin()
		{
			if(!document.getElementById("componentTable"))
			{
		        return;
		    }
		}
		
		function onLoad()
		{
		    if(window.TestClientTools)
		    {
		        TestClientTools();
		    } 
		    if(window.TestOfficeAddIn)
		    { 
		        TestOfficeAddIn();
		    }
		}	
	
	</script>	 
  
  <body id="adminPage">
    <form id="ActiveLicense" method="post" runat="server">
		<h1><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.ActiveLicense") %></h1>

        <table class="epi-default" cellspacing="5" cellpadding="0" style="width: 70%">
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                </td>
            </tr>
            <tr>


                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.IssuedTo") %>
                </td>
                <td style="font-weight: normal">
                    <asp:Label ID="labelIssuedTo" Runat="server" />
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.Issued") %>
                </td>

                <td style="font-weight: normal">
                    <asp:Label ID="labelIssued" Runat="server" />
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.MaxSites") %>
                </td>
                <td id="tdMaxSites" runat="server" style="font-weight: normal">
                    <asp:Label ID="labelMaxNumSites" Runat="server" />
                </td>

            </tr>
           <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.Expires") %>
                </td>
                <td id="tdExpires" runat="server" style="font-weight: normal">
                    <asp:Label ID="labelExpires" Runat="server" />
                </td>

            </tr>
            <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.IPRestrictions") %>
                </td>
                <td style="font-weight: normal">
                    <asp:Repeater ID="repeaterIPRestrictions" runat="server">
                        <ItemTemplate>
                            <%# Container.DataItem %><br />
                        </ItemTemplate>
                    </asp:Repeater>
                </td>

            </tr>
            <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.MACRestrictions")%>
                </td>
                <td style="font-weight: normal">
                    <asp:Repeater ID="repeaterMACRestrictions" runat="server">
                        <ItemTemplate>
                            <%# FormatMACAddress((string)Container.DataItem) %><br />
                        </ItemTemplate>
                    </asp:Repeater>
                </td>

            </tr>
            <tr>
                <td style="font-weight: bold">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Licensing.MaxUsers") %>
                </td>
                <td id="tdMaxUsers" runat="server" style="font-weight: normal">
                    <asp:Label ID="labelMaxNumUsers" Runat="server" />
                </td>

            </tr>
            <tr style="display: none;">
                <td style="font-weight: bold">
                    [Missing text /admin/license/licensedescription for en]
                </td>
                <td>
                    
                </td>
            </tr>
           
        </table>
        


    </form>
  </body>
</html>
