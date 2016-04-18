<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LinkReport.aspx.cs" Inherits="EPiCode.LinkReport.LinkReportAdmin" %>
<%@ Import Namespace="EPiCode.LinkReport" %>

<!DOCTYPE html PUBLIC "-//w3c//dtd html 4.0 transitional//en" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Link Report</title>
    <link rel="stylesheet" type="text/css" href="~/App_Themes/Default/Styles/system.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1 class="EP-systemHeading">
            Link Report
        </h1>
        <div style="color: #888; margin-bottom: 1em;">
            The "External Link Checker" will find all links on the site, and attempt to open the
            link as a web page, thus checking if the link is still valid. This is an in memory
            check only, and will not show any report below it the scheduled task has not been
            run, or the web site has been restarted since the last time the scheduled task was run.
        </div>
        <asp:Repeater ID="repReport" runat="server" DataSource='<%# LinkReportScheduledTask.LinkReportList %>'>
            <HeaderTemplate>
                <table class="epistandardtable" cellspacing="0" rules="all" border="1" id="Grid" style="border-collapse:collapse;">
                <tr>
                    <td class="epitableheading">Status</td>
                    <td class="epitableheading">Responding Page</td>
                    <td class="epitableheading">Error Message</td>
                    <td class="epitableheading">EPiServer Page</td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="EP-tableCellGrid">
                        <img src='<%# StatusImage(((string)DataBinder.Eval(Container.DataItem, "ErrorMessage"))) %>' />
                    </td>
                    <td class="EP-tableCellGrid"><a href='<%# DataBinder.Eval(Container.DataItem, "RespondentURL") %>' title='<%# DataBinder.Eval(Container.DataItem, "RespondentURL") %>' target="_blank">
                        <%# DataBinder.Eval(Container.DataItem, "PageTitle") %>                        
                    </a></td>
                    <td class="EP-tableCellGrid" style="color:Red"><%# DataBinder.Eval(Container.DataItem, "ErrorMessage") %></td>
                    <td class="EP-tableCellGrid"><a href='<%# DataBinder.Eval(Container.DataItem, "EditURL") %>' 
                    title='<%# DataBinder.Eval(Container.DataItem, "RequestedURL") %>' target="_blank">
                    <%# DataBinder.Eval(Container.DataItem, "PageName") %>
                    </a></td>
                </tr>
                
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litTest" />
    </div>
    </form>
</body>
</html>
