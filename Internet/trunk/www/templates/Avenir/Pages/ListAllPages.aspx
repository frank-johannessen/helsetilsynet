<%@ Page Language="C#"  AutoEventWireup="true" Codebehind="ListAllPages.aspx.cs" Inherits="Avenir.Templates.Pages.ListAllPages" %>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="ROBOTS" content="noindex, follow" />
</head>

<body>
<form id="Form1" runat="server">
<%--    <asp:button ID="Button1" runat="server" OnClick="Write_Click" text="Write" />
    <br /><br />
    <asp:button ID="Button2" runat="server" OnClick="Read_Click" text="Read" />
--%>    <br /><br />
    <asp:Literal ID="Msg" runat="server"></asp:Literal>
</form>
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