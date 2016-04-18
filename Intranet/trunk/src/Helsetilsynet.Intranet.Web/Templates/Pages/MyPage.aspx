<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="MyPage.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.MyPage" %>
<%@ Register tagPrefix="Relate" tagName="EditProfile" src="~/Templates/Units/Static/EditProfile.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MyBookmarks" src="~/Templates/Units/Placeable/MyBookmarks.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MyContacts" src="~/Templates/Units/Placeable/MyContacts.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MyClubs" src="~/Templates/Units/Placeable/MyClubs.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MyInfo" src="~/Templates/Units/Placeable/UserContactInfo.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MySettings" src="~/Templates/Units/Placeable/MySettings.ascx" %>
<%@ Register tagPrefix="ht" tagName="LeftMenu" src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>

<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="profile" href="http://microformats.org/profile/hcard" />
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content section">
        <h1><span><%= GetTitle() %></span></h1>
        
        <Relate:MyInfo runat="server" ID="ucMyInfo" ShowDepartmentName="True" />

        <asp:Button runat="server" Visible="False" ID="btnEditUserAsAdmin" OnClick="btnEditUserAsAdmin_OnClick" Text="Rediger bruker"></asp:Button>

        <asp:Panel runat="server" ID="pnlPersonalInfo" Visible="<%# DisplayUser != CurrentUser %>" CssClass="extended-info">
            <h3><%= Translate("/personinformation/moreabouteducation") %></h3>
            <div><%= DisplayUser.GetMoreAboutEducation() %></div>
            
            <h3><%= Translate("/personinformation/moreaboutserviceareas") %></h3>
            <div><%= DisplayUser.GetMoreAboutServiceAreas() %></div>
            
            <h3><%= Translate("/personinformation/previousworkexperience")%></h3>
            <div><%= DisplayUser.GetPreviousWorkExperience() %></div>
        </asp:Panel>
        <Relate:EditProfile runat="server" ID="ucEditProfile" Visible="False" />
    </div>
    <div class="aside related">
	    <Relate:MyClubs runat="server" ID="ucMyClubs" />
	    <Relate:MyBookmarks runat="server" ID="ucMyBookmarks" Visible="False" ShowRemoveButton="True" />
        <Relate:MyContacts runat="server" ID="ucMyContacts" Visible="False" DisplayRemoveButton="True" />
        <asp:LinkButton CssClass="settings-link" runat="server" Visible="False" ID="btnOpenSettings" OnClick="btnOpenSettings_OnClick" Text="<%$ Resources: EPiServer, usercontrolheadings.mysettings %>" />
        <asp:PlaceHolder runat="server" ID="plhLogOut" Visible="False"><a Class="settings-link" href="<%= ResolveUrl("~/util/logout.aspx") %>" class="logout"><%= Translate("/login/logout")%></a></asp:PlaceHolder>
    </div>
    <ht:LeftMenu runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPopup" runat="server">
    <Relate:MySettings runat="server" ID="ucMySettings" Visible="False" />
</asp:Content>