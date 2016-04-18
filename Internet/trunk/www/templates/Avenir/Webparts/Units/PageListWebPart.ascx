<%@ Control Language="C#" AutoEventWireup="false" 
            CodeBehind="PageListWebPart.ascx.cs" 
            Inherits="Avenir.Templates.Webparts.Units.PageListWebPart" %>
<%-- The title will only be shown if there are any pages in the list
and the title has been set for the web part. --%>
<div class="box">
    <asp:Panel ID="pnlTitle" runat="server">
        <h2><asp:Label ID="lblListTitle" runat="server" Font-Bold="true" /></h2>
    </asp:Panel>

    <%= MainBody.ToWebString() %>

    <%-- The PageLink is set in the prerender event from code behind --%>
    <episerver:pagelist runat="server" ID="lstPages">
        <ItemTemplate>
            <div style="margin-bottom: 1.0em;">
            <h3><EPiServer:Property 
                        PropertyName="PageLink" 
                        runat="server" /></h3>
            <%# Container.PreviewText %>
            <br clear="all" />
            </div>        
        </ItemTemplate>
        <FooterTemplate>
            <br />
        </FooterTemplate>
    </episerver:pagelist>
</div>