<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Links.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.Links" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>

<asp:Panel ID="IntLink" runat="server">
<div class="box">
	<h2 class="additionalInfo">Se også</h2>
	<div class="subBox">
		<ul>
	        <asp:Literal id="Interne" runat="server"></asp:Literal>
		</ul>
	</div>
<!-- end .box -->
</div>
</asp:Panel>


<asp:Panel ID="EkstLink" runat="server">
<div class="box">
	<h2 class="externalLink">Eksterne lenker</h2>
	
	<div class="subBox">
		<ul>
	        <asp:Literal id="Eksterne" runat="server"></asp:Literal>
		</ul>
	</div>
	
<!-- end .box -->
</div>
</asp:Panel>
