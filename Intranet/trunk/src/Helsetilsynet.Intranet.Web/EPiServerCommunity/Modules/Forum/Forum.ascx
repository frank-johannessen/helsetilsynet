<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="Forum.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Forum"
    TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css">

<script src="Administration.js"></script>

<script src="js/starsuite.js"></script>

<script language="javascript">
	EPiServerCommonAddLoadEvent(resizeDocument);
	EPiServerCommonAddResizeEvent(resizeDocument);

	var cookieName = 'SCForumTreeExpandedNodes';
	var arrNodesToExpand;
	var selectedNode;
	
	function renderTree()
	{
		var nodes = getCookie(cookieName);
		
		if(nodes != null)
		{
			window.status = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.LoadingTree") %>...';
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
		selectedNode = node;
		if(node.CalculateDepth() > 0)
		{
			var title = (node.CalculateDepth() == 1 ? '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.EditForum") %>: ' : '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.EditRoom") %>: ');
			document.getElementById('forumFrameTitle').innerHTML = title + node.Text;
		}
		else if(node.ID == 'iconnode')
			document.getElementById('forumFrameTitle').innerHTML = '';
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
	
	function nodeRename(node, newLabel)
	{
		var nodeId = node.ID.substring(node.ID.indexOf('_') + 1);
		if(node.Text != newLabel)
		{
			if(node.ID.indexOf('forum_') > -1) // rename forum
			{
				executeForumCommand('<% = String.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Authority) %><% = this.ResolveUrl("ExecuteForumTreeCommand.aspx") %>?command=rename&forumId=' + nodeId + '&newLabel=' + encodeURIComponent(newLabel), processReqChange);
			}
			else if(node.ID.indexOf('room_') > -1) // rename room
			{
				executeForumCommand('<% = String.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Authority) %><% = this.ResolveUrl("ExecuteForumTreeCommand.aspx") %>?command=rename&roomId=' + nodeId + '&newLabel=' + encodeURIComponent(newLabel), processReqChange)
			}
			else
				return false;
		}
		
		return true;
	}
	
	function nodeMove(node, newParent, newIndex, treeView)
	{
		var oldDepth = node.CalculateDepth();
		var newDepth = newParent.CalculateDepth() + 1;
		
		removeExpandedNode(node);
		
		if(node.Expanded)
			setExpandedNodeId(newDepth + '_' + node.ID);

		var nodeId;
		if(node.ID.indexOf('_') > -1)
		    nodeId = node.ID.substring(node.ID.indexOf('_') + 1);
		var parentId;
		if(newParent.ID.indexOf('_') > -1)
		    parentId = newParent.ID.substring(newParent.ID.indexOf('_') + 1);

        if(node.ID.indexOf('room_') > -1 && newParent.ID.indexOf('forum_') > -1) // move room to new forum
		{
			executeForumCommand('<% = String.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Authority) %><% = this.ResolveUrl("ExecuteForumTreeCommand.aspx") %>?command=move&roomId=' + nodeId + '&forumId=' + parentId, processReqChange)
		}
		else if(node.ID.indexOf('room_') > -1 && newParent.ID.indexOf('room_') > -1) // move room to a new parent room
		{
			executeForumCommand('<% = String.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Authority) %><% = this.ResolveUrl("ExecuteForumTreeCommand.aspx") %>?command=move&roomId=' + nodeId + '&parentRoomId=' + parentId, processReqChange);
		}
		else
			return false;
		
		if(newParent.ChildIndices.length > 0 || newParent.ContentCallbackUrl == null || newParent.ContentCallbackUrl == '')
			return true;
			
		// workaround to get load on demand to run when dropping on a not yet loaded node
		flipNode(newParent);
		node.Remove();
		return false;
	}
	
	var dropedNode;
	var dropParent;
	function finalizeDrop()
	{		
		dropedNode.Remove();
		flipNode(dropParent);
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
	
	
	function resizeDocument() {
		var myWidth = 0, myHeight = 0;
		if( typeof( window.innerWidth ) == 'number' ) {
			//Non-IE
			myWidth = window.innerWidth;
			myHeight = window.innerHeight;
		} else if( document.documentElement &&
			( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
			//IE 6+ in 'standards compliant mode'
			myWidth = document.documentElement.clientWidth;
			myHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
			//IE 4 compatible
			myWidth = document.body.clientWidth;
			myHeight = document.body.clientHeight;
		}

        if (myWidth > 40)
        {
		    document.getElementById('mainAdminTable').style.width = (myWidth - 40) + 'px';
		}
		if (myHeight > 200)
		{
		    document.getElementById('mainAdminTable').style.height = (myHeight - 180) + 'px';
    		document.getElementById('forumFrame').style.height = (myHeight - 180) + 'px';
	    	document.getElementById('<% = treeViewForum.ClientID %>').style.height = (myHeight - 200) + 'px';		    
		}		
	}
	
	
    function executeForumCommand(url, processReqChange_Callback) {
        req = false; 

        // branch for native XMLHttpRequest object
        if(window.XMLHttpRequest) {

        try {
			req = new XMLHttpRequest();
        } catch(e) {
			req = false;
        }

        // branch for IE/Windows ActiveX version
        } else if(window.ActiveXObject) {
			try {
				req = new ActiveXObject("Msxml2.XMLHTTP");
			} catch(e) {
				try {
					req = new ActiveXObject("Microsoft.XMLHTTP");
				} catch(e) {
					req = false;
				}
            }
        }

        if(req) {
            req.onreadystatechange = processReqChange_Callback;
            req.open("GET", url, true);
            req.send("");
        }
    }

    function processReqChange() {
        // only if req shows "loaded".
        if (req.readyState == 4) {
			if (req.status == 200) {
				window.status = 'Successfully Executed Command';
			} else {
				alert("There was a problem executing the command:\n" + req.statusText);
			}
        }
    }
    
    function CreateNewRoom()
    {
        if (!selectedNode)
        {
            alert('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.errorMustSelectNode") %>.');
            return;
        }
                
        document.getElementById('forumFrameTitle').innerHTML = 'New Room';
        var url = '<% = this.ResolveUrl("ForumFrameWrapper.aspx") %>?task=new&type=room&'
        if (selectedNode.ID.indexOf('forum_') > -1)
        {
            url += 'forumId=';
        }
        else
        {
            url += 'roomId=';
        }
        url += selectedNode.ID.substring(selectedNode.ID.indexOf('_') + 1);
        window.open(url, 'forumFrame');
    }
    
    function CreateNewForum()
    {
        document.getElementById('forumFrameTitle').innerHTML = 'New Forum';
		window.open('<% = this.ResolveUrl("ForumFrameWrapper.aspx") %>?task=new&type=forum', 'forumFrame');
    }
</script>

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.forum")%></h1>


         

     
<table class="epi-default" id="mainAdminTable" cellpadding="0" cellspacing="0" height="100%">
    <tr>
        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.Forum") %> </th>
        <th>
            <div id="forumFrameTitle">&nbsp;</div>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <button id="buttonNewForum" class="button" onclick="CreateNewForum(); return false;" runat="server">
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.buttonNewForum") %></button>&nbsp;
            <button id="buttonNewRoom" class="button" onclick="CreateNewRoom(); return false;" runat="server">
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.buttonNewRoom") %></button>&nbsp;
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Forum.ForumTree") %></th>
        <th>&nbsp;</th>
   </tr>
   <tr>
        <td class="menu">
            <asp:Button ID="buttonRefresh" runat="server" CssClass="button" Width="120" />
            <ComponentArt:TreeView ID="treeViewForum" runat="server" Height="360" Width="210" KeyboardEnabled="true" CssClass="TreeView"
                NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode" NodeEditCssClass="NodeEdit"
                LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" NodeLabelPadding="3" ShowLines="false"
                EnableViewState="true" ClientSideOnNodeSelect="nodeSelect" ClientSideOnNodeExpand="nodeExpand" ClientSideOnNodeCollapse="nodeCollapse"
                ClientSideOnNodeRename="nodeRename" ClientSideOnNodeMove="nodeMove" DragAndDropEnabled="false" NodeEditingEnabled="false"
                ExpandNodeOnSelect="false" CollapseNodeOnSelect="false" LineImagesFolderUrl="images/tree/lines" CollapseImageUrl="images/tree/exp.gif"
                ExpandImageUrl="images/tree/col.gif" AutoScroll="True">
            </ComponentArt:TreeView>
        </td>
        <td valign="top">
            <iframe name="forumFrame" id="forumFrame" height="96.5%" width="100%" frameborder="0" scrolling="auto" />
        </td>
    </tr>
</table>
