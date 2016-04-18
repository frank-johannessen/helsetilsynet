<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="RoomControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.RoomControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="TopicControl" Src="TopicControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>
<!--<link rel="stylesheet" type="text/css" href="Administration.css" >-->

<script language="javascript" src="js/StarSuite.js"></script>

<script src="Administration.js"></script>

<script language="javascript">
	SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.Title") %>');
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<asp:PlaceHolder ID="placeHolderTopics" runat="server">
    <asp:Panel ID="panelValidators" runat="server" Visible="False">
        <asp:RequiredFieldValidator ID="validatorSubject" runat="server" ControlToValidate="textBoxSubject" Display="None" EnableClientScript="False" />
    </asp:Panel>
    <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
        <thead>
            <tr>
                <th>
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.MenuHeader") %>
                </th>
                <th>
                    <% = (Room != null) ? AdministrationUtils.FormatString(Room.Header) : "" %>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="menu">
                    <asp:Button ID="buttonRemoveSelectedTopics" runat="server" CssClass="button" CausesValidation="False" OnClick="ButtonRemoveSelectedTopics_Click" />
                </td>
                <td class="epi-noPadding">
                    <table class="epi-default" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;">
                        <thead>
                            <tr>
                                <th width="16">
                                    &nbsp;
                                </th>
                                <th width="16">
                                    &nbsp;
                                </th>
                                <th align="left" colspan="2">
                                    <asp:LinkButton ID="linkButtonSubject" runat="server"></asp:LinkButton>
                                </th>
                                <th align="left">
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.By") %>
                                </th>
                                <th align="left">
                                    <asp:LinkButton ID="linkButtonLastReply" runat="server"></asp:LinkButton>
                                </th>
                                <th align="left">
                                    <asp:LinkButton ID="linkButtonReplies" runat="server"></asp:LinkButton>
                                </th>
                                <th align="left">
                                    <asp:LinkButton ID="linkButtonViews" runat="server"></asp:LinkButton>
                                </th>
                                <th align="left">
                                    <asp:LinkButton ID="linkButtonDate" runat="server"></asp:LinkButton>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr runat="server" id="rowPagingTop">
                                <td colspan="9">
                                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                                </td>
                            </tr>
                            <asp:Repeater ID="repeaterTopics" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td width="16">
                                            <input type="hidden" id="hiddenTopicId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' /><asp:CheckBox ID="checkBoxSelected" runat="server" />
                                        </td>
                                        <td class="icon">
                                            <asp:Image ID="imageState" runat="server" ImageUrl='<%# ((bool)DataBinder.Eval(Container.DataItem, "Locked") ? "images/locked.gif" : "images/topic.gif") %>' Width="16" Height="16" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="linkButtonTopic" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="LinkButtonTopic_Command"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></asp:LinkButton>
                                        </td>
                                        <td>
                                            <%# ((bool)DataBinder.Eval(Container.DataItem, "Announced") ? "[" + EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.Announced") + "]"  : "") %>
                                            <%# ((bool)DataBinder.Eval(Container.DataItem, "Prioritized") ? "[" + EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.Prioritized") + "]" : "") %>&nbsp;
                                            <%# (DataBinder.Eval(Container.DataItem, "MovedToTopic") != null && ((EPiServer.Community.Forum.Topic)DataBinder.Eval(Container.DataItem, "MovedToTopic")).Room != null ? "[<a href=\"javascript:SCForumOpenRoomWindow(" + ((EPiServer.Community.Forum.Topic)DataBinder.Eval(Container.DataItem, "MovedToTopic")).Room.ID + ", " + ((EPiServer.Community.Forum.Topic)DataBinder.Eval(Container.DataItem, "MovedToTopic")).ID + ");\">" + EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.Moved") +  "</a>]" : "") %>
                                        </td>
                                        <td>
                                            <%# GetAuthor((EPiServer.Common.IAuthor)DataBinder.Eval(Container.DataItem, "Author")) %>&nbsp;
                                        </td>
                                        <td>
                                            <%# GetLastReply((EPiServer.Community.Forum.Topic)Container.DataItem) %>&nbsp;
                                        </td>
                                        <td>
                                            <%# DataBinder.Eval(Container.DataItem, "NumReplies") %>
                                        </td>
                                        <td>
                                            <%# DataBinder.Eval(Container.DataItem, "NumViews")%>
                                        </td>
                                        <td align="left">
                                            <%# EPiServer.Community.Web.Administration.AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr runat="server" id="rowPagingBottom">
                                <td colspan="9">
                                    <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <asp:PlaceHolder ID="placeHolderNewTopic" runat="server">
        <br />
        <table border="0" cellpadding="0" cellspacing="0" class="epi-default">
            <thead>
                <tr>
                    <td colspan="2">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.NewTopic") %>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td width="100">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.inputSubject") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxSubject" runat="server" CssClass="input" Width="400" MaxLength="500" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.inputText") %>:
                    </td>
                    <td>
                        <asp:TextBox ID="textBoxText" runat="server" CssClass="input" TextMode="MultiLine" Width="400" Height="200" /><br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Room.inputPriority") %>:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="radioButtonListPriority" CssClass="input" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <asp:Button ID="buttonCreateTopic" runat="server" CssClass="button" OnClick="ButtonCreateTopic_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
    </asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="placeHolderTopic" runat="server" Visible="False">
    <sc:TopicControl ID="topicControl" runat="server" />
</asp:PlaceHolder>
<sc:NoEntityError runat="server" ID="NoEntityError" />