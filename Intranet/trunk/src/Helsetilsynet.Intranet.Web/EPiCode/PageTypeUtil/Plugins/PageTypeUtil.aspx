<%@ Page Language="c#" CodeBehind="PageTypeUtil.aspx.cs" AutoEventWireup="false"
    Inherits="EPiCode.PageTypeUtil.Plugins.PageTypePlugin" %>

<%@ Import Namespace="EPiServer.DataAbstraction" %>
<%@ Import Namespace="EPiServer.Configuration" %>
<style>
    .hidden
    {
        visibility: hidden;
        display: none;
    }
</style>

<script language="javascript" type='text/javascript'> 
<!--
    function hide(elemName) {
        //For ie6 use document.all[elemname]
        document.getElementById(elemName).style.visibility = "hidden";
        document.getElementById(elemName).style.display = "none";

    }
    function show(elemName) {
        document.getElementById(elemName).style.visibility = "visible";
        document.getElementById(elemName).style.display = "inline";
    }
    function toggle(elemName) {
        if (document.getElementById(elemName).style.visibility == "visible")
            hide(elemName);
        else
            show(elemName);
    }
//-->
</script>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
<head>
    <title>PageType Util</title>
    <link href="/App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet" />
    <link href="<%= ShellPath %>ClientResources/Shell.css" type="text/css" rel="stylesheet" />
    <link href="<%= ShellPath %>ClientResources/ShellLightTheme.css" type="text/css" rel="stylesheet" />

    <style type="text/css">
        td.datarow
        {
            border-bottom: 1px solid #dddddd;
        }
    </style>
