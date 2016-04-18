<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ResultPager.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.ResultPager" %>
    <div class="results-paging">
    <asp:Repeater runat="server" Visible="<%# NumberOfPages > 1 %>" ID="rptPager">
        <HeaderTemplate>
            <ul>
            <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="<%# CurrentPagingNumber > 1 %>">
                <li><asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl='<%# GetPagingUrl(CurrentPagingNumber- 1) %>' Text="Forrige"/></li>
            </asp:PlaceHolder>
        </HeaderTemplate>
        <ItemTemplate>
            <li>
                <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="<%# (int)Container.DataItem == CurrentPagingNumber %>">
                    <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItem %>" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="PlaceHolder3" runat="server" Visible="<%# (int)Container.DataItem != CurrentPagingNumber %>">
                    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl='<%# GetPagingUrl((int)Container.DataItem) %>' Text="<%# Container.DataItem %>"/>
                </asp:PlaceHolder>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            <asp:PlaceHolder ID="PlaceHolder4" runat="server" Visible="<%# CurrentPagingNumber < NumberOfPages %>">
                <li><asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl='<%# GetPagingUrl(CurrentPagingNumber + 1) %>'  Text="Neste"/></li>
            </asp:PlaceHolder>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
    </div>