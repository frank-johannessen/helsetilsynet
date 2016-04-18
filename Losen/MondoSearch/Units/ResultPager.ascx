<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ResultPager.ascx.cs" Inherits="BVNetwork.EPiMss.Units.ResultPager" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br>
<div style="width:17%;float:left">
	<asp:Label Runat="server" ID="lblPrevious" enableviewstate="False"/>
</div>
<div style="width:80%;float:left">
	<div style="float:left;text-align:center">
		<asp:Label Runat="server" ID="lblResultPager" enableviewstate="False"/>
	</div>
	<div style="width:20%;float:left;text-align:right">
		<asp:Label Runat="server" ID="lblNext" enableviewstate="False" />
	</div>
</div>
<br><br>