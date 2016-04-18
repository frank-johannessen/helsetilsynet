<%@ Page language="c#" Codebehind="NotFound.aspx.cs" AutoEventWireup="false" Inherits="Avenir.Templates.Pages.NotFound" EnableSessionState="false" EnableViewState="false" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="MainBody"	Src="~/Templates/Avenir/Units/Placeable/MainBody.ascx"%>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>

<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server">
    <ht:MainBody id="MainBody" runat="server"></ht:MainBody>
</asp:Content>