<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AlphabethicalEditor.ascx.cs" Inherits="Helsetilsynet.CustomProperties.htilDictionaryProperty.AlphabethicalEditor" %>
<%@ Register TagPrefix="EPiServerScript" Namespace="EPiServer.ClientScript.WebControls" Assembly="EPiServer, Version=6.1.379.0, Culture=neutral, PublicKeyToken=8fe83dea738b45b7" %>
<h1>Administrasjon av Emne overskrifter</h1>
<asp:Label runat="server" AssociatedControlID="txtNewAlphabethicalItemTitle">Emne</asp:Label>
<asp:TextBox ID="txtNewAlphabethicalItemTitle" runat="server" />
<asp:Label runat="server" AssociatedControlID="txtNewAlphabethicalItemUrl">Overskrift</asp:Label>
<asp:TextBox ID="txtNewAlphabethicalItemUrl" runat="server" />
<asp:Label runat="server" AssociatedControlID="txtNewAlphabethicalItemIngress">Ingress</asp:Label>
<asp:TextBox ID="txtNewAlphabethicalItemIngress" runat="server" />
<asp:Button ID="btnNewAlphabethicalItem" runat="server" Text="Legg til oppslag" OnClick="AddNewAlphabethicalItem" />
<br />
<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="ObjectDataSource1" EnableModelValidation="True" 
    BackColor="White" BorderColor="#999999" 
    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical"
    DataKeyNames="IdString">
    <AlternatingRowStyle BackColor="#DCDCDC" />
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
            CancelText="Avbryt" DeleteText="Slett" EditText="Endre" UpdateText="Lagre" />
        <asp:BoundField DataField="IdString" HeaderText="IdString" ReadOnly="True" 
            SortExpression="IdString" Visible="False" />
        <asp:BoundField DataField="Title" HeaderText="Tittel" SortExpression="Title" />
        <asp:BoundField DataField="Url" HeaderText="Url" SortExpression="Url" />
        <asp:BoundField DataField="Ingress" HeaderText="Ingress" SortExpression="Ingress" />
    </Columns>
    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
</asp:GridView>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    SelectMethod="GlobalKeywordList" 
    TypeName="Helsetilsynet.CustomProperties.htilDictionaryProperty.AlphabethicalUtils" 
    DataObjectTypeName="Helsetilsynet.CustomProperties.htilDictionaryProperty.AlphabethicalItem" 
    DeleteMethod="DeleteAlphabethicalItem" 
    UpdateMethod="UpdateAlphabethicalItem">
</asp:ObjectDataSource>
<asp:PlaceHolder runat="server" ID="plhDeleteAll">
    <p>Knappen nedenfor sletter alle oppslag. Det finnes ingen mulighet for å gjenopprette listen når den først er slettet. Tenk deg om før du trykker!</p>
    <asp:Button ID="btnDeleteAll" OnClick="DeleteAll" runat="server" Text="Slett alle oppslag" />
    <asp:Button ID="btnConformDeleteAll" OnClick="ConfirmDeleteAll" Text="Bekreft sletting" runat="server" Visible="false" />
</asp:PlaceHolder>
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent1" EventType="Click" EventTargetId="GridView1" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent2" EventType="Click" EventTargetId="btnNewAlphabethicalItem" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent3" EventType="Click" EventTargetId="btnDeleteAll" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent4" EventType="Click" EventTargetId="btnConformDeleteAll" runat="server" />    
