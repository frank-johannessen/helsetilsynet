<%@ Page Language="C#" EnableViewState="true"  AutoEventWireup="true" Codebehind="WashingHtml.aspx.cs" Inherits="Avenir.Templates.Pages.WashingHtml" %>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="ROBOTS" content="noindex, follow" />
</head>

<body>
<form id="Form1" runat="server">
    <h1>Vask av HTML</h1>
    Startpage:&nbsp;<asp:textbox ID="startpage" runat="server"></asp:textbox>&nbsp;(5499 / 6792)
     <br /><br />
    SidetypeId:&nbsp;<asp:textbox ID="txtPageTypeId" runat="server"></asp:textbox>
    &nbsp;eller sideId:&nbsp;<asp:textbox ID="txtPageId" runat="server"></asp:textbox>
    <br /><br />
    Feltnavn:&nbsp;<asp:textbox ID="txtField" runat="server"></asp:textbox>
    <br /><br />
     Regex 1:&nbsp;<asp:textbox ID="regex1" runat="server" Width="800px"></asp:textbox>
     <br />
     Replace:&nbsp;<asp:textbox ID="replace1" runat="server" Width="600px"></asp:textbox> &nbsp;# = slette funnet streng
    <br /><br />
   <asp:button ID="Button1" runat="server" OnClick="Write_Click" text="Write file" />
    <br /><br />
    <asp:button ID="Button2" runat="server" OnClick="Test_Click" text="Test html" />
    <br /><br />
    <asp:button ID="Button3" runat="server" OnClick="Execute_Click" text="Vask html" />
    <br /><br />
    
    
    <asp:Literal  ID="Msg" runat="server"></asp:Literal>
</form>
</body>
</html>
