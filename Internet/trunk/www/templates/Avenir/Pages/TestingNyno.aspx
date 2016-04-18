<%@ Page Language="C#" EnableViewState="true"  AutoEventWireup="true" Codebehind="TestingNyno.aspx.cs" Inherits="Avenir.Templates.Pages.TestingNyno" %>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="ROBOTS" content="noindex, follow" />
</head>

<body>
<form id="Form1" runat="server">
    <h1>Test av Nyno Norsk Temasøk</h1>
    Opsjoner eksempel: pcharset=ISO-8859-1 pqsntx=standard pu=http://www.helsetilsynet.no
    <br />
     Opsjoner:&nbsp;<asp:textbox ID="tillegg" runat="server" Width="800px"></asp:textbox>
     <br />
     Query:&nbsp;<asp:textbox ID="query" runat="server" Width="1000px"></asp:textbox> 
    <br /><br />
   <asp:button ID="Button1" runat="server" OnClick="Test_Click" text="Kjør test" />
    <br /><br />
    <br /><br />
    <asp:Literal  ID="Msg" runat="server"></asp:Literal>
</form>
</body>
</html>
