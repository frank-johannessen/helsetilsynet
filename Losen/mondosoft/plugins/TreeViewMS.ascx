<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="TreeViewMS.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.TreeViewMS" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<style>
.searchrank {
	margin-right:4px;
	margin-top:3px;
	float:left;
	height:100%;
}
.searchresult {
	FONT-SIZE: 11px;
	FONT-FAMILY: tahoma;
	margin-bottom:3px;
	height:100%;
}
.desc {
	FONT-WEIGHT: normal; FONT-SIZE: 10px; PADDING-BOTTOM: 4px; WIDTH: 85%
}
.cat {
	PADDING-RIGHT: 5px; PADDING-LEFT: 5px; FONT-SIZE: 14px; BACKGROUND: #e0e0e0; PADDING-BOTTOM: 5px; WIDTH: 100%; PADDING-TOP: 5px; HEIGHT: 20px
}
</style>


<div style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; MARGIN: 0px; PADDING-TOP: 5px"><episerver:translate Text="/mondosoft/plugins/treeviewms/searchingress" runat="server" ></episerver:Translate>
</div>
<div style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; MARGIN: 0px; PADDING-TOP: 5px"><asp:textbox id="SearchString" runat="server"></asp:textbox> <asp:button id="SubmitButton" onclick="Search_Click" runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/treeviewms/searchbuttontext")%>'></asp:button><%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%><br>
	<hr>
</div>
<asp:Repeater id="SearchList" runat="server">
	<ItemTemplate>
		<div>
			<div class="searchrank"><img src="/mondosoft/images/<%#RankImage(Container.DataItem)%>" /></div>
			<div class="searchresult"><a onclick="javascript:LoadPageToEdit('<%#((EPiServer.Core.PageReference)DataBinder.Eval(Container.DataItem, "EPiServerPageLink")).ID%>');" href="#"  title='<%#DataBinder.Eval(Container.DataItem, "Description")%>'><%#DataBinder.Eval(Container.DataItem, "Title")%> (<%#DataBinder.Eval(Container.DataItem, "SizeAsString")%>)</a></div>
		</div>
	</ItemTemplate>
</asp:Repeater>
<asp:Literal ID="Message" Runat="server" />
<script>
		
		function LoadPageToEdit(pageLink)
		{
			window.parent.navigateEvent(window, pageLink);
			return;
		}
		
		function placeCursorAtEnd(el) 
		{
			if(el != null)
				{
				var len = el.value.length;
				if (el.setSelectionRange) 
				{
					el.setSelectionRange(len, len);
				}
				else if (el.createTextRange) 
				{
						var range = el.createTextRange();
						range.collapse(true);
						range.moveEnd('character', len);
						range.moveStart('character', len);
						range.select();
				}
			}
		}

		<!-- Handling of the Return key -->		

		var searchButton = document.getElementById('<%=SubmitButton.ClientID%>');

		function handleKeyPressed(e)
		{
			if(event.keyCode == 13 && event.srcElement.type != 'submit')
			{
				searchButton.click();
				return false;
			}
			return true;
		}

		if(document.body.onkeydown == null) // Do not intefere with other functions
		    document.body.onkeydown = handleKeyPressed;
		

		<!-- We need to call this FocusScript after the actual control has been created-->
		
		var searchStringElement = document.getElementById('<%=SearchString.ClientID%>');
		searchStringElement.focus();
		placeCursorAtEnd(searchStringElement);	
		
</script>
