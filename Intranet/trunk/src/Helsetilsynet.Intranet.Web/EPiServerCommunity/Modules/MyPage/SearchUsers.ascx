<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SearchUsers.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SearchUsers" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="UserAttributeListControl" Src="~/EPiServerCommunity/Modules/MyPage/UserAttributeListControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="ImageListControl" Src="../ImageGallery/ImageListControl.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" src="Administration.js"></script>
<SCRIPT language="javascript">

function CheckSelections()
{
	var i;
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf("checkBoxSelected") >= 0)
		{
			elem.checked = !elem.checked;
		}
	}	
}

</SCRIPT>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.mypage")%></h1>
<asp:CustomValidator ID="birthDateValidator" runat="server" OnServerValidate="ValidateBirthDate" Display="None" EnableClientScript="false"  ValidationGroup="FilterValidation"/>
<asp:CustomValidator ID="createDateValidator" runat="server" OnServerValidate="ValidateCreateDate" Display="None" EnableClientScript="false" ValidationGroup="FilterValidation" />
<div id="tabStrip">
		<ComponentArt:TabStrip id="tabStripUserManagement" 
		CssClass="topGroup"
		DefaultItemLookId="DefaultTabLook"
		DefaultSelectedItemLookId="SelectedTabLook"
		DefaultDisabledItemLookId="DisabledTabLook"
		DefaultGroupTabSpacing="0"
		ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		MultiPageId="multiPageSearchUsers"
		runat="server">
		<ItemLooks>
			<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			<ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
			<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
		</ItemLooks>
		<Tabs>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabSearch"></ComponentArt:TabStripTab>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabPortrait"></ComponentArt:TabStripTab>
		</Tabs>
		</ComponentArt:TabStrip>
		<ComponentArt:MultiPage id="multiPageSearchUsers" CssClass="multiPage" runat="server">
			<ComponentArt:PageView  runat="server" ID="pageViewSearch">
				<ComponentArt:TabStrip id="tabStripSearch" 
					CssClass="subGroup"
					DefaultItemLookId="DefaultTabLook"
					DefaultSelectedItemLookId="SelectedTabLook"
					DefaultDisabledItemLookId="DisabledTabLook"
					DefaultGroupTabSpacing="0"
					ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
					MultiPageId="multiPageSimpleSearch"
					AutoPostBackOnSelect="True"
					runat="server">
					<ItemLooks>
						<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
						<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
					</ItemLooks>
					<Tabs>
						<ComponentArt:TabStripTab Runat="server" Value="simple" ID="tabStripTabSimpleSearch"></ComponentArt:TabStripTab>
						<ComponentArt:TabStripTab Runat="server" Value="advanced" ID="tabStripTabAdvancedSearch"></ComponentArt:TabStripTab>
					</Tabs>
					</ComponentArt:TabStrip>
					<ComponentArt:MultiPage id="multiPageSimpleSearch" CssClass="multiPage" runat="server">
						<ComponentArt:PageView  runat="server" ID="pageViewSearchUser">
						<asp:PlaceHolder ID="placeHolderSearch" Runat="server">
							<table class="epi-default" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputUserName") %>:</td>
									<td><asp:TextBox ID="textBoxUserName" Runat="server" CssClass="input" /></td>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputFirstName") %>:</td>
									<td><asp:TextBox ID="textBoxGivenName" Runat="server" CssClass="input" /></td>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputLastName") %>:</td>
									<td><asp:TextBox ID="textBoxSurName" Runat="server" CssClass="input" /></td>
								</tr>
								<tr>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputAlias") %>:</td>
									<td><asp:TextBox ID="textBoxAlias" runat="server" CssClass="input" /></td>									
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputEmail") %>:</td>
									<td><asp:TextBox ID="textBoxEmail" Runat="server" CssClass="input" /></td>									
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputInclude") %>:</td>
									<td><asp:DropDownList ID="dropDownListInclude" Runat="server"></asp:DropDownList></td>
								</tr>
								<asp:PlaceHolder ID="placeHolderAdvancedSearch" Runat="server" Visible="False">
								<tr>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputBirthDate") %>:</td>
									<td colspan="5">
										<asp:DropDownList ID="dropDownListBirthYearStart" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListBirthMonthStart" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListBirthDayStart" Runat="server" CssClass="input" />
										&nbsp;
										<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputBirthDate.And") %>
										&nbsp;
										<asp:DropDownList ID="dropDownListBirthYearEnd" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListBirthMonthEnd" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListBirthDayEnd" Runat="server" CssClass="input" />
									</td>
								</tr>
								<tr>
									<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputCreateDate") %>:</td>
									<td colspan="5">
										<asp:DropDownList ID="dropDownListCreateYearStart" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListCreateMonthStart" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListCreateDayStart" Runat="server" CssClass="input" />
										&nbsp;
										<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.inputCreateDate.And") %>
										&nbsp;
										<asp:DropDownList ID="dropDownListCreateYearEnd" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListCreateMonthEnd" Runat="server" CssClass="input" />
										-
										<asp:DropDownList ID="dropDownListCreateDayEnd" Runat="server" CssClass="input" />
									</td>
								</tr>
								
									<sc:UserAttributeListControl ID="userAttributeListControl" runat="server" />
								</asp:PlaceHolder>
								<tr>
								    <td>&nbsp;</td>
									<td colspan="5">
										<asp:RadioButtonList ID="searchMatchOptions" Runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
										</asp:RadioButtonList>
									</td>
								</tr>
								<tr>
									<td colspan="6" align="right"><asp:Button id="buttonSearch" Runat="server" CssClass="button" OnClick="ButtonSearch_Click" ValidationGroup="FilterValidation" /></td>
								</tr>
							</table>
							<asp:PlaceHolder ID="placeHolderSearchResult" Runat="server" Visible="False">
                                <br />
								<table cellpadding="0" cellspacing="0" width="100%" border="0" class="epi-default">
									<thead>
									    <tr>
										    <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.MenuHeader") %></th>
										    <th colspan="1"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.SearchResult") %> (<% = TotalHits %>)</th>
									    </tr>
									</thead>
									<tbody>
										<tr>
											<td class="menu">
												<asp:Panel ID="panelMenu" Runat="server">
													<asp:Button ID="buttonRemoveUsers" Runat="server" CssClass="button"></asp:Button><br />
													<asp:CheckBox ID="checkBoxRemovePermanent" Runat="server"></asp:CheckBox><br />
													<div class="section"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.SystemMessage") %></div>
													<input type="hidden" id="hiddenMessageBody" runat="server" value="" NAME="hiddenMessageBody">
													<input type="hidden" id="hiddenMessageSubject" runat="server" value="" NAME="hiddenMessageSubject">
													<asp:CustomValidator ID="validatorSystemMessage" Runat="server" Visible="False"></asp:CustomValidator>
													<button runat="server" id="buttonSendSystemMessageAll" onclick="SCDirectMessageOpenSystemMessageWindow('<% = POSTBACK_SYSTEM_MESSAGE_ALL_ARGUMENT %>', '<% = this.UniqueID %>', '<% = hiddenMessageSubject.ClientID %>', '<% = hiddenMessageBody.ClientID %>', 'all');" class="button"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.buttonSystemMessageSendAll") %></button><br />
													<button runat="server" id="buttonSendSystemMessageSelected" onclick="SCDirectMessageOpenSystemMessageWindow('<% = POSTBACK_SYSTEM_MESSAGE_SELECTED_ARGUMENT %>', '<% = this.UniqueID %>', '<% = hiddenMessageSubject.ClientID %>', '<% = hiddenMessageBody.ClientID %>', 'selected');" class="button"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.buttonSystemMessageSendToSelected") %></button>
													<asp:PlaceHolder ID="placeHolderSearchExtensions" runat="server" Visible="true"></asp:PlaceHolder>
												</asp:Panel>
											</td>
											<td class="epi-noPadding">
											    <table cellpadding="0" cellspacing="0" width="100%" border="0" class="epi-default" style="width:100%">
										            <thead>
										                <tr>
										                    <th align="left" class="icon">&nbsp;</th>
										                    <th align="left"><asp:LinkButton ID="linkButtonUserName" Runat="server"></asp:LinkButton></th>
										                    <th align="left"><asp:LinkButton ID="linkButtonFirstName" Runat="server"></asp:LinkButton></th>
										                    <th align="left"><asp:LinkButton ID="linkButtonLastName" Runat="server"></asp:LinkButton></th>
										                    <th align="left"><asp:LinkButton ID="linkButtonCreateDate" Runat="server"></asp:LinkButton></th>
										                    <th align="left"><asp:LinkButton ID="linkButtonStatus" Runat="server"></asp:LinkButton></th>
										                    <th align="left">&nbsp;</th>
										                </tr>
										            </thead>
										            <tbody>
										                <tr runat="server" id="rowPagingTop">
											                <td colspan="7"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
										                </tr>
										                <asp:DataList ID="dataListSearchResult" Runat="server" EnableViewState="True" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID" OnUpdateCommand="dataListSearchResult_UpdateCommand">
											                <ItemTemplate>
												                <tr>
													                <td class="icon"><asp:CheckBox ID="checkBoxAssociate" Runat="server" Enabled='<%# !((EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status")==EPiServer.Common.EntityStatus.Removed) %>'></asp:CheckBox></td>
													                <td><input type="hidden" runat="server" id="hiddenUserId" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' NAME="hiddenUserId">
														                <a href="javascript:SCMyPageOpenEditUser(<%# DataBinder.Eval(Container.DataItem, "ID") %>);"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "UserName")) %></a></td>
													                <td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "GivenName")) %></td>
													                <td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "SurName")) %></td>
													                <td><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "CreateDate")) %></td>
													                <td><%# GetStatusForSearchResults((EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status"))%></td>
													                <td align="right"><asp:Button ID="buttonUndoRemove" Runat="server" CssClass="button" CommandName="Update" Visible='<%# (EPiServer.Common.EntityStatus)DataBinder.Eval(Container.DataItem, "Status") == EPiServer.Common.EntityStatus.Removed %>'></asp:Button>&nbsp;</td>
												                </tr>
											                </ItemTemplate>
										                </asp:DataList>
										                <tr runat="server" id="rowNoResult">
											                <td colspan="7" style="height: 200px" valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.Search.NoResult") %>.</td>
										                </tr>
										                <tr runat="server" id="rowPagingBottom">
											                <td colspan="7"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
										                </tr>
											        </tbody>
											    </table>
											</td>
										</tr>														
									</tbody>
								</table>
							</asp:PlaceHolder>
						</asp:PlaceHolder>
					</ComponentArt:PageView>
				</ComponentArt:MultiPage>
			</ComponentArt:PageView>
			<ComponentArt:PageView  runat="server" ID="pageViewPortrait">
				<div id="tabStrip">
					<ComponentArt:TabStrip id="tabStripApprovePortraits" 
					CssClass="subGroup"
					DefaultItemLookId="DefaultTabLook"
					DefaultSelectedItemLookId="SelectedTabLook"
					DefaultDisabledItemLookId="DisabledTabLook"
					DefaultGroupTabSpacing="0"
					ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
					MultiPageId="multiPageApprovePortraits"
					runat="server">
					<ItemLooks>
						<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
						<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
					</ItemLooks>
					</ComponentArt:TabStrip>
					<ComponentArt:MultiPage id="multiPageApprovePortraits" CssClass="multiPage" runat="server" />
				</div>
			</ComponentArt:PageView>
		</ComponentArt:MultiPage>
	</div>