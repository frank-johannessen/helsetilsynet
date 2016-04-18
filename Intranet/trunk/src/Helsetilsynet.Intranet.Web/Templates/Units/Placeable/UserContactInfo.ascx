<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserContactInfo.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.UserContactInfo" %>
<%@ Import Namespace="EPiServer.Common.Security" %>
<%@ Import Namespace="EPiServer.DataAbstraction" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:ListView ID="lvUsersShort" ItemPlaceholderID="pnlItemContainer" runat="server" Visible="False" >
    <LayoutTemplate><asp:Panel ID="pnlItemContainer" runat="server" /></LayoutTemplate>
    <ItemTemplate><p><%# ((IUser)Container.DataItem).GetPresentationName() %> AVD: <%# ((IUser)Container.DataItem).GetDepartmentName()%></p></ItemTemplate>
</asp:ListView>

<asp:ListView ID="lvUsers" ItemPlaceholderID="pnlItemContainer" runat="server" OnItemDataBound="lvUsers_OnItemDataBound" >
    <LayoutTemplate>
        <asp:Panel ID="pnlItemContainer" runat="server" />
    </LayoutTemplate>
    <ItemTemplate>
        <div class="vcard">
            <img class="photo" src="<%# ((IUser)Container.DataItem).GetPortraitUri(Enums.ImageSize.Large).ToString() %>" alt="Portrait" />
            <div class="contact-info wrapper">
                <div>
                    <a class="url" href="<%# ((IUser)Container.DataItem).GetMyPageUri() %>"><span class="fn n"><span class="given-name"><%# ((IUser)Container.DataItem).GivenName %></span> <span class="family-name"><%# ((IUser)Container.DataItem).SurName %></span></span></a>
                    <span class="initials" runat="server" Visible="<%# ((IUser)Container.DataItem).GetInitials() != null && ((IUser)Container.DataItem).GetInitials() != String.Empty %>"><%# ((IUser)Container.DataItem).GetInitials()%></span>
                </div>
                <div class="clear"></div>
                <span class="title" runat="server" Visible="<%# ((IUser)Container.DataItem).GetTitle() != null && ((IUser)Container.DataItem).GetTitle() != String.Empty %>"><%# ((IUser)Container.DataItem).GetTitle()%></span>
                <span class="county" runat="server" Visible="<%# ((IUser)Container.DataItem).IsFylkesmann() && ((IUser)Container.DataItem).GetFylkesmannsEmbete() != null %>"><%# ((IUser)Container.DataItem).GetFylkesmannsEmbete() != null ? string.Format("{0} {1}", Translate("/personinformation/fylkesmannin"), ((IUser)Container.DataItem).GetFylkesmannsEmbete().Name) : string.Empty %></span>
                <span class="org organization-unit" runat="server" Visible="<%#ShouldDisplayDepartmentName((IUser)Container.DataItem) %>"><%# ((IUser)Container.DataItem).GetDepartmentName() %></span>
                <span class="adr" runat="server" Visible="<%# ((IUser)Container.DataItem).GetRoomNumber() != null && ((IUser)Container.DataItem).GetRoomNumber() != String.Empty && !((IUser)Container.DataItem).IsFylkesmann() %>"><span class="extended-address">rom <%# ((IUser)Container.DataItem).GetRoomNumber()%></span></span>
                <span class="tel1" runat="server" Visible="<%# !string.IsNullOrEmpty(((IUser)Container.DataItem).GetTelephone()) %>"><span class="extended-address"><%=Translate("/personinformation/telephoneshortcut")%> <%# ((IUser)Container.DataItem).GetTelephone()%></span></span>
                  <div class="clear">
                  <span class="tel" runat="server" Visible="<%# ((IUser)Container.DataItem).GetTelephone() != null && ((IUser)Container.DataItem).GetTelephone() != String.Empty %>"><span class="type">work</span><a href="tel:<%# ((IUser)Container.DataItem).GetTelephone() %>" class="value"><%# ((IUser)Container.DataItem).GetTelephone()%></a></span>
                  <span class="tel" runat="server" Visible="<%# ((IUser)Container.DataItem).GetMobile() != null && ((IUser)Container.DataItem).GetMobile() != String.Empty %>"><span class="type">cell</span><a href="tel:<%# ((IUser)Container.DataItem).GetMobile() %>" class="value"><%#((IUser)Container.DataItem).GetMobile()%></a></span>
                 </div>
                 <a href="<%# string.Format("mailto:{0}", ((IUser)Container.DataItem).EMail) %>" class="email"><%# ((IUser)Container.DataItem).EMail%></a>
            </div>     
            <div class="work-and-competence-description">
                <h2 class="heading"><%= Translate("/general/competenceworkareas")%></h2>
                <dl>
                    <asp:PlaceHolder runat="server" Visible="<%# ((IUser)Container.DataItem).GetServiceAreas() != null && ((IUser)Container.DataItem).GetServiceAreas().Count > 0 %>">
                        <dt class="label"><%= Translate("/personinformation/serviceareas")%></dt>
                        <asp:ListView ID="lvServiceAreas" ItemPlaceholderID="pnlItemContainerServiceAreas" runat="server">
                            <LayoutTemplate><asp:Panel ID="pnlItemContainerServiceAreas" runat="server" /></LayoutTemplate>
                            <ItemTemplate><dd><%# ((Category)Container.DataItem).Name %></dd></ItemTemplate>
                        </asp:ListView>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" Visible="<%# ((IUser)Container.DataItem).GetProfessions() != null && ((IUser)Container.DataItem).GetProfessions().Count > 0 %>">
                        <dt class="label"><%= Translate("/personinformation/profession")%></dt>
                        <asp:ListView ID="lvProfessions" ItemPlaceholderID="pnlItemContainerProfessions" runat="server">
                            <LayoutTemplate><asp:Panel ID="pnlItemContainerProfessions" runat="server" /></LayoutTemplate>
                            <ItemTemplate><dd><%# ((string)Container.DataItem) %></dd></ItemTemplate>
                        </asp:ListView>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" Visible="<%# ((IUser)Container.DataItem).GetSpecialties() != null && ((IUser)Container.DataItem).GetSpecialties().Count > 0 %>">
                        <dt class="label"><%= Translate("/personinformation/specialties")%></dt>
                        <asp:ListView ID="lvSpecialties" ItemPlaceholderID="pnlItemContainerSpecialties" runat="server">
                            <LayoutTemplate><asp:Panel ID="pnlItemContainerSpecialties" runat="server" /></LayoutTemplate>
                            <ItemTemplate><dd><%# ((string)Container.DataItem) %></dd></ItemTemplate>
                        </asp:ListView>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" Visible="<%# ((IUser)Container.DataItem).GetTasks() != null && ((IUser)Container.DataItem).GetTasks().Count > 0 %>">
                        <dt class="label"><%= Translate("/personinformation/tasks")%></dt>
                        <asp:ListView ID="lvTasks" ItemPlaceholderID="pnlItemContainerTasks" runat="server">
                            <LayoutTemplate><asp:Panel ID="pnlItemContainerTasks" runat="server" /></LayoutTemplate>
                            <ItemTemplate><dd><%# ((string)Container.DataItem) %></dd></ItemTemplate>
                        </asp:ListView>
                    </asp:PlaceHolder>
                </dl>
            </div>
        </div>
        <%# DivSeparator(Container.DataItemIndex) %>
    </ItemTemplate>      
</asp:ListView>

<asp:Panel runat="server" ID="pnlDisplayMoreResultsLink" Visible="false">
    <button class="show-more-results"><%= Translate("/general/showmore") %></button>
</asp:Panel>
