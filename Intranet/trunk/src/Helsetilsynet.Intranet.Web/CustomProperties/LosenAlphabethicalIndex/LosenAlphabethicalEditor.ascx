<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LosenAlphabethicalEditor.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex.LosenAlphabethicalEditor" %>
<%@ Register TagPrefix="EPiServerScript" Namespace="EPiServer.ClientScript.WebControls" Assembly="EPiServer, Version=6.1.379.0, Culture=neutral, PublicKeyToken=8fe83dea738b45b7" %>
<h1>Administrasjon av Losen A-Å</h1>
<asp:Label runat="server" AssociatedControlID="txtNewLosenAlphabethicalItemTitle">Tittel</asp:Label>
<asp:TextBox ID="txtNewLosenAlphabethicalItemTitle" runat="server"></asp:TextBox>
<asp:Label runat="server" AssociatedControlID="txtNewLosenAlphabethicalItemUrl">Url</asp:Label>
<asp:TextBox ID="txtNewLosenAlphabethicalItemUrl" runat="server"></asp:TextBox>
<asp:Button ID="btnNewLosenAlphabethicalItem" runat="server" Text="Legg til oppslag" OnClick="AddNewLosenAlphabethicalItem" />
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
    </Columns>
    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
</asp:GridView>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    SelectMethod="GlobalKeywordList" 
    TypeName="MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex.LosenAlphabethicalUtils" 
    DataObjectTypeName="MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex.LosenAlphabethicalItem" 
    DeleteMethod="DeleteLosenAlphabethicalItem" 
    UpdateMethod="UpdateLosenAlphabethicalItem">
</asp:ObjectDataSource>
<asp:PlaceHolder runat="server" ID="plhDeleteAll">
    <p>Knappen nedenfor sletter hele Losen A-Å (samtlige oppslag). Det finnes ingen mulighet for å gjenopprette listen når den først er slettet. Tenk deg om før du trykker!</p>
    <asp:Button ID="btnDeleteAll" OnClick="DeleteAll" runat="server" Text="Slett alle oppslag" />
    <asp:Button ID="btnConformDeleteAll" OnClick="ConfirmDeleteAll" Text="Bekreft sletting" runat="server" Visible="false" />
</asp:PlaceHolder>
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent1" EventType="Click" EventTargetId="GridView1" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent2" EventType="Click" EventTargetId="btnNewLosenAlphabethicalItem" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent3" EventType="Click" EventTargetId="btnDeleteAll" runat="server" />    
<EPiServerScript:ScriptDisablePageLeaveEvent ID="ScriptDisablePageLeaveEvent4" EventType="Click" EventTargetId="btnConformDeleteAll" runat="server" />    
