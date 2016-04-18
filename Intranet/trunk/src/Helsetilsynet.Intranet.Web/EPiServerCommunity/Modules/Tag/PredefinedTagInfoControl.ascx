<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PredefinedTagInfoControl.ascx.cs"
    Inherits="EPiServer.Community.Web.Administration.PredefinedTagInfoControl" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI"
    Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<sc:SaveResultPanel ID="SaveResultPanel" runat="server" />
<asp:Panel ID="ValidatorsPanel" runat="server" Visible="false">
    <asp:RequiredFieldValidator ID="NameValidator" runat="server" Display="None" EnableClientScript="False"
        ControlToValidate="TagNameTextBox"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="AddExistingPredefinitionValidator" Display="None" EnableClientScript="False"
        runat="server"></asp:CustomValidator>
</asp:Panel>
<ComponentArt:TabStrip ID="PredefinedTagsTabStrip" CssClass="topGroup" DefaultItemLookId="DefaultTabLook"
    DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook"
    DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
    MultiPageId="PredefinedTagsMultiPage" runat="server">
    <ItemLooks>
        <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
        <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
    </ItemLooks>
    <Tabs>
        <ComponentArt:TabStripTab runat="server" ID="PredefinedTagsTabStripTab" PageViewId="PredefinedTagsPageView">
        </ComponentArt:TabStripTab>
    </Tabs>
</ComponentArt:TabStrip>
<ComponentArt:MultiPage ID="PredefinedTagsMultiPage" CssClass="multiPage"
    runat="server">
    <ComponentArt:PageView runat="server" ID="PredefinedTagsPageView">
        <br />
        <table class="epi-default" cellpadding="0" cellspacing="0">
            <tbody>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.inputType")%>:
                    </td>
                    <td>
                        <asp:DropDownList ID="ObjectTypesDropDownList" runat="server" CssClass="input">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.inputTagName")%>:
                    </td>
                    <td>
                        <asp:TextBox ID="TagNameTextBox" runat="server" CssClass="input" MaxLength="100"
                            Width="120"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <asp:Button ID="AddPredifinitionButton" runat="server" CssClass="button" OnClick="AddPredifinition_Click" />                        
                    </td>
                </tr>
            </tbody>
        </table>
    </ComponentArt:PageView>
</ComponentArt:MultiPage>
<asp:PlaceHolder ID="PlaceHolderCloseWindow" runat="server" Visible="False">

    <script language="javascript" type="text/javascript">
        setTimeout('CloseWindow()', 1000);

        function CloseWindow() {
            if (window.opener && window.opener.RefreshTagList) {
                window.opener.RefreshTagList();
            }
            window.close();
        }
    </script>

</asp:PlaceHolder>
