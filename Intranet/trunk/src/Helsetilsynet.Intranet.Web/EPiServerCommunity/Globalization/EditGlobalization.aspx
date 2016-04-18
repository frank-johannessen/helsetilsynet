<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Page Language="c#" CodeBehind="EditGlobalization.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.EditGlobalization" %>

<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="ss" TagName="FindTranslationControl" Src="FindTranslationControl.ascx" %>
<%@ Register TagPrefix="ss" TagName="AddTranslationControl" Src="AddTranslationControl.ascx" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>Globalization</title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="../styles/main.css" type="text/css" rel="stylesheet" />
    <link href="../styles/tabstrip.css" type="text/css" rel="stylesheet">
    <link href="../Administration.css" type="text/css" rel="stylesheet" />
    <!--[if gte IE 5.5000]>
			<SCRIPT src="../js/pngfix.js" type="text/javascript"></SCRIPT>
	<![endif]-->
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
  </head>
  <body id="adminPage">
    <h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.Globalization")%></h1>
    <form id="Globalization" method="post" runat="server">
    <div id="tabStrip">
        <ComponentArt:TabStrip ID="tabStripTabs" runat="server" CssClass="topGroup" MultiPageId="multiPageTabs" ImagesBaseUrl="../images/tabstrip" DefaultGroupTabSpacing="0" DefaultDisabledItemLookId="DisabledTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultItemLookId="DefaultTabLook">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="tabstripTabFindTranslation" Text="Find Translation" />
                <ComponentArt:TabStripTab runat="server" ID="tabstripTabAddKey" />
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="multiPageTabs" runat="server" CssClass="multiPage">
            <ComponentArt:PageView runat="server" Width="100%" ID="pageViewFindTranslation">
                <ss:FindTranslationControl runat="server"></ss:FindTranslationControl>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" Width="100%" ID="pageViewAddKey">
                <ss:AddTranslationControl runat="server"></ss:AddTranslationControl>
            </ComponentArt:PageView>
        </ComponentArt:MultiPage>
    </div>
    </form>
</body>
</html>
