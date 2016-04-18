<%@ Page Language="C#"  AutoEventWireup="true" Codebehind="ListUsers.aspx.cs" Inherits="Helsetilsynet.templates.Avenir.Pages.ListUsers" %>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="ROBOTS" content="noindex, follow" />
</head>

<body>
<form id="Form1" runat="server">
    <h1>List brukere</h1>
    Gruppe:&nbsp;<asp:textbox ID="txtGroup" runat="server"></asp:textbox> &nbsp;Abonnement
    <br /><br />
    
    <asp:button ID="Button1" runat="server" OnClick="Write_Click" text="List users" />
    <br /><br />
      <asp:button ID="Button2" runat="server" OnClick="Sub_Click" text="List subscription" />
    <br /><br />
      <asp:button ID="Button3" runat="server" OnClick="Delete_Click" text="Delete Users" />
    <br /><br />
      <asp:button ID="Button4" runat="server" OnClick="Create_Click" text="CreateUsers" />
    <br /><br />
       <asp:button ID="Button5" runat="server" OnClick="Change_Click" text="Change latest" />
    <br /><br />
 <asp:Literal ID="Msg" runat="server"></asp:Literal>
</form>
</body>
</html>
