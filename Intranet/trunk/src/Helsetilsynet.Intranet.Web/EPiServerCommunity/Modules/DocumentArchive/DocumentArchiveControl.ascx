<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="DocumentArchiveControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.DocumentArchiveControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<input type="hidden" id="hiddenDocumentArchiveId" runat="server" name="hcategoryIddenDocumentArchiveId" />
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
    <tr>
        <th>
            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.DocumentArchive.MenuHeader") %>
        </th>
        <th>&nbsp;</th>
    </tr>
        <tr>
        <td class="menu">
            <asp:PlaceHolder ID="placeHolderUploadButton" runat="server">
                <button <% = (!AccessRights.Administrate ? "disabled" : "") %> onclick="SCDocumentArchiveOpenUploadWindow('<% = (DocumentArchive != null) ? DocumentArchive.ID : -1 %>', '<% = this.UniqueID %>'); return false;" class="button">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.DocumentArchive.buttonUpload") %></button>
            </asp:PlaceHolder>
            <asp:Button ID="buttonRemoveSelected" runat="server" Text="Remove Selected Documents" CssClass="button" />
            <div class="section">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.DocumentArchive.SubArchives") %></div>
            <asp:LinkButton ID="linkButtonParentArchive" runat="server" OnCommand="LinkButtonSubArchive_Command" Visible="False" CssClass="imageLink"></asp:LinkButton>
            <asp:Repeater ID="repeaterSubArchives" runat="server">
                <ItemTemplate>
                    <asp:LinkButton ID="linkButtonSubArchive" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="LinkButtonSubArchive_Command" CssClass="imageLink"><img src="images/folder_small.gif" border="0" /><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></asp:LinkButton><br />
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td class="epi-noPadding">
            <asp:PlaceHolder ID="placeHolderDocumentArchive" runat="server">
                <div id="documentArchive">
                    <table cellpadding="0" cellspacing="0" border="0" class="epi-default" style="width: 100%">
                        <tr>
                            <th>
                                <asp:LinkButton ID="linkButtonName" runat="server"></asp:LinkButton>
                            </th>
                            <th>
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.DocumentArchive.Header.Uploader") %>
                            </th>
                            <th>
                                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.DocumentArchive.Header.Size") %>
                            </th>
                            <th>
                                <asp:LinkButton ID="linkButtonDate" runat="server"></asp:LinkButton>
                            </th>
                        </tr>
                        <asp:Repeater ID="repeaterListDocuments" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input type="hidden" id="hiddenDocumentId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' name="hcategoryIddenDocumentId" />
                                        <asp:CheckBox ID="checkBoxAssociate" runat="server"></asp:CheckBox>
                                        <asp:LinkButton ID="linkButtonGetFile" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="linkButtonGetFile_Command"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></asp:LinkButton>
                                    </td>
                                    <td>
                                        <%# (DataBinder.Eval(Container.DataItem, "Author") != null && DataBinder.Eval(Container.DataItem, "Author.User") != null) ? "<a href=\"javascript:SCMyPageOpenEditUser(" + DataBinder.Eval(Container.DataItem, "Author.User.ID") + ");\">" + AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) + "</a>" : (DataBinder.Eval(Container.DataItem, "Author") != null) ? AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Author.Name")) : ""%>
                                    </td>
                                    <td>
                                        <asp:Label ID="labelSize" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </asp:PlaceHolder>
        </td>
    </tr>
</table>
