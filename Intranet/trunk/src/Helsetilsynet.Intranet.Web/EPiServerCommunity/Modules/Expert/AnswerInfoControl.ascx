<%@ Control Language="c#" AutoEventWireup="True" Codebehind="AnswerInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AnswerInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>" />

<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.Answer.Title") %>'
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<div id="tabStrip">
<ComponentArt:TabStrip id="tabStripAnswerInfo" 
		CssClass="topGroup"
		DefaultItemLookId="DefaultTabLook"
		DefaultSelectedItemLookId="SelectedTabLook"
		DefaultDisabledItemLookId="DisabledTabLook"
		DefaultGroupTabSpacing="1"
		ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		MultiPageId="multiPageAnswerInfo"
		runat="server">
		<ItemLooks>
			<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
		</ItemLooks>
		<Tabs>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabAnswerDetails"></ComponentArt:TabStripTab>
		</Tabs>
		</ComponentArt:TabStrip>
		<ComponentArt:MultiPage id="multiPageAnswerInfo" CssClass="multiPage" runat="server">

			<ComponentArt:PageView runat="server" ID="pageViewEditAnswerInfo">
			
				<asp:Panel ID="panelValidators" Runat="server" Visible="False">
				
				</asp:Panel>
							
				<table class="epi-default" cellSpacing="0" cellPadding="0">
					<tr>
						<td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.Answer.inputStatus") %>:</td>
						<td vAlign="top">
							<asp:RadioButtonList id="radioButtonListStatus" Runat="server" RepeatLayout="Flow" CellSpacing="0"
								CellPadding="0" RepeatDirection="Vertical">
								<asp:ListItem Value="notApproved"></asp:ListItem>
								<asp:ListItem Value="approved" Selected="True"></asp:ListItem>
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr>
						<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.Answer.inputHeader") %>:</td>
						<td>
							<asp:TextBox id="textBoxHeader" Runat="server" MaxLength="100" CssClass="input"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.Answer.inputBody") %>:</td>
						<td vAlign="top">
							<asp:TextBox id="textBoxBody" Runat="server" CssClass="input" 
								TextMode="MultiLine" Height="80" Width="400"></asp:TextBox><br>
						</td>
					</tr>
					<tr>
						<td align="right" colSpan="2">
							<asp:Button id="buttonSave" Runat="server" CssClass="button" onclick="buttonSave_Click"></asp:Button>&nbsp;
						</td>
					</tr>
				</table>
							
			</ComponentArt:PageView>
			
	</ComponentArt:MultiPage>
	
	<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
		<script language="javascript">
			setTimeout('CloseWindow()', 1000);
			
			function CloseWindow()
			{
				if(window.opener)
				    window.opener.__doPostBack('<% = QuestionListControlId %>', '<% = EPiServer.Community.Web.Administration.QuestionListControl.POSTBACK_REFRESH_ARGUMENT %>');
				window.close();
			}
		</script>
	</asp:PlaceHolder>

</div>
