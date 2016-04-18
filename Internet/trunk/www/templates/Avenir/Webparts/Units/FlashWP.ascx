<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FlashWP.ascx.cs" Inherits="Avenir.Templates.Webparts.Units.FlashWP" %>

<asp:Panel runat="server">
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"
        width="<%=Width %>" height="<%=Height %>" title="<%=AtlText %>" >
        <param name="movie" value="<%=FlashURL.ToWebString() %>" />
        <param name="quality" value="high" />
        <param name="wmode" value="transparent" />
        <embed src="<%=FlashURL.ToWebString() %>" quality="high" wmode="transparent" 
            pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" 
            type="application/x-shockwave-flash" width="<%=Width %>" height="<%=Height %>" >
        </embed>
    </object>    
</asp:Panel>


