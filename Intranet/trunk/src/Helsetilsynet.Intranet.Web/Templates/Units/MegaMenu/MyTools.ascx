<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyTools.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MyTools" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>
<%@ Register tagPrefix="Relate" tagName="MyBookmarks" src="~/Templates/Units/Placeable/MyBookmarks.ascx" %>
<%@ Register tagPrefix="Relate" tagName="MyContacts" src="~/Templates/Units/Placeable/MyContacts.ascx" %>
<%@ Register tagPrefix="ht" tagName="externalSystem" src="./MegaMenuExternalSystem.ascx" %>
<a href="#my-tools-tab" id="my-tools-tab"><%= Translate("/usercontrolheadings/mytools")%></a>
<div class="header">
    <span class="name"><a style="color: white" href="<%= CurrentUser.GetMyPageUri() %>" title="<%= CurrentUser.GetPresentationName() %>"><%= CurrentUser.GetPresentationName() %></a></span>
    <a href="<%= CurrentUser.GetMyPageUri() %>" class="my-page"><%= Translate("/usercontrolheadings/mypage")%></a>
    <a href="<%= CurrentUser.GetMyPageUri() %>" title="<%= CurrentUser.GetPresentationName() %>">
        <img src="<%= CurrentUser.GetPortraitUri(Enums.ImageSize.Small) %>" alt="<%= CurrentUser.GetPresentationName() %>" />
    </a>
</div>
<div class="toolbox">
    <Relate:MyBookmarks runat="server" ID="ucMyBookmarks" ShowRemoveButton="False" ShowHelp="True" />
    
    <asp:ListView ID="lvExternalSystems" ItemPlaceholderID="pnlItemContainer" runat="server">
        <LayoutTemplate>
            <div class="section external-services">
                <asp:Panel ID="pnlItemContainer" runat="server" />
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <ht:externalSystem runat="server" ExternalSystem="<%# ((string)Container.DataItem) %>" />
        </ItemTemplate>       
    </asp:ListView>        
    
    <Relate:MyContacts runat="server" ID="ucMyContacts" DisplayRemoveButton="False" />
</div>