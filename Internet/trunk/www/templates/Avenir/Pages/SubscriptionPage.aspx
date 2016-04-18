<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" AutoEventWireup="False" Codebehind="SubscriptionPage.aspx.cs" Inherits="Avenir.Templates.Pages.SubscriptionPage" %>
<%@ Register TagPrefix="ht" TagName="MainBody" Src="~/Templates/Avenir/Units/Placeable/MainBody.ascx" %>
<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server" >
    <ht:MainBody runat="server" Visible="false" />
    <asp:Panel ID="SubscriptionArea" Visible="false" CssClass="subscriptionArea" runat="server">
        <fieldset>
            <div>
                <asp:Label Text="<%$ Resources: EPiServer, subscription.email %>" CssClass="topLabel" AssociatedControlID="Email" runat="server" />
                <asp:TextBox ID="Email" runat="server" />
            </div>
            <div>
                <asp:Label Text="<%$ Resources: EPiServer, subscription.interval %>" CssClass="topLabel" AssociatedControlID="Interval" runat="server" />
                <asp:DropDownList ID="Interval" runat="Server">
                    <asp:ListItem Value="0" Text="<%$ Resources: EPiServer, subscription.fastaspossible %>" />
                    <asp:ListItem Value="1" Text="<%$ Resources: EPiServer, subscription.daily %>" />
                    <asp:ListItem Value="7" Text="<%$ Resources: EPiServer, subscription.weekly %>" />
                    <asp:ListItem Value="30" Text="<%$ Resources: EPiServer, subscription.monthly %>" />
                </asp:DropDownList>
            </div>
            <div class="subscriptionListArea">
                <label class="topLabel"><EPiServer:Translate Text="/subscription/subscription" runat="server" /></label>
                <EPiServer:SubscriptionList ID="SubscriptionList" runat="server" language="<%#CurrentPage.LanguageID%>" />
            </div>
        </fieldset>
        <div>
            <asp:Button OnClick="Subscribe_Click" CssClass="button" Text="<%$ Resources: EPiServer, subscription.subscribe %>" runat="server" />
        </div>
    </asp:Panel>
</asp:Content>