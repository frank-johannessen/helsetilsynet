<%@ Page Language="C#"  AutoEventWireup="false" Codebehind="GoogleIndex.aspx.cs" Inherits="Avenir.Templates.Pages.GoogleIndex" %>
<%@ Register TagPrefix="ht" TagName="Header"		Src="~/Templates/Avenir/Units/Static/Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">
<head runat="server" profile="http://www.w3.org/2005/10/profile"><link href="/App_Themes/Default/Styles/ToolButton.css" type="text/css" rel="stylesheet" /><link href="/WebResource.axd?d=iWGtGNum-JJ7AIAY3_F3C9BQfglrrHHFI4Jp5qLlTMKjHZ0oW3UYnBE_tI_HbfflqNqrWOdTYDlqn-doETCTtnDQxihwINYWWECjYaFrQlU1&amp;t=633989903733242276" type="text/css" rel="stylesheet" /><title>
	Indekseringsside - Helsetilsynet
</title>
    <%--<ht:Header ID="Header" runat="server" />--%>
    <%--<meta name="ROBOTS" content="noindex, follow" />--%>
</head>

<body>
    <asp:Literal ID="BodyText" runat="server"></asp:Literal>
</body>
</html>
<%--<asp:Content ContentPlaceHolderID="CenterArea" runat="server">--%>

<%--    <episerver:PropertySearch PageLink="<%#EPiServer.Core.PageReference.StartPage%>" runat="server" ID="PropertySearch1">
            <episerver:propertycriteria Name="DisplayOnFirstPage" Value="True" Type="Boolean"/>
    </episerver:PropertySearch>
    
    <episerver:PageList SortBy="PageName" DataSource="<%#PropertySearch1%>" runat="server" ID="PageList1">
            <ItemTemplate>
                    <episerver:property ID="Property1" PropertyName="PageName" runat="server"/>
                    <br/>
            </ItemTemplate>
    </episerver:PageList>    --%>
<%--</asp:Content>--%>