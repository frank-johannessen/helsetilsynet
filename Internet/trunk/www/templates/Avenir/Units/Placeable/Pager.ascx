<%@ Control Language="C#" AutoEventWireup="False" CodeBehind="Pager.ascx.cs" Inherits="Avenir.Templates.Units.Static.Pager" %>

<div class="pageNavigator">
    <div  class="pageNavigatorWrapper">
    <asp:Literal ID="MoreResults" runat="server" EnableViewState="true" Visible="false" />
    <asp:Button id="n0" Visible="false" type="submit"  runat="server" Text=" << " OnClick="Nav_Click" /> 
    <asp:Button id="n1" Visible="false" type="submit" runat="server" Text=" 1 " OnClick="Nav_Click" /> 
    <asp:Button id="n2" Visible="false" type="submit" runat="server" Text=" 2 " OnClick="Nav_Click" /> 
    <asp:Button id="n3" Visible="false" type="submit" runat="server" Text=" 3 " OnClick="Nav_Click" /> 
    <asp:Button id="n4" Visible="false" type="submit" runat="server" Text=" 4 " OnClick="Nav_Click" /> 
    <asp:Button id="n5" Visible="false" type="submit" runat="server" Text=" 5 " OnClick="Nav_Click" /> 
    <asp:Button id="n6" Visible="false" type="submit" runat="server" Text=" 6 " OnClick="Nav_Click" /> 
    <asp:Button id="n7" Visible="false" type="submit" runat="server" Text=" 7 " OnClick="Nav_Click" /> 
    <asp:Button id="n8" Visible="false" type="submit" runat="server" Text=" 8 " OnClick="Nav_Click" /> 
    <asp:Button id="n9" Visible="false" type="submit" runat="server" Text=" >> " OnClick="Nav_Click" /> 
    </div>
</div>
