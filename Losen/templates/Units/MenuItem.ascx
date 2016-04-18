<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="MenuItem.ascx.cs" Inherits="development.UserControls.MenuItem" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<tr XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<td>
		<table cellpadding="0" bgcolor='<%#BgColor%>' cellspacing="0" border="0" width="100%">
			<tr>
				<td width="1" bgcolor="#cccccc"></td>
				<td height="18" valign="top" width="10">
					<nobr>
						<img alt="" src="~/images/os.gif" width='<%#Indent%>' height="5" runat="server" ID="Img3">
						<asp:Image Visible=<%#HasChildren%> ImageUrl="~/images/arrow_closed.gif" Width="3" Height="5" Runat="server"/>
						<asp:Image Visible=<%#!HasChildren%> ImageUrl="~/images/os.gif" Width="3" Height="5" Runat="server"/>
						<img alt="" src="~/images/os.gif" width="1" height="5" runat="server" ID="Img5">														
					</nobr>
				</td>
				<td>
					<episerver:property CssClass="MenuText" PropertyName="PageLink" runat="server" ID="Property1"/>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td width="100%" height="1" bgcolor="#CCCCCC"></td>
</tr>
