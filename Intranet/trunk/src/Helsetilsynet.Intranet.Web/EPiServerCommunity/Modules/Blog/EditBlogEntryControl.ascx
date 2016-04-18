<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="EditBlogEntryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditBlogEntryControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<script language="javascript" src="Administration.js"></script>
<script language="javascript" src="js/StarSuite.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript">
    SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.Title") %>');
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<sc:NoEntityError runat="server" ID="NoEntityError"  />
<asp:Panel ID="panelMain" runat="server">
    <div id="tabStrip" class="epi-marginVertical-small">
	    <ComponentArt:TabStrip id="tabStripEditBlogEntry" 
	    CssClass="topGroup"
	    DefaultItemLookId="DefaultTabLook"
	    DefaultSelectedItemLookId="SelectedTabLook"
	    DefaultDisabledItemLookId="DisabledTabLook"
	    DefaultGroupTabSpacing="0"
	    ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
	    MultiPageId="multiPageEditBlogEntry"
	    runat="server">
	    <ItemLooks>
		    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
		    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
	    </ItemLooks>
	    </ComponentArt:TabStrip>
    	
	    <ComponentArt:MultiPage id="multiPageEditBlogEntry" CssClass="multiPage" runat="server">
    	
		    <ComponentArt:PageView  runat="server" ID="pageViewEntryDetails">	
    			
				    <table class="epi-default" cellSpacing="0" cellPadding="0">
				        <tr>
				            <th colspan="2">Blog Entry</th>
				        </tr>
					    <tr>
						    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.inputEntryTitle") %>:</TD>
						    <td>
							    <asp:TextBox id="textBoxTitle" Runat="server" CssClass="input" Width="405" MaxLength="100"></asp:TextBox>
							    <asp:RequiredFieldValidator id="validatorTitle" Runat="server" Display="None"
								    ControlToValidate="textBoxTitle" EnableClientScript="false"></asp:RequiredFieldValidator></TD>
					    </tr>
					    <tr>
						    <td vAlign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.inputEntryText") %>:</TD>
						    <td>
							    <asp:TextBox id="textBoxContent" Runat="server" CssClass="input" Columns="77" Rows="20" TextMode="MultiLine"></asp:TextBox></td>
					    </tr>
					    <tr>
						    <td align="right" colspan="2"><asp:Button ID="buttonSave" Runat="server" CssClass="button"></asp:Button></td>
					    </tr>
					    <asp:PlaceHolder ID="placeHolderRemove" runat="server">
					        <tr>
						        <td align="right" colspan="2"><span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.confirm") %>');"><asp:Button ID="buttonRemove" Runat="server" CssClass="button"/></span></td>
					        </tr>
					    </asp:PlaceHolder>
				    </table>
				    
				    <asp:PlaceHolder ID="placeHolderEditComment" runat="server" Visible="false">
				        <table class="epi-default" cellSpacing="0" cellPadding="0">
				            <tr>
				                <th colspan="2">Blog Entry Comment</th>
				            </tr>
					        <tr>
						        <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.inputEntryTitle") %>:</td>
						        <td>
							        <asp:TextBox id="textBoxCommentSubject" Runat="server" CssClass="input" Width="405" MaxLength="100"></asp:TextBox>
							        <asp:RequiredFieldValidator id="RequiredFieldValidator1" Runat="server" Display="None"
								        ControlToValidate="textBoxCommentSubject" EnableClientScript="false"></asp:RequiredFieldValidator></TD>
					        </tr>
					        <tr>
						        <td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.inputEntryText") %>:</td>
						        <td>
							        <asp:TextBox id="textBoxCommentBody" Runat="server" CssClass="input" Columns="77" Rows="20" TextMode="MultiLine"></asp:TextBox>
							        <asp:RequiredFieldValidator id="RequiredFieldValidator2" Runat="server" Display="None"
								        ControlToValidate="textBoxCommentBody" EnableClientScript="false"></asp:RequiredFieldValidator></td>
					        </tr>
					        
					        <asp:PlaceHolder ID="placeHolderRemoveComment" runat="server">
					            <tr>
					                <td align="right" colspan="2">
					                    <asp:Button ID="buttonSaveComment" Runat="server" CssClass="button" OnCommand="ButtonSaveComment_Command" />
					                </td>
					            </tr>
					            <tr>
					                <td align="right" colspan="2">
						                <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.confirm") %>');"><asp:Button ID="buttonRemoveComment" OnCommand="ButtonRemoveComment_Command" Runat="server" CssClass="button"/></span>
						            </td>
					            </tr>
					        </asp:PlaceHolder>
				        </table>
				    </asp:PlaceHolder>
    				
		    </ComponentArt:PageView>
    		
		    <ComponentArt:PageView  runat="server" ID="pageViewComments">
    			
				    <table class="epi-default" cellSpacing="0" cellPadding="0" border="0">
				        <thead>
				            <tr>
				                <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EntryComments.MenuHeader") %></th>
				                <th>&nbsp;</th>
				            </tr>
				        </thead>
				        <tbody>
					        <tr>
						        <td class="menu">
							        <asp:Button id="buttonRemoveSelected" Runat="server" CssClass="button" onclick="ButtonRemoveSelected_Click"></asp:Button>
							    </td>
						        <td vAlign="top">
							        <div id="blog">
								        <sc:PagingControl id="pagingControlTop" runat="server"></sc:PagingControl>
								        <asp:Repeater id="repeaterComments" Runat="server">
									        <ItemTemplate>
										        <input type="hidden" id="hiddenCommentId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' NAME="hiddenCommentId"/>
										        <div class="entry">
											        <div class="date"><%# DataBinder.Eval(Container.DataItem, "Created") %></div>
											        <div class="title">
												        <asp:CheckBox ID="checkBoxSelected" Runat="server" /><%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Header").ToString())%></div>
											        <br />
											        <div class="content"><%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Body").ToString()) %></div>
										        </div>
									        </ItemTemplate>
								        </asp:Repeater>
								        <sc:PagingControl id="pagingControlBottom" runat="server"></sc:PagingControl>
							        </div>
						        </td>
					        </tr>
					    </tbody>
				    </table>

		    </ComponentArt:PageView>
    		
	    </ComponentArt:MultiPage>
    </div>
</asp:Panel>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<SCRIPT language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
		    refreshParent();
			window.close();
        }

	</SCRIPT>
</asp:PlaceHolder>

<script type="text/javascript">

    window.onunload = refreshParent;

    function refreshParent() {
        if (window.opener && window.opener.__doPostBack) {
            window.opener.__doPostBack('<% = BlogControlId %>', '<% = EPiServer.Community.Web.Administration.ImageGalleryControl.POSTBACK_REFRESH_ARGUMENT %>');
        }
    }

</script>
