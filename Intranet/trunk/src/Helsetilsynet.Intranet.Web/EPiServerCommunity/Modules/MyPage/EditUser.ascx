<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="Portrait" Src="PortraitControl.ascx"%>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="EditUser.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditUser" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript" src="js/StarSuite.js"></script>

<script src="Administration.js"></script>

<script language="javascript">
    document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.Title") %>'
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<sc:NoEntityError runat="server" ID="NoEntityError" />
<asp:Panel ID="panelMain" runat="server">
<div id="tabStrip" class="epi-marginVertical-small">
    <ComponentArt:TabStrip ID="tabStripEditUser" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageEditUser" ScrollingEnabled="true" ScrollLeftLookId="ScrollItem" ScrollRightLookId="ScrollItem" Width="760" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
            <ComponentArt:ItemLook LookId="ScrollItem" CssClass="tabStripScrollItem" />
            <ComponentArt:ItemLook LookId="DisabledTabLook" CssClass="disabledTab" />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" ID="tabMyUserDetails">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyImageGallery">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyVideoGallery">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyDocumentArchive">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyBlog">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyGuestbook">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyPolls">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyDirectMessages">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabMyWebmailAccount">
            </ComponentArt:TabStripTab>
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageEditUser" Width="760" CssClass="multiPage" runat="server">
        <ComponentArt:PageView runat="server" ID="pageViewEditUserInfo">
            <table class="epi-default" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputUserName") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxUserName" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validatorUserName" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxUserName"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="validatorUserExists" runat="server" Display="Dynamic" EnableClientScript="False" ControlToValidate="textBoxUserName">*</asp:CustomValidator>
                    </td>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputAlias") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxAlias" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validatorAlias" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxAlias"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputFirstName") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxGivenName" runat="server" CssClass="input"></asp:TextBox>
                    </td>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputLastName") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxSurName" runat="server" CssClass="input"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputEmail") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxEmail" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validatorEmail" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxEmail"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="emailValidator" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxEmail"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputBirthDate") %>:
                    </td>
                    <td>
                        <asp:DropDownList ID="dropDownListBirthYear" runat="server" CssClass="input">
                        </asp:DropDownList>
                        -
                        <asp:DropDownList ID="dropDownListBirthMonth" runat="server" CssClass="input">
                        </asp:DropDownList>
                        -
                        <asp:DropDownList ID="dropDownListBirthDay" runat="server" CssClass="input">
                        </asp:DropDownList>
                        <asp:CustomValidator ID="validatorBirthDate" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.EditUser.inputRemoved") %>:
                    </td>
                    <td colspan="5">
                        <asp:CheckBox ID="checkBoxRemoved" runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <sc:Portrait ID="Portrait" runat="server" />
            </table>
            <br />
            <table class="epi-default" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td align="right" colspan="6">
                        <asp:Button ID="buttonSave" runat="server" CssClass="button"></asp:Button>
                    </td>
                </tr>
            </table>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewImageGallery"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewVideoGallery"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewDocumentArchive"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewBlog"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewGuestbook"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewPoll"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewDirectMessage"></ComponentArt:PageView>
        <ComponentArt:PageView runat="server" ID="pageViewWebmailAccount">
            <asp:Panel runat="server" ID="panelWebmail">
            </asp:Panel>
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
</div>
</asp:Panel>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
	    setTimeout('CloseWindow()', 1000);

	    if (window.opener) {
	        var searchForm = window.opener.document.forms['ControlWrapper'];
	        if (searchForm) {
	            searchForm.submit();
	        }
	        else {
	            window.opener.location.href = window.opener.location.href;
	        }
	    }
		
		function CloseWindow()
		{
			window.close();
		}
		
	</script>
</asp:PlaceHolder>