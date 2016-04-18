<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JoinClub.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.JoinClub" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:LinkButton ID="btnJoinClub" runat="server" OnClick="btnJoinClub_OnClick" Text="<%$ Resources: EPiServer, club.join %>" Visible="<%# !CurrentClub.IsClubMember(CurrentUser) %>" CssClass="action favorite" />
<asp:LinkButton ID="btnLeaveClub" runat="server" OnClick="btnLeaveClub_OnClick" Text="<%$ Resources: EPiServer, club.leave %>" Visible="<%# CurrentClub.IsClubMember(CurrentUser) %>" CssClass="action favorite" />
