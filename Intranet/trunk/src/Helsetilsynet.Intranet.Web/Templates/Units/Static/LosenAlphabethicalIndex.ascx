<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LosenAlphabethicalIndex.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.LosenAlphabethicalIndex" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static" %>
<%@ Register tagPrefix="ht" tagName="losenItem" src="../Static/LosenAlphabethicalIndexItem.ascx" %>

<asp:Repeater runat="server" ID="rptLosenIndex">
    <HeaderTemplate>
        <div class="alphabetical-index">
            <h2><EPiServer:Translate runat="server" LocalizedText="/LosenIndex/heading" /></h2>
            <div class="index-wrapper">
                <ul>
    </HeaderTemplate>
    <ItemTemplate>
                    <li class='<%# ((LetterIndex)Container.DataItem).EntryCount < 1 ? "empty" : "letter" %>'>
                        <span id="alphaindex-letter-<%# ((LetterIndex)Container.DataItem).Letter %>"><%# CharToUpper(((LetterIndex)Container.DataItem).Letter) %></span>
                        <ht:losenItem runat="server" Items="<%# ((LetterIndex)Container.DataItem).Items %>" />
                    </li>
    </ItemTemplate>
    <FooterTemplate>
                </ul>
            </div>
        </div>
    </FooterTemplate>
</asp:Repeater>