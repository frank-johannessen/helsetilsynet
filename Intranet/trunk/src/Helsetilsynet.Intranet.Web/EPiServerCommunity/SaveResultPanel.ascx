<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="SaveResultPanel.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SaveResultPanel" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Panel ID="panelOK" CssClass="save ok" runat="server">
    <div class="img">
        &nbsp;</div>
    <span class="msg">
        <asp:Label ID="labelCustomSuccessText" runat="server"></asp:Label></span>    
</asp:Panel>
<asp:Panel ID="panelNOK" CssClass="save nok" runat="server">
    <div class="img">
        &nbsp;</div>
    <div class="msg">
        <div><asp:Literal ID="labelCustomFailedText" runat="server" /></div>
        <asp:ValidationSummary ID="validationSummary" CssClass="summary" runat="server" ForeColor="" DisplayMode="List"></asp:ValidationSummary>
    </div>
</asp:Panel>
<br>
<div style="clear: both">
</div>
