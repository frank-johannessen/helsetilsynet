<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SelectForumRoomControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SelectForumRoomControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<!--<link rel="stylesheet" type="text/css" href="Administration.css" >-->
<script src="Administration.js"></script>
<script language="javascript">
<!--
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.SelectForumRoom.Title") %>'
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderSelectForumRoom" Runat="server">
	<script language="javascript">
	<!--
		function nodeSelect(node)
		{
			var roomId = node.ID.substring(node.ID.indexOf('_') + 1);
			document.getElementById('<% = hiddenRoomId.ClientID %>').value = roomId;
		}
	//-->	
	</script>
	<input type="hidden" id="hiddenRoomId" runat="server" name="hiddenRoomId"/>
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
			<tr>
				<td colspan="2" align="right">
					<asp:Button ID="buttonSelectForumRoom" Runat="server" CssClass="button" OnClick="ButtonSelectForumRoom_Click" />
				</td>
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