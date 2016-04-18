<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" AutoEventWireup="false" Codebehind="EmailPage.aspx.cs" Inherits="Avenir.Templates.Pages.EmailPage" %>
<%@ Register TagPrefix="ht" TagName="MainBody" Src="~/Templates/Avenir/Units/Placeable/MainBody.ascx" %>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CenterArea" runat="server">
<ht:MainBody runat="server" />
<br />
			<table>
				<tr>
					<td>
						Fra (e-post)
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" Width="300px" ID="From"  />
						<asp:RequiredFieldValidator ControlToValidate="From" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						Emne
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" Width="300px"  ID="Subject" />
						<asp:RequiredFieldValidator ControlToValidate="Subject" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						Melding
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" ID="Other" Rows="15" Width="500px" TextMode="MultiLine" />
						<asp:RequiredFieldValidator ControlToValidate="Other" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr></tr>
				<tr>
					<td align=center>
						<asp:Button Runat="server" OnClick="SendEmailButton_Click" ID="SendEmailButton" Text="Send e-post" />
					</td>
				</tr>
			</table>
			<br/><br/>
			
</asp:Content>