<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MySettings.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MySettings" %>

<div class="my-settings">
    <div class="wrapper">
        <h2 class="heading"><%= Translate("/usercontrolheadings/mysettings") %></h2>

        <p><%= Translate("/mysettings/description") %></p>
        <fieldset class="employee-category">
            <legend><%= Translate("/mysettings/frontpagesettings/description")%></legend>
            <div class="option">
                <asp:RadioButton runat="server" GroupName="rblWorkplace" ID="rbWorkplaceC1" />
                <asp:Label runat="server" Text="C1" AssociatedControlID="rbWorkplaceC1" />
                <div class="option-description">
                    <%= Translate("/mysettings/frontpagesettings/youget")%>
                    <ul>
                        <li><span><%= Translate("/mysettings/frontpagesettings/allnewsarticlearchive")%></span></li>
                        <li><span><%= Translate("/mysettings/frontpagesettings/calmayerscorner")%></span></li>
                    </ul>
                </div>
            </div>
            <div class="option">
                <asp:RadioButton runat="server" GroupName="rblWorkplace" ID="rbWorkplaceFylkesmannen" />
                <asp:Label runat="server" Text="Fylkesmannen" AssociatedControlID="rbWorkplaceFylkesmannen" />
                <div class="option-description">
                    <%= Translate("/mysettings/frontpagesettings/youget")%>
                    <ul>
                        <li><span><%= Translate("/mysettings/frontpagesettings/nonewsarticlearchive")%></span></li>
                        <li><span><%= Translate("/mysettings/frontpagesettings/notcalmayerscorner")%></span></li>
                    </ul>
                </div>
            </div>
        </fieldset>

        <fieldset>
            <legend><%= Translate("/mysettings/newsfeed") %></legend>
            
            <fieldset>
                <legend><%= Translate("/mysettings/serviceareadescription") %></legend>
                <asp:CheckBoxList CssClass="options" RepeatLayout="UnorderedList" runat="server" ID="cblServiceAreas" OnDataBound="cblServiceAreas_OnDataBound" />
            </fieldset>

            <fieldset>
                <legend><%= Translate("/mysettings/projectroomdescription") %></legend>
                <asp:CheckBoxList CssClass="options" RepeatLayout="UnorderedList" runat="server" ID="cblClubs" OnDataBound="cblClubs_OnDataBound" />
                <asp:Label runat="server" ID="EmptyProjectRoomText" Visible="False" />
            </fieldset>
            
            <fieldset runat="server" ID="fieldMembers">
                <legend><%= Translate("/mysettings/membersdescription") %></legend>
                <asp:CheckBoxList CssClass="options" RepeatLayout="UnorderedList" runat="server" ID="cblUsers" OnDataBound="cblUsers_OnDataBound" />
                <asp:Label runat="server" ID="EmptyMembersText" Visible="False" />
            </fieldset>
            
            <fieldset>
                <legend><%= Translate("/mysettings/rssfeed") %></legend>
                <asp:TextBox CssClass="rss-url" runat="server" ID="tbRssFeed" Columns="50" />
            </fieldset>
        </fieldset>

        <fieldset>
            <legend><%= Translate("/mysettings/toolboxdescription") %></legend>
            <asp:CheckBoxList CssClass="options" RepeatLayout="UnorderedList" runat="server" ID="cblExternalSystems" OnDataBound="cblExternalSystems_OnDataBound" />
        </fieldset>
        <div class="actions">
            <asp:button runat="server" OnClick="btnCancel_OnClick" Text="<%$ Resources: EPiServer, general.cancel %>" />
            <asp:Button runat="server" OnClick="btnSaveSettings_OnClick" ValidationGroup="vgSaveSettings" text="<%$ Resources: EPiServer, general.save %>" />
        </div>
    </div>
</div>