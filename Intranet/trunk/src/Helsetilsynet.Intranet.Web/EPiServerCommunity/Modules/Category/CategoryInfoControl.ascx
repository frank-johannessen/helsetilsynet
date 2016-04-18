<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CategoryInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CategoryInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<div id="category">
<asp:Panel ID="panelEditCategory" Runat="server">
	<div id="tabStrip">
		<input type="hidden" runat="server" id="hiddenCategoryId" name="hiddenCategoryId"/>
		<ComponentArt:TabStrip id="tabStripCategory" 
			CssClass="topGroup"
			DefaultItemLookId="DefaultTabLook"
			DefaultSelectedItemLookId="SelectedTabLook"
			DefaultDisabledItemLookId="DisabledTabLook"
			DefaultGroupTabSpacing="0"
			ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
			MultiPageId="multiPageCategory"
			runat="server">
			<ItemLooks>
				<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="DefaultTab" HoverCssClass="DefaultTabHover" />
				<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="SelectedTab" />
			</ItemLooks>
			<Tabs>
				<ComponentArt:TabStripTab Runat="server" ID="tabStripTabCategoryDetails"></ComponentArt:TabStripTab>
			</Tabs>
		</ComponentArt:TabStrip>
		<ComponentArt:MultiPage id="multiPageCategory" CssClass="MultiPage" runat="server">
			<ComponentArt:PageView  runat="server" ID="pageViewContent">
				<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
					<tr>
						<td width="100">
							<asp:Label ID="labelName" Runat="server"></asp:Label>
						</td>
						<td>
							<asp:TextBox ID="textBoxName" Runat="server" CssClass="input" Width="300"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="validatorName" runat="server" ControlToValidate="textBoxName" EnableClientScript="False" Display="None" /><asp:CustomValidator runat="server" id="validatorName2" ControlToValidate="textBoxName" OnServerValidate="ValidateCategoryName" Display="None" />

						</td>
					</tr>
					<tr>
						<td align="right" colspan="2">
							<asp:Button id="buttonSave" Runat="server" CssClass="button" onclick="buttonSave_Click"></asp:Button>&nbsp;
							<span onclick="javascript: if (<%= CategoryChildCount %> > 0) { alert('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.errorRemoveCategory") %>.'); return false; } else { return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Category.confirmRemoveCategory") %>'); }">
								<asp:Button id="buttonRemoveCategory" Runat="server" CssClass="button" onclick="buttonRemove_Click"></asp:Button>&nbsp;
							</span>
						</td>
					</tr>
				</table>
			</ComponentArt:PageView>
		</ComponentArt:MultiPage>
	</div>
</asp:Panel>
</div>
