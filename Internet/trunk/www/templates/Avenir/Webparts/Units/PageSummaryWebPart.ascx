<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="PageSummaryWebPart.ascx.cs" Inherits="Avenir.Templates.KB.Webparts.Units.PageSummaryWebPart" %>

<a href="<%=getLinkUrl() %>" >
<img src="<%=getImgUrl() %>" alt="" class="introimage" /></a>
<div class="intro">
    <a href="<%=getLinkUrl() %>" >
    <h1>Rom for alle</h1></a>
    <div class="introtext">
        <%=getIntroText() %>
    </div>
</div>

