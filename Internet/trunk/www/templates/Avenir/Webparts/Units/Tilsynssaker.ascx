<%@ Control Language="C#" AutoEventWireup="false" 
            CodeBehind="Tilsynssaker.ascx.cs" 
            Inherits="Avenir.Templates.Webparts.Units.Tilsynssaker" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/GoogleShortList.ascx" %>

<div class="box">
	<h2>Tilsynssaker</h2>
    <ht:ChangedPages ID="ChangedPages" runat="server" />
	<p class="readMoreOtherPage"><a href="<%=getLink() %>">Se alle tilsynssaker</a></p>
</div>

