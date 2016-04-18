<%@ Control Language="C#" AutoEventWireup="false" 
            CodeBehind="Tilsynsrapporter.ascx.cs" 
            Inherits="Avenir.Templates.Webparts.Units.Tilsynsrapporter" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/GoogleShortList.ascx" %>

	<div class="box">
		<h2>Tilsynsrapporter</h2>
	    <ht:ChangedPages ID="ChangedPages" runat="server" />
	
<%= MainBody %>
</div>

