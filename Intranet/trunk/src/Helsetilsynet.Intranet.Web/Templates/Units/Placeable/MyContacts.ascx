<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyContacts.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MyContacts" %>
<%@ Register tagPrefix="Relate" tagName="DisplayUserCollection" src="~/Templates/Units/Placeable/DisplayUserCollection.ascx" %>

<div class="section my-contacts">
    <h2 class="heading"><%= Translate("/usercontrolheadings/mycontacts")%></h2>
    <Relate:DisplayUserCollection runat="server" ID="ucMyContacts" OnContactRemoved="ucMyContacts_ContactRemoved" />
</div>