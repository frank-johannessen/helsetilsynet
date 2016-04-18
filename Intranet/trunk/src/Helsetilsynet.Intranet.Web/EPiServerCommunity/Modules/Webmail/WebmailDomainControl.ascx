<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="WebmailDomainControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailDomainControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<script type="text/javascript">
function confirm_delete()
{
  if (confirm("<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainControl.confirm") %>")==true)
    return true;
  else
    return false;
}
</script>

<script language="javascript" src="Administration.js"></script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <tr>
        <th colspan="2">
            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainControl.MenuHeader") %>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="SCWebmailOpenDomainInfo(-1);return false;">
                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainControl.buttonNewDomain") %></button>
        </td>
        <td valign="top" style="padding:0;">
            <div id="webmail">
                <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                    <tr>
                        <th align="left">
                            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainControl.HeaderName") %>
                        </th>
                        <th align="left">
                            &nbsp;
                        </th>
                    </tr>
                    <asp:DataList ID="dataListWebmailDomain" ItemStyle-VerticalAlign="Top" CellPadding="5" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server" DataKeyField="ID" OnDeleteCommand="dataListWebmailDomain_DeleteCommand">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# AdministrationUtils.FormatString(((EPiServer.Community.Webmail.Domain)Container.DataItem).Name) %>
                                </td>
                                <td align="right">
                                    <asp:Button ID="buttonRemove" runat="server" CssClass="button" CommandName="Delete"></asp:Button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:DataList>&nbsp;
                </table>
            </div>
        </td>
    </tr>
</table>
