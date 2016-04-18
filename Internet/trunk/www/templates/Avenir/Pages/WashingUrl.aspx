<%@ Page Language="C#"  AutoEventWireup="true" Codebehind="WashingUrl.aspx.cs" Inherits="Avenir.Templates.Pages.WashingUrl" %>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="ROBOTS" content="noindex, follow" />
</head>

<body>
<form id="Form1" runat="server">
    <h1>Vask av Url</h1>
    
    <asp:button ID="Button1" runat="server" OnClick="Write_Click" text="Write" />
    <br /><br />
    <asp:button ID="Button2" runat="server" OnClick="Read_Click" text="Wash it" />
    <br /><br />
    <asp:Literal ID="Msg" runat="server"></asp:Literal>
</form>
</body>
</html>
