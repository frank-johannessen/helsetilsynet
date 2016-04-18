<%@ Control Language="C#" EnableViewState="false" AutoEventWireup="False" CodeBehind="SubMenu.ascx.cs" Inherits="Avenir.Templates.Units.Static.SubMenu" %>
<%@ Register TagPrefix="ht" TagName="BreadCrumbs"		Src="~/Templates/Avenir/Units/Static/BreadCrumbs.ascx" %>

<div class="mainMenuSubLevelsAndBreadcrumbs<%=GetBread() %>">
    <ht:BreadCrumbs runat="server" ID="BreadCrumbs" Visible="false" />
    <div id="mainMenuSubLevels">
    <%-- style="display: block;"--%>
        <%=GetLeftMenu() %>
    </div>
</div>