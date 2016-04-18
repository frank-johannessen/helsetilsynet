<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ReadMessageControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ReadMessageControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<script language="javascript">
<!--
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Title") %>'
//-->
</script>

<asp:Panel ID="panelMain" runat="server">
    <div id="tabStrip">
    <ComponentArt:TabStrip id="tabStripDirectMessage" 
		    CssClass="topGroup"
		    DefaultItemLookId="DefaultTabLook"
		    DefaultSelectedItemLookId="SelectedTabLook"
		    DefaultDisabledItemLookId="DisabledTabLook"
		    DefaultGroupTabSpacing="1"
		    ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		    MultiPageId="multiPageDirectMessage"
		    runat="server">
		    <ItemLooks>
			    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
			    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
		    </ItemLooks>
		    <Tabs>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabMessageInfo"></ComponentArt:TabStripTab>
			    <ComponentArt:TabStripTab Runat="server" ID="tabStripTabMessageCategories"></ComponentArt:TabStripTab>
		    </Tabs>
		    </ComponentArt:TabStrip>
		    <ComponentArt:MultiPage id="multiPageDirectMessage" CssClass="multiPage" runat="server">
    		
			    <ComponentArt:PageView runat="server" ID="pageViewBlogEntries">

				    <asp:PlaceHolder ID="placeHolderReadMessage" Runat="server">
					    <table class="epi-default" cellpadding="0" cellspacing="0">
						    <tr>
							    <td width="100"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Header.Subject") %>:</td>
							    <td><asp:Label id="labelSubject" Runat="server" /></td>
						    </tr>
						    <tr>
							    <td width="100"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Header.Type") %>:</td>
							    <td><% = Message is EPiServer.Community.DirectMessage.SystemMessage ? "System" : "Message" %></td>
						    </tr>
						    <% if(Message is EPiServer.Community.DirectMessage.Message) { %>
						    <tr>
							    <td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Header.To") %>:</td>
							    <td valign="top">
								    <asp:DataList ID="dataListReceivers" Runat="server" CssClass="epi-default" ItemStyle-CssClass="icon" RepeatDirection="Vertical" RepeatColumns="3">
									    <ItemTemplate><asp:Image ID="imageReadIcon" Runat="server" ImageUrl='<%# (((EPiServer.Community.DirectMessage.MessageRecipient)Container.DataItem).HasRead ?  "../../images/readMessage.gif" : "../../images/unreadMessage.gif") %>' Width="16" Height="16" /></td><td class="label"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Recipient.Alias")) %></ItemTemplate>
								    </asp:DataList>
							    </td>
						    </tr>
						    <% } %>
						    <tr>
							    <td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Header.Text") %>:</td><td valign="top"><asp:Label id="labelText" Runat="server" /></td>
						    </tr>
						    <tr>
						        <td align="right" colspan="2"><span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.RemoveMessage.confirm") %>');"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" OnCommand="ButtonRemove_Command"/></span></td>
						    </tr>
					    </table>
				    </asp:PlaceHolder>
    				
			    </ComponentArt:PageView>
    			
			    <ComponentArt:PageView runat="server" ID="pageViewDirectMessageCategories">
    			
				    <table class="epi-default" cellSpacing="0" cellPadding="0">
					    <thead>
						    <tr>
							    <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DirectMessage.Message.Categories.Header") %></th>
						    </tr>
					    </thead>
					    <tbody>
						    <tr>
							    <td>
								    <asp:Button Runat="server" ID="buttonSaveDirectMessageCategories" CssClass="button" Text=""></asp:Button>
							    </td>
						    </tr>
						    <tr>
							    <td>
								    <asp:Panel ID="panelCategoryCheckBoxes" Runat="server"></asp:Panel>&nbsp;
							    </td>
						    </tr>
					    </tbody>
				    </table>
    				
			    </ComponentArt:PageView>
    			
		    </ComponentArt:MultiPage>
    </div>
</asp:Panel>

<sc:NoEntityError runat="server" ID="NoEntityError" />