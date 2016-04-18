<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ExpertInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ExpertInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.js") %>"></script>
<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/js/StarSuite.js") %>"></script>
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>">
<script language="javascript">
<!--
	SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.Title") %>');
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<asp:panel ID="panelMain" runat="server">
    <div id="tabStrip">
	    <ComponentArt:TabStrip id="tabStripExpertInfo" 
		    CssClass="topGroup"
		    DefaultItemLookId="DefaultTabLook"
		    DefaultSelectedItemLookId="SelectedTabLook"
		    DefaultDisabledItemLookId="DisabledTabLook"
		    DefaultGroupTabSpacing="1"
		    ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		    MultiPageId="multiPageExpertInfo"
		    runat="server">
		    <ItemLooks>
			    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
			    <ComponentArt:ItemLook LookId="ScrollItem" CssClass="tabStripScrollItem" HoverCssClass="tabStripScrollItemHover" />
			    <ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
		    </ItemLooks>
		    <Tabs>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabExpertDetails"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabQuestionAssignments"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabExpertForum"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabExpertBlog"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabAnswerQuestion"></ComponentArt:TabStripTab>
			    </Tabs>
		    </ComponentArt:TabStrip>
		    <ComponentArt:MultiPage id="multiPageExpertInfo" CssClass="multiPage" runat="server">

			    <ComponentArt:PageView runat="server" ID="pageViewEditExpertInfo">
    							
				    <input type="hidden" id="hdnExpertUserId" runat="server" NAME="hdnExpertUserId"/>			
    						
				    <table class="epi-default" cellSpacing="0" cellPadding="0">
				        <tr>
				            <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputExpertType") %>:</td>
				            <td colspan="4">
				                <asp:RadioButtonList ID="radioExpertType" AutoPostBack="true" RepeatDirection="Horizontal" CssClass="input" OnSelectedIndexChanged="radioExpertType_SelectedIndexChanged" runat="server">
				                    <asp:ListItem Value="Expert" Selected="True"></asp:ListItem>
				                    <asp:ListItem Value="MemberExpert"></asp:ListItem> 
				               </asp:RadioButtonList>
				            </td>
				        </tr>
    				    
				        <asp:Panel ID="panelExpert" runat="server">
					    <tr>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputFirstName") %>:</td>
						    <td>
							    <asp:TextBox id="textBoxExpertFirstName" Runat="server" MaxLength="100" CssClass="input"></asp:TextBox>
							    <asp:RequiredFieldValidator ID="firstNameRequiredvalidator" ControlToValidate="textBoxExpertFirstName" Display="None" EnableClientScript="False" runat="server"></asp:RequiredFieldValidator>
						    </td>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputLastName") %>:</td>
						    <td>
							    <asp:TextBox id="textBoxExpertLastName" Runat="server" MaxLength="100" CssClass="input"></asp:TextBox>
						    </td>
					    </tr>
					    <tr>
					        <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputEmail") %>:</td>
						    <td>
							    <asp:TextBox id="textBoxEmail" Runat="server" MaxLength="255" CssClass="input" />
							    <asp:RegularExpressionValidator id="emailValidator" CssClass="requiredField" ControlToValidate="textBoxEmail" Text="*" Runat="server" Display="None" EnableClientScript="False" />
						    </td>
						    <td colspan="2">&nbsp;</td>
					    </tr>
					    <asp:CustomValidator runat="server" ID="ExpertDetailsValidator" Display="None" CssClass="validator" OnServerValidate="ValidateNewExpertDetails" EnableClientScript="false" />
					    </asp:Panel>
    					
					    <asp:Panel ID="panelExpertMember" runat="server" Visible="false">
					    <tr>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputMemberAlias") %>:</td>
						    <td colspan="3"><button <% = ((UserID == -1 && ExpertID == -1 && ((RadioButtonList)this.FindControl("radioExpertType")).SelectedValue == "MemberExpert") ? "" : "disabled") %> class="button" onclick="SCOpenBrowseWindow('../EPiServerCommunity/Modules/MyPage/BrowseUserControl.ascx', '<% = hdnExpertUserId.ClientID %>', '<% = labelExpertAlias.ClientID %>');return false;">...</button><a href="javascript:SCMyPageOpenEditUser(<%= UserID %>);"><asp:Label ID="labelExpertAlias" Runat="server"><% = UserAlias %></asp:Label></a>&nbsp;</td>
					    </tr>
					    <asp:CustomValidator ID="validatorUserAlias" runat="server" EnableClientScript="False" Display="None"></asp:CustomValidator>
					    </asp:Panel>
    					
					    <tr>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputPhone") %>:</td>
						    <td>
							    <asp:TextBox id="textBoxPhone" Runat="server" MaxLength="20" CssClass="input"></asp:TextBox>
						    </td>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputHomepage") %>:</td>
						    <td>
							    <asp:TextBox id="textBoxHomepage" Runat="server" MaxLength="100" CssClass="input"></asp:TextBox>
						    </td>
					    </tr>
    					
					    <tr>
						    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputDescription") %>:</td>
						    <td vAlign="top" colspan="3">
							    <asp:TextBox id="textBoxDescription" Runat="server" CssClass="input" TextMode="MultiLine" Height="80" Width="400"></asp:TextBox></td>
					    </tr>
					    <tr>
						    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputQualifications") %>:</td>
						    <td vAlign="top" colspan="3">
							    <asp:TextBox id="textBoxQualifications" Runat="server" CssClass="input" TextMode="MultiLine" Height="80" Width="400"></asp:TextBox>
							   </td>
					    </tr>
					    <tr>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputForumRoom") %>:</td>
						    <td colspan="3">
							    <asp:Label ID="labelSelectedForumRoomName" Runat="server"></asp:Label>
							    <span id="spanForumRoomButtons" runat="server">
								    <input type="hidden" id="hiddenForumRoomID" runat="server" NAME="hiddenForumRoomID">
								    <button class="button" onclick="javascript:SCExpertOpenSelectForumRoom('<%=hiddenForumRoomID.ClientID%>', '<%=labelSelectedForumRoomName.ClientID%>'); return false;"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.buttonSelectForumRoom") %></button>
								    <asp:CheckBox id="checkBoxRemoveForumRoom" Runat="server" Visible="false" />
							    </span>
						    </td>
					    </tr>
					    <tr>
						    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputStatus") %>:</td>
						    <td vAlign="top" colspan="3">
							    <asp:RadioButtonList id="radioButtonListStatus" Runat="server" RepeatLayout="Flow" CellSpacing="0"
								    CellPadding="0" RepeatDirection="Vertical">
								    <asp:ListItem Value="Applied"></asp:ListItem>
								    <asp:ListItem Value="Active" Selected="True"></asp:ListItem>
								    <asp:ListItem Value="Inactive"></asp:ListItem>
							    </asp:RadioButtonList>
						    </td>
					    </tr>
					   
					    <tr>
						    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.inputImage") %>:</td>
						    <td valign="top">
							    <input class="input" id="fileImage" type="file" name="fileImage" runat="server">&nbsp;
							    <asp:CheckBox id="checkBoxRemoveImage" Runat="server" CssClass="input"></asp:CheckBox>
							    <asp:CustomValidator ID="validatorImageFormat" Runat="server" EnableClientScript="False" Display="None" />
						    </td>
						    <td vAlign="top" colspan="2" align="right">
							    <asp:Image id="image" runat="server"></asp:Image>&nbsp;
						    </td>
					    </tr>
					    <tr>
						    <td align="right" colSpan="4">
							    <asp:Button id="buttonSave" Runat="server" CssClass="button" OnClick="buttonSave_Click"></asp:Button>&nbsp;
						    </td>
					    </tr>
					    <asp:PlaceHolder ID="placeHolderRemove" runat="server">
				            <tr>
					            <td align="right" colspan="4">
					                <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ExpertInfo.RemoveExpert.confirm") %>');"><asp:Button ID="buttonRemove" Runat="server" OnCommand="ButtonRemove_Command" CssClass="button"/></span>
					            </td>
				            </tr>
					    </asp:PlaceHolder>
				    </table>
			    </ComponentArt:PageView>
    			
			    <ComponentArt:PageView runat="server" ID="pageViewAssignments"></ComponentArt:PageView>

			    <ComponentArt:PageView runat="server" ID="pageViewForum"></ComponentArt:PageView>
			    <ComponentArt:PageView runat="server" ID="pageViewBlog"></ComponentArt:PageView>
    			
			    <ComponentArt:PageView runat="server" ID="pageViewAnswerQuestion">
				    <table class="epi-default" cellSpacing="0" cellPadding="0">
					    <thead>
						    <tr>
							    <th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.Question") %></th>
						    </tr>
					    </thead>
					    <tbody>
						    <tr>
							    <td width="150"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.inputQuestionHeader") %>:</td>
							    <td>
								    <%= ((m_assignedQuestion != null && m_assignedQuestion.Question != null) ? AdministrationUtils.FormatString(m_assignedQuestion.Question.Header) : "&nbsp;") %>
							    </td>
						    </tr>
						    <tr>
							    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.inputQuestionBody") %>:</td>
							    <td vAlign="top">
								    <%= ((m_assignedQuestion != null && m_assignedQuestion.Question != null) ? AdministrationUtils.FormatString(m_assignedQuestion.Question.Body) : "&nbsp;") %>
							    </td>
						    </tr>
					    </tbody>
				    </table>
				    <table class="epi-default" cellSpacing="0" cellPadding="0">
					    <thead>
						    <tr>
							    <th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.Answer") %></th>
						    </tr>
					    </thead>
					    <tbody>
						    <tr>
							    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.inputAnswerHeader") %>:</td>
							    <td>
								    <asp:TextBox ID="textBoxAnswerHeader" Runat="server" CssClass="input" MaxLength="100" Width="500"></asp:TextBox>
							    </td>
						    </tr>
						    <tr>
							    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.ExpertInfo.AnswerQuestion.inputAnswerBody") %>:</td>
							    <td vAlign="top">
								    <asp:TextBox ID="textBoxAnswerBody" Runat="server" CssClass="input" TextMode="MultiLine" Rows="20" Width="500"></asp:TextBox>
								    <asp:RequiredFieldValidator ID="validatorAnswerBody" Runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxAnswerBody" Enabled="False"></asp:RequiredFieldValidator>
							    </td>
						    </tr>
						    <tr>
							    <td valign="top" colspan="2" align="right">
								    <asp:Button ID="buttonSubmitAnswer" Runat="server" CssClass="input" OnClick="buttonSubmitAnswer_Click"></asp:Button>
							    </td>
						    </tr>
					    </tbody>
				    </table>
			    </ComponentArt:PageView>
    			
	    </ComponentArt:MultiPage>
    	
	    <asp:PlaceHolder ID="placeHolderRefreshParentWindow" Runat="server" Visible="False">
		    <script language="javascript">
			    setTimeout('RefreshParentWindow()', 1000);
    			
			    function RefreshParentWindow()
			    {
				    if(window.opener)
				        window.opener.__doPostBack('<% = ExpertListControlId %>', '<% = EPiServer.Community.Web.Administration.ExpertListControl.POSTBACK_REFRESH_ARGUMENT %>');
			    }
		    </script>
	    </asp:PlaceHolder>
    </div>
</asp:panel>
