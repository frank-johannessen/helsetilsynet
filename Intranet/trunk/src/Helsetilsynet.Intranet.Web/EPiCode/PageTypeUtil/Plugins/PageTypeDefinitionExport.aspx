<%@ Page Language="c#" CodeBehind="PageTypeDefinitionExport.aspx.cs" AutoEventWireup="false"
    Inherits="EPiCode.PageTypeUtil.Plugins.PageTypeDefinitionExport" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Export Properties to XML File</title>
    <link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet" />
    <link href="<%= ShellPath %>ClientResources/Shell.css" type="text/css" rel="stylesheet" />
    <link href="<%= ShellPath %>ClientResources/ShellLightTheme.css" type="text/css"
        rel="stylesheet" />
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <div class="epi-contentContainer epi-padding">
        <h1>
            Export Properties to XML File</h1>
        <asp:Label Font-Bold="True" ForeColor="red" EnableViewState="False" ID="lblResult"
            Visible="False" runat="server" />
        <b>Source Page Type:</b>
        <br />
        <div style="padding-left: 20px;">
            <asp:Label ID="lblPageTypeName" runat="server" /><br />
            <br />
        </div>
        <div style="padding-left: 20px; color: gray;">
            Select the properties you wish to export.<br />
            Click
            <asp:LinkButton runat="server" ID="LinkButtonSelectAll">Select All</asp:LinkButton>
            and
            <asp:LinkButton runat="server" ID="LinkButtonSelectNone">Select None</asp:LinkButton>
            to toggle the selected checkboxes.
        </div>
        <asp:Repeater ID="rptPagetypesDef" runat="server" EnableViewState="true">
            <HeaderTemplate>
                <h2>
                    Properties</h2>
                <table border="0" cellpadding="2" cellspacing="0">
                    <thead>
                        <tr>
                            <td style="border-bottom: 1px solid gray;">
                                &nbsp;
                            </td>
                            <td style="border-bottom: 1px solid gray;">
                                <b>Name (ID)</b>
                            </td>
                            <td style="border-bottom: 1px solid gray;">
                                <b>Type</b>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:CheckBox runat="server" ID="chkImport" EnableViewState="true" Checked="True" />
                    </td>
                    <td>
                        <asp:Label ID="LabelName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="LabelEditCaption" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EditCaption") %>'
                            Visible="False" />
                        <asp:Label ID="LabelHelpText" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "HelpText") %>'
                            Visible="False" />
                        <asp:Label ID="LabelRequired" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Required") %>'
                            Visible="False" />
                        <asp:Label ID="LabelSearchable" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Searchable") %>'
                            Visible="False" />
                        <asp:Label ID="LabelLanguageSpecific" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LanguageSpecific") %>'
                            Visible="False" />
                        <asp:Label ID="LabelTab" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Tab.Name") %>'
                            Visible="False" />
                        <asp:Label ID="LabelTypeName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Type.Name") %>' />
                        <asp:Label ID="LabelTypeDataType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Type.DataType") %>'
                            Visible="False" />
                        <asp:Label ID="LabelTypeTypeName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Type.TypeName") %>'
                            Visible="False" />
                        <asp:Label ID="LabelTypeAssemblyName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Type.AssemblyName") %>'
                            Visible="False" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody> </table>
            </FooterTemplate>
        </asp:Repeater>
        <h2>
            XML File Details</h2>
        <div style="padding-left: 20px; padding-top: 5px; color: gray;">
            The file will be saved in the
            <%= System.Web.HttpContext.Current.Server.MapPath(EPiCode.PageTypeUtil.PropertyImport.Configuration.VirtualImportDirectory) %>
            folder.
        </div>
        <table>
            <tr>
                <td>
                    File Name:
                </td>
                <td>
                    <asp:TextBox runat="server" ID="TextboxFileName" Width="300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Import Info Name:
                </td>
                <td>
                    <asp:TextBox runat="server" ID="TextboxInfoName" Width="300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Import Info Description:
                </td>
                <td>
                    <asp:TextBox runat="server" ID="TextboxInfoDesc" TextMode="MultiLine" Width="300"
                        Height="50"></asp:TextBox>
                </td>
            </tr>
        </table>
        <asp:Button ID="cmdSave" runat="server" Text="Create XML File" />
    </div>
    </form>
</body>
</html>
