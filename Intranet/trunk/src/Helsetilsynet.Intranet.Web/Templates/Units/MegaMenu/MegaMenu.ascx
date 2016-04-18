<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MegaMenu.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MegaMenu" %>
<%@ Register tagPrefix="ht" tagName="tab1" src="./MegaMenuTab1.ascx" %>
<%@ Register tagPrefix="ht" tagName="tab2" src="./MegaMenuTab2.ascx" %>
<%@ Register tagPrefix="ht" tagName="tab3" src="./MegaMenuTab3.ascx" %>
<%@ Register tagPrefix="ht" tagName="tools" src="./MyTools.ascx" %>

	<ul class="mega-menu nav">
    	<li class="first"><ht:tab1 runat="server" /></li>
		<li class="second"><ht:tab2 runat="server" /></li>
		<li class="third"><ht:tab3 runat="server" /></li>
		<li class="my-tools"><ht:tools runat="server" /></li>
	</ul>