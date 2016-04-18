<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecurityEntryLink.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Security.SecurityEntryLink" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>

<asp:PlaceHolder runat="server" ID="PlaceHolderUser" Visible='<%# !Entry.IsGroup %>'>

<a class="entryLink" href='<%# Page.ResolveClientUrl("~/EPiServerCommunity/Security/EditUser.aspx") %>?task=load&userId=<%# Entry.ID %>'>
    <img src='<%# Page.ResolveClientUrl("~/EPiServerCommunity/Images/Security/user_small.gif") %>' alt='' />
    <span><%# AdministrationUtils.FormatString(Entry.Name) %></span>
</a>

</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="PlaceHolderGroup" Visible='<%# Entry.IsGroup %>'>

<a class="entryLink" href='<%# Page.ResolveClientUrl("~/EPiServerCommunity/Security/EditGroup.aspx") %>?task=load&groupId=<%# Entry.ID %>'>
    <img src='<%# Page.ResolveClientUrl("~/EPiServerCommunity/Images/Security/group_small.gif") %>' alt='' />
    <span><%# AdministrationUtils.FormatString(Entry.Name)%></span>
</a>

</asp:PlaceHolder>
