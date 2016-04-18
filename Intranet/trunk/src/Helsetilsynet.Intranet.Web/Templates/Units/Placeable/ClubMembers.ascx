<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ClubMembers.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.ClubMembers" %>
<%@ Register tagPrefix="Relate" tagName="ClubMembers" src="~/Templates/Units/Placeable/DisplayUserCollection.ascx" %>

<div class="section">
    <h2 class="heading"><%= Translate("/usercontrolheadings/projectmembers")%></h2>
    <relate:ClubMembers runat="server" ID="ucClubMembers" DisplayRemoveButton="False" />
</div>