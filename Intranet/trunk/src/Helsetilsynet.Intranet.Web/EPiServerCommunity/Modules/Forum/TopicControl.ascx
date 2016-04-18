<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="TopicControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.TopicControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<script language="javascript" src="js/StarSuite.js"></script>

<script src="Administration.js"></script>

<script language="javascript">
    SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.Title") %>');
</script>

<asp:Panel ID="panelTopicMain" runat="server" Visible="true">
    <asp:Button ID="buttonBackToRoom" runat="server" CssClass="button"></asp:Button>
    <table class="epi-default" cellspacing="0" cellpadding="0">
        <thead>
            <tr>
                <th valign="top">
                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.MenuHeader") %>
                </th>
                <th colspan="4" valign="top">
                    <asp:LinkButton ID="linkButtonRoom" runat="server" OnClick="LinkButtonRoom_Click"></asp:LinkButton>&nbsp;&gt;&nbsp;<% = TopicSubject %>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="menu">
                    <asp:Panel ID="panelMenu" runat="server">
                        <asp:Button ID="buttonRemoveSelectedReplies" Width="150px" runat="server" CssClass="button" OnClick="ButtonRemoveSelectedReplies_Click"></asp:Button><br />
                        <asp:Button ID="buttonLockTopic" runat="server" Width="150px" CssClass="button" OnCommand="ButtonMenu_Command" CausesValidation="False" CommandName="lock"></asp:Button><br />
                        <asp:Button ID="buttonPrioritize" runat="server" Width="150px" CssClass="button" OnCommand="ButtonMenu_Command" CausesValidation="False" CommandName="prioritize"></asp:Button><br />
                        <asp:Button ID="buttonAnnounce" runat="server" Width="150px" CssClass="button" Text="Announce / Unannounce" OnCommand="ButtonMenu_Command" CausesValidation="False" CommandName="announce"></asp:Button><br />
                        <asp:Button ID="buttonMoveTopic" CssClass="button" style="width: 150px" type="button" runat="server"/>                            
                    </asp:Panel>
                </td>
                <td class="epi-noPadding">
                    <table class="epi-default" cellpadding="0" cellspacing="0" border="0" width="100%" style="width: 100%;">
                        <tbody>
                            <asp:PlaceHolder ID="placeHolderDisplayTopic" runat="server">
                                <tr>
                                    <td align="center" width="32">
                                        <asp:Image ID="imageTopicState" runat="server" Width="16" Height="16" />
                                    </td>
                                    <td width="150">
                                        <strong>
                                            <% = TopicCreateDate %></strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="labelTopicSubject" runat="server" CssClass="editLabelBold"></asp:Label>&nbsp;<% = TopicAnnounced %><%= TopicPrioritized %>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="buttonEditTopic" runat="server" CssClass="button" OnCommand="ButtonEditTopic_Command"></asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px; height: 100px" valign="top" colspan="2">
                                        <strong>
                                            <% = TopicAuthor %></strong>
                                    </td>
                                    <td valign="top" colspan="2">
                                        <% = TopicText %><% = MovedToTopic %>
                                    </td>
                                </tr>
                            </asp:PlaceHolder>
                            
                            <asp:PlaceHolder ID="placeHolderEditTopic" runat="server" Visible="False">
                                <tr>
                                    <td align="center" width="32">
                                        <asp:Image ID="imageEditTopicState" runat="server" Width="16" Height="16" />
                                    </td>
                                    <td width="150">
                                        <strong>
                                            <% = TopicCreateDate %></strong>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textBoxTopicSubject" runat="server" CssClass="input" Width="400" MaxLength="500"></asp:TextBox><asp:RequiredFieldValidator ID="validatorTopicSubject" runat="server" ControlToValidate="textBoxTopicSubject" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;<% = TopicAnnounced %><%= TopicPrioritized %>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="buttonSaveTopic" runat="server" CssClass="button" OnCommand="ButtonSaveTopic_Command"></asp:Button>&nbsp;
                                        <asp:Button ID="buttonCancelEditTopic" runat="server" CssClass="button" OnCommand="ButtonCancelEditTopic_Command"></asp:Button><br />
                                        <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.RemoveTopic.confirm") %>');">
                                            <asp:Button ID="buttonRemove" runat="server" OnCommand="ButtonRemoveTopic_Command" CssClass="button" /></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px; height: 100px" valign="top" colspan="2">
                                        <strong>
                                            <% = TopicAuthor %></strong>
                                    </td>
                                    <td valign="top" colspan="2">
                                        <asp:TextBox ID="textBoxTopicText" runat="server" CssClass="input" Width="400" Height="200" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </asp:PlaceHolder>

                            <asp:PlaceHolder ID="placeHolderDirectEditReply" runat="server" Visible="false">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="labelReplyCreated" runat="server" /></strong>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textBoxReplySubject" runat="server" CssClass="input" Width="400" MaxLength="500" />
                                        <asp:RequiredFieldValidator ID="validatorReplySubject" runat="server" ControlToValidate="textBoxReplySubject" Display="None" EnableClientScript="False" />
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="buttonSaveReply" runat="server" CssClass="button" OnCommand="ButtonSaveReply_Command" /><br />
                                        <span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.RemoveReply.confirm") %>');">
                                            <asp:Button ID="buttonRemoveReply" runat="server" OnCommand="ButtonRemoveReply_Command" CssClass="button" /></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="height: 100px; width: 150px" colspan="2">
                                        <strong>
                                            <asp:Label ID="labelReplyAuthor" runat="server" /></strong>
                                    </td>
                                    <td valign="top" colspan="2">
                                        <asp:TextBox ID="textBoxReplyBody" runat="server" CssClass="input" TextMode="MultiLine" Width="400" Height="200" />
                                        <asp:RequiredFieldValidator ID="validatorReplyBody" runat="server" ControlToValidate="textBoxReplyBody" Display="None" EnableClientScript="False" />
                                    </td>
                                </tr>
                            </asp:PlaceHolder>

                            <asp:PlaceHolder ID="placeHolderReplies" runat="server">
                                <tr id="rowRepliesHeader" runat="server">
                                    <th colspan="4">
                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.Replies") %>
                                    </th>
                                </tr>
                                <tr id="rowPagingTop" runat="server">
                                    <td colspan="4">
                                        <sc:PagingControl ID="pagingControlTop" runat="server"></sc:PagingControl>
                                    </td>
                                </tr>
                                <asp:DataList ID="dataListReplies" runat="server" OnCancelCommand="DataListReplies_CancelCommand" OnUpdateCommand="DataListReplies_UpdateCommand" OnEditCommand="DataListReplies_EditCommand" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <ItemTemplate>
                                        <tr>
                                            <td width="16">
                                                <input type="hidden" id="hiddenReplyId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                                <asp:CheckBox ID="checkBoxSelected" runat="server" />
                                            </td>
                                            <td>
                                                <strong>
                                                    <%# EPiServer.Community.Web.Administration.AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></strong>
                                            </td>
                                            <td>
                                                <strong>
                                                    <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></strong>
                                            </td>
                                            <td align="right">
                                                <asp:Button ID="buttonEdit" runat="server" CommandName="Edit" CssClass="button" Enabled="<%# AccessRights.Administrate %>" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="height: 100px; width: 150px" colspan="2">
                                                <strong>
                                                    <%# GetAuthor((EPiServer.Common.IAuthor)DataBinder.Eval(Container.DataItem, "Author")) %></strong>
                                            </td>
                                            <td valign="top" colspan="2">
                                                <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Body")) %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <tr>
                                            <td width="16">
                                                <input type="hidden" id="hiddenReplyId" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                                                <asp:CheckBox ID="checkBoxSelected" runat="server" />
                                            </td>
                                            <td>
                                                <strong>
                                                    <%# EPiServer.Community.Web.Administration.AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="textBoxSubject" runat="server" CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "Header") %>' Width="400" MaxLength="500"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="validatorSubject" runat="server" ControlToValidate="textBoxSubject" Display="None" EnableClientScript="False" />
                                            </td>
                                            <td align="right">
                                                <asp:Button ID="buttonSave" runat="server" CssClass="button" CommandName="Update" />&nbsp;
                                                <asp:Button ID="buttonCancel" runat="server" CommandName="Cancel" CssClass="button" /><br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="height: 100px; width: 150px" colspan="2">
                                                <strong>
                                                    <%# GetAuthor((EPiServer.Common.IAuthor)DataBinder.Eval(Container.DataItem, "Author")) %></strong>
                                            </td>
                                            <td valign="top" colspan="2">
                                                <asp:TextBox ID="textBoxText" runat="server" CssClass="input" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container.DataItem, "Body") %>' Width="400" Height="200" />
                                                <asp:RequiredFieldValidator ID="validatorText" runat="server" ControlToValidate="textBoxText" Display="None" EnableClientScript="False" />
                                            </td>
                                        </tr>
                                    </EditItemTemplate>
                                </asp:DataList>
                                <tr id="rowPagingBottom" runat="server">
                                    <td colspan="4">
                                        <sc:PagingControl ID="pagingControlBottom" runat="server"></sc:PagingControl>
                                    </td>
                                </tr>
                            </asp:PlaceHolder>

                            <asp:PlaceHolder ID="placeHolderNewReply" runat="server">
                                <tr>
                                    <td class="epi-noPadding" colspan="4">
                                        <table class="epi-default" cellspacing="0" cellpadding="0" border="0" width="100%" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">
                                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.NewReply") %>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <td width="100">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.inputSubject") %>:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="textBoxSubject" runat="server" CssClass="input" Width="400" MaxLength="500"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="validatorSubject" runat="server" ControlToValidate="textBoxSubject" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Forum.Topic.inputText") %>:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="textBoxText" runat="server" CssClass="input" Width="400" Height="200" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="validatorText" runat="server" ControlToValidate="textBoxText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2">
                                                    <asp:Button ID="buttonCreateReply" runat="server" CssClass="button" OnClick="ButtonCreateReply_Click"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </asp:PlaceHolder>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    </table>
</asp:Panel>
