<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="PhoneList.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.PhoneList" %>
<%@ Register TagPrefix="ht" TagName="LeftMenu" Src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>
<%@ Import Namespace="EPiServer.Common.Security" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="section main-content">
        <EPiServer:Property ID="Property1" runat="server" PropertyName="PageName" DisplayMissingMessage="False" CustomTagName="h1"/>
         <EPiServer:Property ID="Property3" runat="server" PropertyName="MainBody" DisplayMissingMessage="False" CssClass="article-body" />
        <asp:Repeater runat="server" ID="rptPhoneList">
            <HeaderTemplate>
                <table>
                    <thead>
                        <tr>
                            <th><%= Translate("/personinformation/name") %></th>    
                            <th><%= Translate("/personinformation/initials") %></th>    
                            <th class="phone"><%= Translate("/personinformation/telephone") %></th>
                            <th class="cell"><%= Translate("/personinformation/mobile") %></th>    
                            <th class="room"><%= Translate("/personinformation/roomnumber")%></th>    
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                 <tr>
                     <td><%# ((IUser)Container.DataItem).GetPresentationNameLastnameFirst(250) %></td>
                     <td><%# ((IUser)Container.DataItem).GetInitials() %></td>
                     <td class="phone"><%# ((IUser)Container.DataItem).GetTelephone() %></td>
                     <td class="cell"><%# ((IUser)Container.DataItem).GetMobile() %></td>
                     <td class="room"><%# ((IUser)Container.DataItem).GetRoomNumber() %></td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>

    <ht:LeftMenu runat="server" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPopup" runat="server">
</asp:Content>
