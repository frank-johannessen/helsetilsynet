<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="WebmailControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<script type="text/javascript">
function confirm_delete()
{
    if (confirm("<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailControl.confirm") %>") == true)
    return true;
  else
    return false;
}
</script>

<script language="javascript" src="Administration.js"></script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <tr>
        <th colspan="2">
            <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailControl.MenuHeader") %>
        </th>
    </tr>
    <tr>
        <td class="menu">
            <button <% = (!AccessRights.Administrate || !WebMailServersAvailable ? "disabled" : "") %> class="button" onclick="SCWebmailOpenMailAccountInfo(-1, <%= this.User.ID %>);return false;">
                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailControl.buttonNewAccount") %></button>
        </td>
        <td class="epi-noPadding">
            <div id="webmail">
                <table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
                    <thead>
                        <tr>
                            <th align="left">
                                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailControl.HeaderMailServerName") %>
                            </th>
                            <th align="left">
                                &nbsp; &nbsp; &nbsp; &nbsp;
                            </th>
                            <th align="left">
                                <% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailControl.HeaderName") %>
                            </th>
                            <th align="left">
                                &nbsp;
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:DataList ID="dataListWebmailAccount" ItemStyle-VerticalAlign="Top" CellPadding="5" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server" DataKeyField="ID" OnDeleteCommand="dataListWebmailAccount_DeleteCommand">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%# AdministrationUtils.FormatString(((EPiServer.Community.Webmail.MailAccount)Container.DataItem).MailServer.Name) %>
                                    </td>
                                    <td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                                    <td>
                                        <%# AdministrationUtils.FormatString(((EPiServer.Community.Webmail.MailAccount)Container.DataItem).UserName) %>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="buttonRemove" runat="server" CssClass="button" CommandName="Delete"></asp:Button>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:DataList>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
</table>
