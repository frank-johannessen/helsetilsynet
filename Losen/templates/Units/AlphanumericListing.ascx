<%@ Control Language="c#" AutoEventWireup="false" Codebehind="AlphanumericListing.ascx.cs" Inherits="development.templates.UserControls.AlphanumericListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table border="0" height="90%" cellpadding="0" cellspacing="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td>					
			<table width="440">
				<tr>
					<td class="title">
						[ <asp:LinkButton ID="Alphanumeric1" Runat="server" OnClick="ChangeLetters">a - f</asp:LinkButton> ]&nbsp;
						[ <asp:LinkButton ID="Alphanumeric2" Runat="server" OnClick="ChangeLetters">g - l</asp:LinkButton> ]&nbsp;
						[ <asp:LinkButton ID="Alphanumeric3" Runat="server" OnClick="ChangeLetters">m - r</asp:LinkButton> ]&nbsp;
						[ <asp:LinkButton ID="Alphanumeric4" Runat="server" OnClick="ChangeLetters">s - x</asp:LinkButton> ]&nbsp;
						[ <asp:LinkButton ID="Alphanumeric5" Runat="server" OnClick="ChangeLetters">y - å</asp:LinkButton> ]
						<br><br>
					</td>
				</tr>
			
			<episerver:PropertySearch PageLink=<%#EPiServer.Global.EPConfig.StartPage%> runat="server" ID="PropertySearchControl">
			</episerver:PropertySearch>
			
			<episerver:PageList DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
				<ItemTemplate>
					<%#FilterName(Container.CurrentPage.LinkURL,Container.CurrentPage["keyword"].ToString())%>
				</ItemTemplate>
			</episerver:PageList>
			
			
			<%#GetKeywords()%>
			
			</table>
			
		</td>
	</tr>
</table>