<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="EditForumControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditForumControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<div id="forum">
    <asp:Panel ID="panelEditForum" runat="server">
        <table width="100%">
            <tr>
                <td>
                    <asp:Button ID="buttonSave" runat="server" CssClass="button" /><span onclick="if(document.getElementById('<% = hiddenForumId.ClientID %>').value != -1) return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.EditForum.SpanConfirmRemoveForum") %>?');"><asp:Button ID="buttonRemove" runat="server" CssClass="button" /></span>
                    <button id="buttonAccessRights" class="button" <% if (m_forum.ID == -1 || !m_accessRights.Administrate) { %>disabled<% } %> onclick="SCOpenAccessRights('EPiServer.Community.Forum.Security.ForumAccessRights,EPiServer.Community.Forum', '<% = m_forum.ID %>', '<% = this.ResolveUrl("~/EPiServerCommunity/") %>'); return false;">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.EditForum.buttonAccessRights") %></button>
                </td>
            </tr>
        </table>
        <br />
        <div id="tabStrip">
            <input type="hidden" runat="server" id="hiddenForumId" />
            <ComponentArt:TabStrip ID="tabStripForum" CssClass="subGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageForum" runat="server" EnableViewState="false">
                <ItemLooks>
                    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="DefaultTab" HoverCssClass="DefaultTabHover" />
                    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="SelectedTab"  />
                </ItemLooks>
                <Tabs>
                    <ComponentArt:TabStripTab ID="TabDetails" runat="server" />
                </Tabs>
            </ComponentArt:TabStrip>
            <ComponentArt:MultiPage ID="multiPageForum" runat="server" EnableViewState="false" Width="100%"> 
                <ComponentArt:PageView runat="server" ID="pageViewContent">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0" class="epi-default">
                        <tr>
                            <td width="100">
                                <asp:Label ID="labelName" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="textBoxName" runat="server" CssClass="input" Width="200"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="validatorName" runat="server" ControlToValidate="textBoxName" EnableClientScript="False" Display="None" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                            </td>
                        </tr>
                    </table>
                </ComponentArt:PageView>
            </ComponentArt:MultiPage>
        </div>
    </asp:Panel>
</div>
