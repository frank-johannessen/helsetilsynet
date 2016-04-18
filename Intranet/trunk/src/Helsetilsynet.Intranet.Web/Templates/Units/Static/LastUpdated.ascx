<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LastUpdated.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.LastUpdated" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<div class="lastupdated-date"><%= CurrentPage.StartPublish.FormatToShortDateString()%></div>
