<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FlashBody.ascx.cs" Inherits="development.UserControls.FlashBody" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td align="center">
			<object 
				classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
				codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" 
				width='<%#((EPiServer.PageBase)Page).CurrentPage["Width"]%>'
				height='<%#((EPiServer.PageBase)Page).CurrentPage["Height"]%>'
				VIEWASTEXT
			>
				<param name=movie value="<%#((EPiServer.PageBase)Page).CurrentPage["EmbeddedURL"]%>">
				<param name=quality value=high>
				<param NAME="wmode" VALUE="opaque">
				<embed 
					src="MES.swf"
					quality="high"
					pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
					type="application/x-shockwave-flash"
					width='<%#((EPiServer.PageBase)Page).CurrentPage["Width"]%>'
					height='<%#((EPiServer.PageBase)Page).CurrentPage["Height"]%>'>
				</embed> 
			</object>
		</td>
	</tr>
</table>
