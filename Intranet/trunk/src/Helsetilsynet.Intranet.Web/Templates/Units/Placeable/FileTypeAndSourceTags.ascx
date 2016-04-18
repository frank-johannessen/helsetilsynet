<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileTypeAndSourceTags.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.FileTypeAndSourceTags" %>
<span class="source-and-filetype-tags">
    <span runat="server" Visible="<%# DisplaySourceName(ResultElement) %>" class='<%# string.Format("tag-source {0}", GetSourceName(ResultElement))  %>'><span class="label">kilde: </span><%# GetSourceName(ResultElement)%></span>
    <span runat="server" Visible="<%# DisplayFileExtension(ResultElement) %>" class='<%# string.Format("tag-filetype {0}", GetFileExtension(ResultElement))  %>'><span class="label">filtype: </span><%# GetFileExtension(ResultElement) %></span>
</span>