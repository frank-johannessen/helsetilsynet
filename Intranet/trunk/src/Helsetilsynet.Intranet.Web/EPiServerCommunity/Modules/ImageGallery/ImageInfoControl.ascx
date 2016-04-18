<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="ImageInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ImageInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script src="Administration.js"></script>

<link rel="stylesheet" type="text/css" href="Administration.css">
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css">
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<asp:Panel ID="panelMain" runat="server">
    <div id="tabStrip" class="epi-marginVertical-small">
        <ComponentArt:TabStrip ID="tabStripImage" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageImage" runat="server">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabImageInfo">
                </ComponentArt:TabStripTab>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabImageComments">
                </ComponentArt:TabStripTab>
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="multiPageImage" Width="510px" CssClass="multiPage" runat="server">
            <ComponentArt:PageView runat="server" ID="pageViewImageInfo">
                <asp:PlaceHolder ID="placeHolderImage" runat="server">

                    <script language="javascript">
						    window.onload = <% = this.ClientID %>_ResizeWindow;
						    function <% = this.ClientID %>_ResizeWindow()
						    {
							    var img = document.getElementById('<% = imageLarge.ClientID %>');

							    if(!img)
								    setTimeout('<% = this.ClientID %>_ResizeWindow()', 500);
							    else
							    {									
								    var imgHeight = img.height;
								    var imgWidth = img.width;
								    
								    if(imgHeight == 0 || imgWidth == 0){
								        //If the dialog has had a post back in another tab then image properties are 0 and we use max width/height instead to prevent to large images.
								        //Note that this will not work in IE6 so the image might become to large in this case.
                                        img.style.maxWidth = '800px';
								        img.style.maxHeight = '600px';
								        return;
								    }
    								
								    var maxImgWidth = 800;
								    var maxImgHeight = 600;
    								
								    var screenWidth = screen.width;
								    var screenHeight = screen.height;
    								
								    if (screenWidth <= 800)
									    maxImgWidth = 450;
    									
								    if (screenHeight <= 800)
									    maxImgHeight = 270;
    																
								    //If the image is big, lets resize it to fit on the screen
								    while (imgWidth > maxImgWidth || imgHeight > maxImgHeight)
								    {									
									    imgHeight = (imgHeight * 0.90);
									    imgWidth = (imgWidth * 0.90);
								    }
    								
								    img.width = imgWidth;
								    img.height = imgHeight;
    																
								    //Make sure the window size is bigger than the image
								    var windowWidth = img.width + 110; //65
								    var windowHeight = img.height + 290; //250

								    if(windowWidth < 595)
									    windowWidth = 595;
    									
								    if(windowHeight < 530)
									    windowHeight = 530;
    								
								    //If the window is wider than the screen, make sure it fits
								    if(windowWidth > screenWidth)
									    windowWidth = screenWidth;
    								
								    //If the window is higher than the screen, make sure it fits	
								    if(windowHeight > screenHeight)
									    windowHeight = screenHeight;									
    								
								    window.moveTo(0, 0);
								    window.resizeTo(windowWidth, windowHeight);
							    }
						    }
                    </script>

                    <script language="javascript">
                        document.title = "<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.ImageInfoControl.ImageInformation")%>";
                    </script>

                    <table class="epi-default" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="3">
                                <asp:Image ID="imageLarge" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="labelNameLabel" runat="server" />
                            </td>
                            <td>
                                <asp:Label ID="labelName" runat="server" />&nbsp;
                            </td>
                            <td align="right">
                                <asp:Button ID="buttonDownloadOriginal" CssClass="button" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="labelDescriptionLabel" runat="server" />
                            </td>
                            <td colspan="2">
                                <asp:Label ID="labelDescription" runat="server" />&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="labelUploadedByLabel" runat="server" />
                            </td>
                            <td colspan="2">
                                <% if (Image != null && Image.Author != null)
                                   {
                                       if (Image.Author is EPiServer.Common.UserAuthor)
                                       {
                                            %><a href="javascript:SCMyPageOpenEditUser(<% = ((EPiServer.Common.UserAuthor)Image.Author).User.ID %>);"><% = AdministrationUtils.FormatString(((EPiServer.Common.UserAuthor)Image.Author).User.Alias)%></a>
                                      <% }
                                       else if (Image.Author is EPiServer.Common.AnonymousAuthor)
                                       {
                                           %><a href="javascript:SCMyPageOpenEditUser(<% = ((EPiServer.Common.AnonymousAuthor)Image.Author).User.ID %>);"><% = AdministrationUtils.FormatString(((EPiServer.Common.AnonymousAuthor)Image.Author).User.Alias)%></a>
                                      <% }
									   else if (Image.Author is EPiServer.Common.GuestAuthor)
									   {	
										   %><% = Image.Author.Name %><%
									   }
                                   }   								
                                        %>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="labelUploadedLabel" runat="server" />
                            </td>
                            <td colspan="2">
                                <asp:Label ID="labelCreated" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right">
                                <asp:Button ID="buttonSave" runat="server" CssClass="button" OnClick="buttonSave_Click" />
                                <asp:CustomValidator ID="customSaveValidator" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>
                            </td>
                        </tr>
                        <asp:PlaceHolder ID="placeHolderRemove" runat="server">
                            <tr>
                                <td align="right" colspan="3">
                                    <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.RemoveImage.confirm") %>');">
                                        <asp:Button ID="buttonRemove" runat="server" CssClass="button" OnCommand="ButtonRemove_Command" /></span>
                                </td>
                            </tr>
                        </asp:PlaceHolder>
                    </table>
                </asp:PlaceHolder>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" ID="pageViewImageComments">
            <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
                <tr>
                    <td class="menu">
                        <div class="section top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.ImageInfo.Comments.MenuHeader") %></div>
                        <asp:Panel ID="panelImageMenu" runat="server">
                            <asp:Button ID="buttonRemoveSelectedEntries" runat="server" CssClass="button" />
                        </asp:Panel>
                    </td>
                    <td valign="top">
                        <asp:PlaceHolder ID="placeHolderImageComments" runat="server">
                            <div id="blog">
                                <sc:PagingControl ID="pagingControlTop" runat="server" />
                                <asp:Repeater ID="repeaterImageComments" runat="server">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <input type="hidden" id="hiddenImageCommentId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                        <div class="entry">
                                            <div class="date">
                                                <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></div>
                                            <br />
                                            <div class="title">
                                                <asp:CheckBox ID="checkBoxSelected" runat="server" /><a href="#" onclick="<%# EditCommentJS((EPiServer.Community.ImageGallery.ImageComment)Container.DataItem) %>"><%# GetHeaderText(Container) %></a></div>
                                            <br />
                                            <div class="content">
                                                <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Body")) %></div>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <sc:PagingControl ID="pagingControlBottom" runat="server" />
                            </div>
                        </asp:PlaceHolder>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ComponentArt:PageView>
        </ComponentArt:MultiPage>
    </div>
</asp:Panel>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
			window.close();
		}
	</script>
</asp:PlaceHolder>
<sc:NoEntityError runat="server" ID="NoEntityError" />