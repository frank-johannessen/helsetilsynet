<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="FolderBrowserDialog.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.FolderBrowserProperty.FolderBrowserDialog" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Folder browser</title>
	    <link rel="stylesheet" type="text/css" href="<%=ResolveUrl("~/App_Themes/Default/styles/system.css") %>">
	    <link rel="stylesheet" type="text/css" href="<%=ResolveUrl("~/App_Themes/Default/styles/ToolButton.css") %>">
	    <link href="<%= ShellPath %>ClientResources/Shell.css" type="text/css" rel="stylesheet" />
	    <link href="<%= ShellPath %>ClientResources/ShellLightTheme.css" type="text/css"
	        rel="stylesheet" />
	
	    <script type='text/javascript' src="<%= EPiServer.UriSupport.ResolveUrlFromUIBySettings("javascript/system.js") %>"></script>
	
	    <script type="text/javascript">
	        function OnCloseAndSave(dataPath) {
	            var retObj = new Object();
	            retObj.isOk = true;
	            retObj.Path = dataPath;
	            EPi.GetDialog().Close(retObj);
	        }
	        function OnCloseAndCancel() {
	            EPi.GetDialog().Close();
	        }
	    </script>
	
	</head>
	<body>
	    <form id="pathSelectorForm" runat="server">
	    <div class="epi-contentContainer epi-padding">
	        <div id="containerDiv">
	            <h1>Folder browser</h1>
	            <p>Her kan du velge en mappe i filhierarkiet</p>
	            <asp:TreeView ID="FileTree" runat="server" DataSourceID="FileDataSource" ExpandDepth="0"
	                MaxDataBindDepth="6" OnTreeNodeDataBound="FileTree_TreeNodeDataBound" ShowExpandCollapse="true"
	                EnableClientScript="false" PopulateNodesFromClient="true" OnSelectedNodeChanged="FileTree_TreeNodeSelected">
	                <DataBindings>
	                    <asp:TreeNodeBinding TextField="Name" ImageUrlField="ImageUrl" PopulateOnDemand="false" />
	                </DataBindings>
	                <SelectedNodeStyle Font-Bold="true" />
	                <NodeStyle HorizontalPadding="3" />
	            </asp:TreeView>
	            <br />
	            <EPiServer:FileSystemDataSource runat="server" ID="FileDataSource" IncludeRoot="true" />
	            <span class="epitoolbutton">
	                <asp:Button ID="InsertButton" Text="Lagre" runat="server" OnClick="InsertButton_Click" />
	            </span>&nbsp;&nbsp; <span class="epitoolbutton">
	                <asp:Button ID="CancelButton" Text="Avbryt" runat="server" OnClick="CancelButton_Click" />
	            </span>
	            <br />
	            <br />
	        </div>
	    </div>
	    <asp:HiddenField ID="ReturnValue" runat="server" />
	    </form>
	</body>
	</html>