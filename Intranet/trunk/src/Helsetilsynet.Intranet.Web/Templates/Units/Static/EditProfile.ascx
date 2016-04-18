<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.EditProfile" %>
<%@ Register tagPrefix="Relate" tagName="EditProfileContactInfo" src="~/Templates/Units/Static/EditProfileContactInfo.ascx" %>
<%@ Register tagPrefix="Relate" tagName="EditProfileCompetenceInfo" src="~/Templates/Units/Static/EditProfileCompetenceView.ascx" %>


<p style="color: green"><asp:Label runat="server" Visible="False" ID="lblEditProfileMessage" /></p>
<relate:EditProfileContactInfo runat="server" Visible="False" ID="ucEditProfileContactInfo" OnInfoSaved="Profileinfo_Saved" />

<relate:EditProfileCompetenceInfo runat="server" Visible="False" ID="ucEditProfileCompetenceInfo" OnInfoSaved="Competenceinfo_Saved" />