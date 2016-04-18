<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="true" CodeBehind="Subscription.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.Subscription" %>
<%@ Register Assembly="Helsetilsynet" Namespace="Avenir" TagPrefix="cc1" %>
<asp:Panel ID="LoginAera" Visible="false"  runat="server">
    <fieldset>
        <div>
            <br />
            <asp:Label ID="Label3" Text="<%$ Resources: EPiServer, subscription.email %>" CssClass="topLabel" AssociatedControlID="EmailLogin" runat="server" />
            <asp:TextBox ID="EmailLogin" Width="200px" runat="server" /> 
            <asp:Literal ID="Msg" runat="server"></asp:Literal>

<%--			<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="EmailLogin" ErrorMessage="*" Runat="server" />
--%>         </div>
        <asp:Literal ID="Message" runat="server"></asp:Literal>
        <br />
    <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" OnClick="Login_Click" CssClass="button" 
            Text="Registrere eller endre abonnement" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
         <asp:Button ID="Button4" OnClick="Delete_Click" CssClass="button" 
            Text="Slette abonnement" runat="server" />
           
            
    </div>
    </fieldset>
</asp:Panel>
<asp:Panel ID="RecitAera" Visible="false"  runat="server">
    <fieldset>
        <div>
            Abonnement<br />
            Oppdraget er registrert. Velkommen tilbake.
        </div>
    </fieldset>
</asp:Panel>

<asp:Panel ID="SubscriptionArea" Visible="false" CssClass="subscriptionArea" runat="server">
    <fieldset>
        <div>
            <asp:Label ID="Label1" Text="<%$ Resources: EPiServer, subscription.email %>" CssClass="topLabel" AssociatedControlID="Email" runat="server" />
            <asp:TextBox ID="Email" ReadOnly="true" runat="server" />
        </div>
        <div>
            <asp:Label ID="Label2" Text="<%$ Resources: EPiServer, subscription.interval %>" CssClass="topLabel" AssociatedControlID="Interval" runat="server" />
            <asp:DropDownList ID="Interval" runat="Server">
                <asp:ListItem Value="0" Text="<%$ Resources: EPiServer, subscription.fastaspossible %>" />
                <asp:ListItem Value="1" Text="<%$ Resources: EPiServer, subscription.daily %>" />
                <asp:ListItem Value="7" Text="<%$ Resources: EPiServer, subscription.weekly %>" />
                <asp:ListItem Value="30" Text="<%$ Resources: EPiServer, subscription.monthly %>" />
            </asp:DropDownList>
        </div>
        <div class="subscriptionListArea">
            <label class="topLabel"><EPiServer:Translate ID="Translate1" Text="/subscription/subscription" runat="server" /></label>
            <EPiServer:SubscriptionList ID="SubscriptionList" runat="server" language="<%#CurrentPage.LanguageID%>" />
        </div>
    </fieldset>
    <div>
        <asp:Button ID="Button1" OnClick="Subscribe_Click" CssClass="button" Text="<%$ Resources: EPiServer, subscription.subscribe %>" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <asp:Button ID="Button3" OnClick="Delete2_Click" CssClass="button" 
            Text="Slette abonnement" runat="server" />


<%--        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Button3" OnClick="Delete_Click" CssClass="button" Text="Slett abonnement" runat="server" />
--%>    </div>
   
</asp:Panel>
 <br />