<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="WebmailMailServerControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailMailServerControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<script type="text/javascript">
function confirm_delete()
{
  if (confirm("<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerControl.confirm") %>")==true)
    return true;
  else
    return false;
}
</script>

<script language="javascript" src="Administration.js"></script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <tr>
        <th colspan="2">
            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerControl.MenuHeader") %>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="SCWebmailOpenMailServerInfo(-1);return false;">
                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServernControl.buttonNewMailServer") %></button>
        </td>
        <td class="epi-alignTop epi-noPadding">
            <div id="webmail">
                <table cellpadding="0" cellspacing="0" class="epi-default" style="width:100%;">
                    <tr>
                        <th align="left">
                            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerControl.HeaderName") %>
                        </th>
                        <th align="left">
                            &nbsp;
                        </th>
                    </tr>
                    <asp:DataList ID="dataListWebmailMailServer" ItemStyle-VerticalAlign="Top" CellPadding="5" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server" DataKeyField="ID" OnDeleteCommand="dataListWebmailMailServer_DeleteCommand">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <a href="javascript:SCWebmailOpenMailServerInfo(<%# ((EPiServer.Community.Webmail.MailServer)Container.DataItem).ID %>);">
                                        <%# AdministrationUtils.FormatString(((EPiServer.Community.Webmail.MailServer)Container.DataItem).Name) %></a>
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
