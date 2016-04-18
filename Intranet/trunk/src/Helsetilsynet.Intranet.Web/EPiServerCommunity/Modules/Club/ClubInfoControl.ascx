<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ClubInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ClubInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script language="javascript" src="Administration.js"></script>
<script language="javascript" src="js/StarSuite.js"></script>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript">
<!--
	SCSetTitle('<% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.Title") %>');
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
    <div id="tabStrip">
    <ComponentArt:TabStrip id="tabStripEditClub" 
		    CssClass="topGroup"
		    DefaultItemLookId="DefaultTabLook"
		    DefaultSelectedItemLookId="SelectedTabLook"
		    DefaultDisabledItemLookId="DisabledTabLook"
		    DefaultGroupTabSpacing="0"
		    ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		    MultiPageId="multiPageEditClub"
		    ScrollingEnabled="true"
		    ScrollLeftLookId="ScrollItem"
		    ScrollRightLookId="ScrollItem"
		    Width="792"
		    runat="server">
		    <ItemLooks>
			    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
			    <ComponentArt:ItemLook LookId="ScrollItem" CssClass="tabStripScrollItem" HoverCssClass="tabStripScrollItemHover" />
			    <ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
		    </ItemLooks>
		    <Tabs>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubDetails"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubMembers"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubImageGallery"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubVideoGallery"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubNews"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubMessages"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubForum"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubPoll"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabClubDocumentArchive"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabCalendar"></ComponentArt:TabStripTab>		
		    </Tabs>
		    </ComponentArt:TabStrip>
		    <ComponentArt:MultiPage id="multiPageEditClub" CssClass="multiPage" runat="server" Width="792">

			    <ComponentArt:PageView runat="server" ID="pageViewEditClubInfo">
    			
			    <asp:Panel ID="panelValidators" Runat="server" Visible="False">
				    <asp:RequiredFieldValidator id="validatorName" Runat="server" Display="None" EnableClientScript="False"
								    ControlToValidate="textBoxClubName"></asp:RequiredFieldValidator>
			    </asp:Panel>
    			
			    <input type="hidden" id="hdnOwnerUserId" runat="server" name="hdnOwnerUserId"/>
    							
				    <table class="epi-default" cellspacing="0" cellpadding="0" border="0">
				        <thead>
				            <tr>
				                <th><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.MenuHeader") %></th>
				                <th colspan="3">&nbsp;</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
					            <td class="menu" rowspan="11">
						            <button id="buttonAccessRights" <% if (ClubID == -1 || !_userAccessRights.Administrate) { %>disabled<% } %> class="button" onclick="SCOpenAccessRights('EPiServer.Community.Club.Security.ClubAccessRights,EPiServer.Community.Club', '<%= ClubID %>'); return false;"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.buttonAccessRights") %></button>
					            </td>
						        <td><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputName") %>:</td>
						        <td colspan="2">
							        <asp:TextBox id="textBoxClubName" Runat="server" Width="400" MaxLength="400" CssClass="input"></asp:TextBox>
							    </td>
				            </tr>
					        <tr>
						        <td><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputCreatedBy") %>:</td>
						        <td colspan="2"><% if (AuthorUserID > 0)
                                            { %><a href="javascript:SCMyPageOpenEditUser(<% = AuthorUserID %>);"><% = AdministrationUtils.FormatString(CreatorAlias)%></A><% } else { %> <% = AdministrationUtils.FormatString(CreatorAlias)%>  <% } %>&nbsp;</TD>
					        </tr>
					        <tr>
						        <td><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputClubOwner") %>:</td>
						        <td valign="top" colspan="2"><a href="javascript:SCMyPageOpenEditUser(document.getElementById('<%= hdnOwnerUserId.ClientID %>').value);"><asp:Label ID="labelClubOwner" Runat="server"><% = AdministrationUtils.FormatString(OwnerAlias) %></asp:Label></a>
							        &nbsp;&nbsp;<button class="button" onclick="SCOpenBrowseWindow('../EPiServerCommunity/Modules/MyPage/BrowseUserControl.ascx', '<% = hdnOwnerUserId.ClientID %>', '<% = labelClubOwner.ClientID %>');return false;">...</button></td>
					        </tr>
					        <tr>
						        <td valign="top"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputDescription") %>:</td>
						        <td valign="top" colspan="2">
							        <asp:TextBox id="textBoxDescription" Runat="server" Width="400" CssClass="input" TextMode="MultiLine" Height="80"></asp:TextBox>
						        </td>
					        </tr>
					        <tr>
						        <td valign="top"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputReason") %>:</td>
						        <td valign="top" colspan="2">
							        <asp:Label id="labelReason" Runat="server"></asp:Label>&nbsp;</td>
					        </tr>
					        <tr>
						        <td><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputNumMembers") %>:</td>
						        <td colspan="2">
							        <asp:Label id="labelNumMembers" Runat="server"></asp:Label>&nbsp;</td>
					        </tr>
					        <tr>
						        <td valign="top"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputHideStatus") %>:</td>
						        <td valign="top" colspan="2">
							        <asp:RadioButtonList id="radioButtonListHideStatus" Runat="server" RepeatLayout="Flow" CellSpacing="0"
								        CellPadding="0" RepeatDirection="Vertical">
								        <asp:ListItem Value="Hidden"></asp:ListItem>
								        <asp:ListItem Value="NotHidden" Selected="True"></asp:ListItem>
							        </asp:RadioButtonList></td>
					        </tr>
					        <tr>
						        <td valign="top"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputStatus") %>:</td>
						        <td valign="top" colspan="2">
							        <asp:RadioButtonList id="radioButtonListStatus" Runat="server" RepeatLayout="Flow" CellSpacing="0"
								        CellPadding="0" RepeatDirection="Vertical">
								        <asp:ListItem Value="Approved" Selected="True"></asp:ListItem>
								        <asp:ListItem Value="Pending"></asp:ListItem>
								        <asp:ListItem Value="Removed"></asp:ListItem>
							        </asp:RadioButtonList></td>
					        </tr>
					        <tr>
						        <td valign="top"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputSecurityStatus") %>:</td>
						        <td valign="top" colspan="2">
							        <asp:RadioButtonList id="radioButtonListSecurityStatus" Runat="server" RepeatLayout="Flow" CellSpacing="0"
								        CellPadding="0" RepeatDirection="Vertical">
								        <asp:ListItem Value="Open" Selected="True"></asp:ListItem>
								        <asp:ListItem Value="Closed"></asp:ListItem>
							        </asp:RadioButtonList></td>
					        </tr>
					        <tr>
						        <td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Club.ClubInfo.inputLogo") %>:</td>
						        <td valign="top">
							        <input class="input" id="fileLogo" type="file" name="fileLogo" runat="server"/>&nbsp;
							        <asp:CustomValidator ID="imageFileValidator" runat="server" Display="None" EnableClientScript="False" ControlToValidate="fileLogo"></asp:CustomValidator><br />
							        <asp:CheckBox id="checkBoxRemoveLogo" Runat="server" CssClass="input"></asp:CheckBox>
						        </td>
						        <td valign="top" align="right"><asp:Image id="imageLogo" runat="server"></asp:Image></td>
					        </tr>
					        <tr>
						        <td align="right" colspan="3">
							        <asp:Button id="buttonSave" Runat="server" CssClass="button" onclick="buttonSave_Click"></asp:Button></td>
					        </tr>
					    </tbody>
				    </table>
    							
			    </ComponentArt:PageView>
    			
			    <ComponentArt:PageView runat="server" ID="pageViewMembers"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewImageGallery"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewVideoGallery"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewNews"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewMessages"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewForum"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewPoll"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewDocumentArchive"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewCalendar"></ComponentArt:PageView>
	    </ComponentArt:MultiPage>
        <asp:PlaceHolder ID="placeHolderRedirectToEdit" runat="server" Visible="False">

            <script language="javascript">
                setTimeout('RedirectToEdit()', 1000);

                function RedirectToEdit() {
                    document.location.href = 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Club/ClubInfoControl.ascx&clubId=<% = CurrentClub.ID %>';
                }
            </script>

        </asp:PlaceHolder>
    </div>
    
<sc:NoEntityError runat="server" ID="NoEntityError" />