</head>
<body>
    <form method="post" runat="server">
    <div class="epi-contentContainer epi-padding">
        <h1>
            Pagetype Utility</h1> 
        <asp:CheckBox ID="chkShowHidden" AutoPostBack="True" runat="server" Text="Show Hidden Pagetypes" />
        <asp:PlaceHolder runat="server" Visible='<%# lblResult.Visible %>'>
            <p>
                <asp:Label Font-Bold="True" ForeColor="red" EnableViewState="False" ID="lblResult"
                    Visible="False" runat="server" /></p>
        </asp:PlaceHolder>
        <asp:Repeater ID="rptPagetypes" runat="server" EnableViewState="true">
            <HeaderTemplate>
                <h2>
                    Pagetypes</h2>
                <table border="0" cellpadding="0" cellspacing="0">
                    <thead>
                        <tr>
                            <td valign="bottom" style="border-bottom: 1px solid gray;">
                                <b>Index</b>&nbsp;
                            </td>
                            <td valign="bottom" style="border-bottom: 1px solid gray;">
                                <b>Visible</b>&nbsp;
                            </td>
                            <td valign="bottom" style="border-bottom: 1px solid gray;">
                                <b>Name (id)</b>
                            </td>
                            <td valign="bottom" align="center" style="border-bottom: 1px solid gray; padding-right: 4px;">
                                <nobr></nobt><b>Number of<br />Pages</b></nobr>
                            </td>
                            <td valign="bottom" align="center" style="border-bottom: 1px solid gray;">
                                <nobr><b>Number of<br />Page Versions</b></nobr>
                            </td>
                            <td valign="bottom" style="border-bottom: 1px solid gray;">
                                &nbsp;
                            </td>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td valign="top">
                        <asp:TextBox MaxLength="10" Width="40" runat="server" EnableViewState="true" ID="txtIndex"
                            Text='<%# DataBinder.Eval(Container.DataItem, "SortOrder") %>'>
                        </asp:TextBox>
                    </td>
                    <td align="center" valign="top" class="datarow">
                        <asp:CheckBox ID="chkVisible" EnableViewState="true" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "IsAvailable") %>' />
                    </td>
                    <td valign="center" class="datarow">
                        <a href="<%# EPiServer.UriSupport.ResolveUrlFromUIBySettings("admin/EditPageType.aspx?typeid=" + DataBinder.Eval(Container.DataItem, "ID")) %>">
                            <%# DataBinder.Eval(Container.DataItem, "Name") %>
                        </a>(<a href="<%# EPiServer.UriSupport.ResolveUrlFromUIBySettings("admin/EditPageTypeBase.aspx?typeid=" + DataBinder.Eval(Container.DataItem, "ID")) %>">Edit</a>)
                        &nbsp;(<asp:Label ID="lblPageTypeID" runat="server" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />)
                        <asp:PlaceHolder runat="server" Visible='<%# GetNumberOfPagesForPageType((int)DataBinder.Eval(Container.DataItem, "ID")) > 0%>'>
                            <a href="#" title='<%# GetNumberOfPagesForPageType((int)DataBinder.Eval(Container.DataItem, "ID")) %>'
                                onclick="toggle('divpageids<%#DataBinder.Eval(Container.DataItem, "ID") %>')">[Show
                                Pages]</a> </asp:PlaceHolder>
                        <div id='divpageids<%# DataBinder.Eval(Container.DataItem, "ID") %>' class="hidden">
                            <asp:Repeater runat="server" ID="pageids" DataSource='<%# GetPageIdsForPageType((int)DataBinder.Eval(Container.DataItem, "ID")) %>'>
                                <HeaderTemplate>
                                    <div style="margin: 4px 0px 4px 0px; padding: 0px 0px 4px 8px; border: solid 1px #c0c0c0;
                                        background-color: #f8f8f8; width:100%;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <a href='<%# EPiServer.UriSupport.ResolveUrlFromUIBySettings("edit/?id=" + DataBinder.Eval(Container.DataItem, "pkID")) %>'
                                        title='<%# GetPageName((int)DataBinder.Eval(Container.DataItem, "pkID")) %>'
                                        target="_blank">
                                        <%# DataBinder.Eval(Container.DataItem, "pkId")%></a>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <br />
                                    <span style="color: #888;">Hoover mouse over ID to see name of page. Click to edit page
                                        in new window. This list only shows 50 pages. </span></div>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <a href="#" onclick="toggle('divpagetypeids<%#DataBinder.Eval(Container.DataItem, "ID") %>')">
                            [Available Page Types]</a>
                        <div id='divpagetypeids<%# DataBinder.Eval(Container.DataItem, "ID") %>' class="hidden">
                            <asp:Repeater ID="rptAvaiablePagetypes" runat="server" OnItemCommand="rptAvailablePageTypes_ItemCommand"
                                DataSource='<%# GetAvailablePageTypes((int)DataBinder.Eval(Container.DataItem, "ID")) %>'>
                                <HeaderTemplate>
                                    <div style="margin: 4px 0px 4px 0px; padding: 0px 0px 4px 8px; border: solid 1px #c0c0c0;
                                        background-color: #f8f8f8;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div style="width: 200px;">
                                        <asp:Label Style="display: none" runat="server" ID="lblPageTypeID" Text='<%#   DataBinder.Eval(Container.DataItem, "ID") %>' />
                                        <asp:CheckBox runat="server" ID="chkAvaliable" Text='<%#  DataBinder.Eval(Container.DataItem, "Name") %>'
                                            Checked='<%# AllowedPageType((PageType)Container.DataItem) %>' />
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <br />
                                    <span style="color: #888;"></span>
                                    <asp:LinkButton ID="lnk" runat="server" CommandArgument='<%# _mainPageType.ID %>'
                                        Text="Save">
                                    </asp:LinkButton>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </td>
                    <td class="datarow">
                        <%# GetNumberOfPagesForPageType((int)DataBinder.Eval(Container.DataItem, "ID")) %>
                    </td>
                    <td class="datarow">
                        <%# GetNumberOfWorkPagesForPageType((int)DataBinder.Eval(Container.DataItem, "ID")) %>
                    </td>
                    <td valign="center" class="datarow">
                        <nobr>
                        &nbsp;<a href="PageTypeDefinitionCopy.aspx?pagetypeid=<%# DataBinder.Eval(Container.DataItem, "ID") %>"
                            title="Copy properties from this Page Type to another one">[Copy Properties]</a>                            
                            &nbsp;<a href="PageTypeDefinitionExport.aspx?pagetypeid=<%# DataBinder.Eval(Container.DataItem, "ID") %>"
                                title="Export properties to a XML file from this Page Type">[Export]</a> &nbsp;<a
                                    href="pagetypedefinitionutil.aspx?pagetypeid=<%# DataBinder.Eval(Container.DataItem, "ID") %>"
                                    title="Import properties from a xml file to this Page Type">[Import]</a>
                        </nobr>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <br />
        <asp:Button ID="cmdSave" Text="Save" runat="server" />
    </form>
    </div>
    <br>
    <br>
</body>
</html>
