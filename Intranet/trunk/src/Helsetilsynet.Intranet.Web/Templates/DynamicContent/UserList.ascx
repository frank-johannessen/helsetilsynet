<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserList.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.UserList" %>
<%@ Register tagPrefix="Relate" tagName="DisplayUserCollection" src="~/Templates/Units/Placeable/UserContactInfo.ascx" %>

<relate:DisplayUserCollection runat="server" ID="ucDisplayUserCollection" DisplayRemoveButton="False"  />
<div style="clear: both"></div>