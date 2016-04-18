<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="MoveTopicControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.MoveTopicControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script src="Administration.js"></script>
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.MoveTopic.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderMoveTopic" Runat="server">
	<script language="javascript">
		//document.onload = setTimeout('renderTree();', 200);
		
		var cookieName = 'SCForumTreeExpandedNodes';
		var arrNodesToExpand;
		var selectedNode;
		
		function renderTree()
		{
			var nodes = getCookie(cookieName);
			
			if(nodes != null)
			{
				window.status = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.MoveTopic.LoadingTree") %>...';
				arrNodesToExpand = nodes.split(',');
				arrNodesToExpand.sort();
				setTimeout('expandNodeIndex(0, arrNodesToExpand)', 800);
			}
		}
		
		function expandNodeIndex(index, arrNodesToExpand)
		{
			if(index < arrNodesToExpand.length)
			{
				var nodeId = arrNodesToExpand[index].substring(arrNodesToExpand[index].indexOf('_') + 1);
				var node = <% = treeViewForum.ClientID %>.FindNodeById(nodeId);
				
				if(node != null && node.ContentCallbackUrl != null && node.ContentCallbackUrl != '')
				{
					while(<% = treeViewForum.ClientID %>.FindNodeById(nodeId).ChildIndices.length = 0)
					{
					
					}
					
					flipNode(node);
				}
				
				setTimeout('expandNodeIndex('+(index+1)+', arrNodesToExpand)', 800);
			}
			else
				window.status = '';
		}
		
		function flipNode(node)
		{
			if(node != null && node.ContentCallbackUrl != null && node.ContentCallbackUrl != '')
				ComponentArt_ExpandCollapse(node.StorageIndex, node.ParentTreeView.TreeViewID,'');
		}
		
		function nodeSelect(node)
		{
			var roomId = node.ID.substring(node.ID.indexOf('_') + 1);
			document.getElementById('<% = hiddenRoomId.ClientID %>').value = roomId;
		}
		
		function nodeCollapse(node)
		{
			removeExpandedNode(node);
			return true;
		}
		
		function nodeExpand(node)
		{
			setExpandedNode(node);
			return true;
		}
		
		function setExpandedNode(node)
		{
			var nodeId = node.CalculateDepth() + '_' +node.ID;
			setExpandedNodeId(nodeId);
		}
		
		function setExpandedNodeId(nodeId)
		{
			var val = getCookie(cookieName);

			if(val == null)
				val = nodeId;
			else if(val.indexOf(nodeId) < 0)
				val += ',' + nodeId
			
			setCookie(cookieName, val);
		}
		
		function removeExpandedNode(node)
		{
			var val = getCookie(cookieName);
			
			if(val != null)
			{
				arrNodes = val.split(',');
				
				var newVal = '';
				var nodeId = node.CalculateDepth() + '_' +node.ID;
				for(var n = 0; n < arrNodes.length; n++)
				{
					if(arrNodes[n] == nodeId)
						continue;
					else
					{
						newVal += arrNodes[n] + ',';
					}
				}
				
				if(newVal == '')
					setCookie(cookieName, newVal);
				else
				{
					newVal = newVal.substring(0, newVal.length - 1);
					setCookie(cookieName, newVal);
				}
			}
		}
		
		function setCookie(name, value)
		{
			document.cookie = name + '=' + escape(value);
		}
		
		function getCookie(name)
		{
			var dc = document.cookie;
			var prefix = name + '=';
			var begin = dc.indexOf('; ' + prefix);
			if (begin == -1)
			{
				begin = dc.indexOf(prefix);
				if (begin != 0) return null;
			}
			else
			{
				begin += 2;
			}
			var end = document.cookie.indexOf(';', begin);
			if (end == -1)
			{
				end = dc.length;
			}
			return unescape(dc.substring(begin + prefix.length, end));
		}
		
		function deleteCookie(name)
		{
			if (getCookie(name))
			{
				document.cookie = name +
					"; expires=Thu, 01-Jan-70 00:00:01 GMT";
			}
		}
	</script>
	<input type="hidden" id="hiddenRoomId" runat="server" />
	<asp:CustomValidator id="validatorRoom" Runat="server" Display="None" EnableClientScript="False" />
	<table class="epi-default" cellpadding="0" cellspacing="0" border="0">
		<tbody>
			<tr>
				<td colspan="2">
					<ComponentArt:TreeView id="treeViewForum" runat="server" Height="200" Width="100%"
						KeyboardEnabled="true"
						CssClass="TreeView" 
						NodeCssClass="TreeNode" 
						SelectedNodeCssClass="SelectedTreeNode" 
						HoverNodeCssClass="HoverTreeNode"
						NodeEditCssClass="NodeEdit"
						LineImageWidth="19" 
						LineImageHeight="20"
						DefaultImageWidth="16" 
						DefaultImageHeight="16"
						NodeLabelPadding="3"
						ShowLines="false"
						EnableViewState="true"
						ClientSideOnNodeSelect="nodeSelect" 
						ClientSideOnNodeExpand="nodeExpand"
						ClientSideOnNodeCollapse="nodeCollapse"
						DragAndDropEnabled="false"
						NodeEditingEnabled="false"
						ExpandNodeOnSelect="false"
						CollapseNodeOnSelect="false"
						LineImagesFolderUrl="images/tree/lines"
						CollapseImageUrl="images/tree/exp.gif" 
						ExpandImageUrl="images/tree/col.gif" 
						AutoScroll="True">
					</ComponentArt:TreeView>
				</td>
			</tr>
			<asp:PlaceHolder ID="placeHolderTrace" Runat="server">
				<tr>
					<td colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.MoveTopic.ExplainingText") %>.</td>
				</tr>
				<tr>
					<td width="100"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.MoveTopic.inputSubject") %>:</td>
					<td><asp:TextBox ID="textBoxSubject" Runat="server" CssClass="input" Width="400" /><asp:RequiredFieldValidator id="validatorSubject" Runat="server" ControlToValidate="textBoxSubject" Display="None" EnableClientScript="False" /></td>
				</tr>
				<tr>
					<td width="100" valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.MoveTopic.inputText") %>:</td>
					<td><asp:TextBox ID="textBoxTrace" Runat="server" CssClass="input" TextMode="MultiLine" Width="400" Height="100" /><asp:RequiredFieldValidator id="validatorTrace" Runat="server" ControlToValidate="textBoxTrace" Display="None" EnableClientScript="False" /></td>
				</tr>
			</asp:PlaceHolder>
			<tr>
				<td colspan="2" align="right"><asp:Button ID="buttonMoveTopic" Runat="server" CssClass="button" OnClick="ButtonMoveTopic_Click" /></td>
			</tr>
		</tbody>
	</table>
	<style> 
		.TreeView { background-color:White; padding-top:4px; padding-bottom:4px; padding-left:1px; cursor:default; }
		.TreeView td { padding: 0px 0px 0px 3px !important; height: 16px !important; border: 0px !important; }
		.TreeNode { font-family: tahoma; font-size: 11px; border: solid 1px white; padding: 3px; }
		.GrayedTreeNode { font-family: tahoma; font-size: 11px; border: solid 1px white; padding: 3px; color:gray; cursor:default; }
		.HoverTreeNode { background-image: url(<% = Page.ResolveUrl("images/tree/node_bg.gif") %>); font-family: tahoma; font-size: 11px; border: solid 1px #D5DFEA; border-bottom-color:#A0B0C0; border-right-color:#A0B0C0; padding: 3px; cursor: default; }
		.SelectedTreeNode { background-image: url(<% = Page.ResolveUrl("images/tree/node_bg.gif") %>); font-family: tahoma; font-size: 11px; border: solid 1px #A0B0C0; border-bottom-color:#D5DFEA; border-right-color:#D5DFEA; padding: 3px; cursor: default; }
		.NodeEdit { border:1px gray solid; font-family: tahoma; font-size: 11px; }
	</style>
</asp:PlaceHolder>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
			if(window.opener)
			    window.opener.__doPostBack('<% = TopicControlId %>', '<% = EPiServer.Community.Web.Administration.TopicControl.POSTBACK_BACK_ARGUMENT %>');
			window.close();
		}
	</script>
</asp:PlaceHolder>