<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="BlogControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.BlogControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.js") %>"></script>

<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/js/StarSuite.js") %>"></script>

<!--<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>">-->

<script language="javascript">
<!--
	function <% = this.ClientID %>_ToggleSelector(selector)
	{
		selector.checked = !selector.checked;
	}
  SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.Title") %>');

//-->
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<asp:Panel ID="panelMain" runat="server">
    <div id="tabStrip">
        <ComponentArt:TabStrip ID="tabStripBlog" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageBlog" runat="server">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabBlogInformation">
                </ComponentArt:TabStripTab>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabBlogEntries">
                </ComponentArt:TabStripTab>
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="multiPageBlog" Width="99%" CssClass="multiPage" runat="server">
            <ComponentArt:PageView runat="server" ID="pageViewBlogInformation">
                <table cellpadding="0" cellspacing="0" class="epi-default">
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.BlogName") %>:
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="textBoxBlogName" runat="server" CssClass="input" Width="300" MaxLength="250"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validatorName" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxBlogName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.BlogPresentationText") %>:
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="textBoxBlogPresentationText" runat="server" CssClass="input" TextMode="MultiLine" Width="300" Height="70"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.BlogPresentationImage") %>:
                        </td>
                        <td valign="top">
                            <input class="file" id="filePresentationImage" type="file" name="filePresentationImage" runat="server">&nbsp;
                            <asp:CustomValidator ID="imageFileValidator" runat="server" Display="None" EnableClientScript="False" ControlToValidate="filePresentationImage"></asp:CustomValidator>
                            <asp:CheckBox ID="checkBoxRemoveImage" runat="server" CssClass="input" Visible="False"></asp:CheckBox>
                        </td>
                        <td valign="top" align="right">
                            <asp:Image ID="imagePresentation" runat="server"></asp:Image>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.BlogActiveStatus") %>:
                        </td>
                        <td colspan="2">
                            <asp:RadioButtonList ID="radioButtonListIsActive" runat="server" RepeatDirection="Horizontal" CssClass="input">
                                <asp:ListItem Value="Active" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="Not Active"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <asp:Button ID="buttonSaveBlogInformation" runat="server" CssClass="button"></asp:Button>
                        </td>
                    </tr>
                    <asp:PlaceHolder ID="placeHolderRemove" runat="server">
                        <tr>
                            <td align="right" colspan="3">
                                <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.EditEntry.confirm") %>');">
                                    <asp:Button ID="buttonRemove" runat="server" CssClass="button" /></span>
                            </td>
                        </tr>
                    </asp:PlaceHolder>
                </table>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" ID="pageViewBlogEntries">
                <input type="hidden" id="hiddenBlogId" runat="server" />
                <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
                    <tr>
                        <th>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.MenuHeader") %>
                        </th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td class="menu">
                            <asp:Panel ID="panelBlogEntriesMenu" runat="server">
                                <button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="<%= CreateEntryJS %>">
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Blog.Blog.buttonCreateNewEntry") %></button>
                                <asp:Button ID="buttonRemoveSelectedEntries" runat="server" CssClass="button" />
                            </asp:Panel>
                        </td>
                        <td valign="top">
                            <asp:PlaceHolder ID="placeHolderBlog" runat="server">
                                <div id="blog">
                                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                                    <asp:Repeater ID="repeaterBlog" runat="server">
                                        <HeaderTemplate>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <input type="hidden" id="hiddenEntryId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                            <div class="entry">
                                                <div class="date">
                                                    <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></div>
                                                <div class="title">
                                                    <asp:CheckBox ID="checkBoxSelected" runat="server" /><a href="<%# EditEntryJS((EPiServer.Community.Blog.Entry)Container.DataItem) %>"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header"))%></a></div>
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
<asp:PlaceHolder ID="placeHolderRedirectToEdit" runat="server" Visible="False">

    <script language="javascript">
        setTimeout('RedirectToEdit()', 1000);

        function RedirectToEdit() {
            document.location.href = 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Blog/BlogWrapper.ascx&blogId=<% = Blog.ID %>';
        }
    </script>

</asp:PlaceHolder>
