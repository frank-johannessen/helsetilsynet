<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ResponsibleAuthor.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.ResponsibleAuthor" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<div><%= Translate("/general/responsible") %>:</div>
<div><%= !string.IsNullOrWhiteSpace(User.GetPresentationName()) ? User.GetPresentationName() : User.UserName %></div>
<asp:PlaceHolder runat="server" ID="phEmail" >
<div><span class="email-label"><%= Translate("/personinformation/email") %>: </span><%= GetEmailToShow() %></div>
</asp:PlaceHolder>  