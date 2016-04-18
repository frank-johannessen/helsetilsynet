<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CategoryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CategoryControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script src="Administration.js"></script>
<script src="js/starsuite.js"></script>
<script language="javascript">
	EPiServerCommonAddLoadEvent(resizeDocument);
	EPiServerCommonAddResizeEvent(resizeDocument);

	var cookieName = 'SCCategoryTreeExpandedNodes';
	var arrNodesToExpand;
	var selectedNode;
	
	function nodeSelect(node)
	{
		selectedNode = node;
		if(node.CalculateDepth() > 0)
		{
			var title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.EditCategory") %>: ';
			document.getElementById('categoryFrameTitle').innerHTML = title + node.Text;
		}
	}

	function nodeCollapse(node) {
	    removeExpandedNode(node);
	    return true;
	}

	function nodeExpand(node) {
	    setExpandedNode(node);
	    return true;
	}
	
	function nodeRename(node, newLabel)
	{
		var nodeId = node.ID.substring(node.ID.indexOf('_') + 1);
		if(node.Text != newLabel)
		{
			if(node.ID.indexOf('category_') > -1) 
			{
				// rename category
				executeCategoryCommand('<% = this.ResolveUrl("ExecuteCategoryTreeCommand.aspx") %>?command=rename&categoryId=' + nodeId + '&newLabel=' + newLabel, processReqChange);
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

		var nodeId = node.ID.substring(node.ID.indexOf('_') + 1);
		var parentId = newParent.ID.substring(newParent.ID.indexOf('_') + 1);
		
		if(node.ID.indexOf('category_') > -1) 
		{
		    if (newParent.ID.indexOf('category_') > -1) {
		        // move category to a new parent category
		        executeCategoryCommand('<% = this.ResolveUrl("ExecuteCategoryTreeCommand.aspx") %>?command=move&categoryId=' + nodeId + '&parentCategoryId=' + parentId, processReqChange);
		    }
		    else
		        return false;
			
		}
		else
			return false;
		
		if(newParent.ChildIndices.length > 0 || newParent.ContentCallbackUrl == null || newParent.ContentCallbackUrl == '')
			return true;
		
		//Remove old node.
		node.Remove();
		
		return false;
	}

	var dropedNode;
	var dropParent;
	function finalizeDrop() {
	    dropedNode.Remove();
	    flipNode(dropParent);
	}

	function setExpandedNode(node) {
	    var nodeId = node.CalculateDepth() + '_' + node.ID;
	    setExpandedNodeId(nodeId);
	}

	function setExpandedNodeId(nodeId) {
	    var val = getCookie(cookieName);

	    if (val == null)
	        val = nodeId;
	    else if (val.indexOf(nodeId) < 0)
	        val += ',' + nodeId

	    setCookie(cookieName, val);
	}

	function removeExpandedNode(node) {
	    var val = getCookie(cookieName);

	    if (val != null) {
	        arrNodes = val.split(',');

	        var newVal = '';
	        var nodeId = node.CalculateDepth() + '_' + node.ID;
	        for (var n = 0; n < arrNodes.length; n++) {
	            if (arrNodes[n] == nodeId)
	                continue;
	            else {
	                newVal += arrNodes[n] + ',';
	            }
	        }

	        if (newVal == '')
	            setCookie(cookieName, newVal);
	        else {
	            newVal = newVal.substring(0, newVal.length - 1);
	            setCookie(cookieName, newVal);
	        }
	    }
	}

	function setCookie(name, value) {
	    document.cookie = name + '=' + escape(value);
	}

	function getCookie(name) {
	    var dc = document.cookie;
	    var prefix = name + '=';
	    var begin = dc.indexOf('; ' + prefix);
	    if (begin == -1) {
	        begin = dc.indexOf(prefix);
	        if (begin != 0) return null;
	    }
	    else {
	        begin += 2;
	    }
	    var end = document.cookie.indexOf(';', begin);
	    if (end == -1) {
	        end = dc.length;
	    }
	    return unescape(dc.substring(begin + prefix.length, end));
	}

	function deleteCookie(name) {
	    if (getCookie(name)) {
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

		if (myWidth > 60 && document.getElementById('mainAdminTable')) {
		    document.getElementById('mainAdminTable').style.width = (myWidth - 60) + 'px';
		}
		if (myHeight > 180) {
		    if (document.getElementById('mainAdminTable')) {
		        document.getElementById('mainAdminTable').style.height = (myHeight - 130) + 'px';
		    }
		    if (document.getElementById('categoryFrame')) {
		        document.getElementById('categoryFrame').style.height = (myHeight - 130) + 'px';
		    }
		    if (document.getElementById('<% = treeViewCategory.ClientID %>')) {
		        document.getElementById('<% = treeViewCategory.ClientID %>').style.height = (myHeight - 180) + 'px';
		    }
		}
	}
	
    function executeCategoryCommand(url, processReqChange_Callback) {
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
    
    function MenuNew(t)
    {
        if (selectedNode && t == 'category' && selectedNode.ID.indexOf('category_') > -1) {
            var nodeId = selectedNode.ID.substring(selectedNode.ID.indexOf('_') + 1);
            document.getElementById('categoryFrameTitle').innerHTML = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.NewChildCategory") %>';
            window.open('<% = this.ResolveUrl("CategoryFrameWrapper.aspx") %>?task=new&parentId=' + nodeId, 'categoryFrame');
        }
        else {

            document.getElementById('categoryFrameTitle').innerHTML = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.NewCategory") %>';
            window.open('<% = this.ResolveUrl("CategoryFrameWrapper.aspx") %>?task=new', 'categoryFrame');            
        }
    }
</script>

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.Categories")%></h1>
<table class="epi-default" id="mainAdminTable" cellpadding="0" cellspacing="0" height="100%">
    <tr>
        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.HeaderCategoryTree") %></th>
        <th id="categoryFrameTitle"></th>
    </tr>
	<tr>
		<td class="menu">
			<asp:Button ID="buttonNewCategory" CssClass="button" OnClientClick="MenuNew('category'); return false;" runat="server" />
			<asp:Button ID="buttonRefresh" Runat="server" CssClass="button" onclick="buttonRefresh_Click" />
			<ComponentArt:TreeView id="treeViewCategory" runat="server" Height="360" Width="250"
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
				ClientSideOnNodeRename="nodeRename"
				ClientSideOnNodeMove="nodeMove"
				DragAndDropEnabled="false"
				NodeEditingEnabled="false"
				ExpandNodeOnSelect="false"
				CollapseNodeOnSelect="false"
				LineImagesFolderUrl="images/tree/lines"
				CollapseImageUrl="images/tree/exp.gif" 
				ExpandImageUrl="images/tree/col.gif" 
				AutoScroll="True"
				>
			</ComponentArt:TreeView>
		</td>
		<td style="vertical-align: top;">
			<iframe name="categoryFrame" id="categoryFrame" width="100%" frameborder="0" scrolling="auto"></iframe>
		</td>
	</tr>
</table>
