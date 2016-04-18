<%@ Page Language="c#" CodeBehind="default.aspx.cs" AutoEventWireup="True" Inherits="BVNetwork.FileNotFound.Admin.Default" %>
<%-- Sets the masterpage from the code behind file  --%>
<asp:Content ContentPlaceHolderID="HeaderContentRegion" runat="server">

</asp:Content>
<asp:Content ContentPlaceHolderID="MainRegion" runat="server">


Choose an XML file to be loaded into the Dynamic Data Store:
<asp:FileUpload id="xmlInput" runat="server"></asp:FileUpload>
    <asp:Button runat="server" id="btnLoad" Text="Load" OnClick="btnLoad_Click"></asp:Button> <br />
    <br />
     <asp:Button runat="server" id="btnDelete" Text="Delete all custom redirects" OnClick="btnDelete_Click" />
    <br />
    <br />
    <asp:Label id="lblInfo" runat="server" />
    <br />
    <br />
    <asp:Label id="lblListInfo" runat="server">
    The following list shows all active redirects on the site. When a user requests
    one of these and is redirected to the File Not Found handler (the custom 404 error
    page), the request is automatically redirected to the new url.
    </asp:Label>
    <br />
    
    <div>
        Handler Status: <asp:Label font-bold="true" id="lblHandlerStatus" runat="Server" />
    </div>
    <asp:Repeater ID="rptRedirects" runat="server">
        <HeaderTemplate>
            <table class="epi-default">
                <tr>
                    <th>
                        Old Url
                    </th>
                    <th>
                        &nbsp;
                    </th>
                    <th>
                        New Url
                    </th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td valign="top">
                    <a href="<%# DataBinder.Eval(Container.DataItem, "OldUrl") %>" target="_blank">
                        <%# DataBinder.Eval(Container.DataItem, "OldUrl") %>
                    </a>
                </td>
                <td valign="top" width="10">
                    <span>&nbsp;&nbsp;&rsaquo;&rsaquo;&nbsp;&nbsp;</span>
                </td>
                <td valign="top">
                    <a href="<%# DataBinder.Eval(Container.DataItem, "NewUrl") %>" target="_blank">
                        <%# DataBinder.Eval(Container.DataItem, "NewUrl") %>
                    </a>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>