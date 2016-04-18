<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddUserToContacts.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.AddUserToContacts" %>

<asp:LinkButton runat="server" ID="lbAddToContacts" Text="<%$ Resources: EPiServer, bookmarks.addtomycontacts %>" OnClick="lbAddToContacts_OnClick" CssClass="action favorite" />
<asp:LinkButton runat="server" ID="lbRemoveFromContacts" Text="<%$ Resources: EPiServer, bookmarks.removefrommycontacts %>" OnClick="lbRemoveFromContacts_OnClick" Visible="False" CssClass="action favorite" />
