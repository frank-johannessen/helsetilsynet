<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BannerWP.ascx.cs" Inherits="Avenir.Templates.Webparts.Units.BannerWP" %>

<div>
    <a href="<%=getLink() %>" target="_blank" title="<%=getAltText() %>" >
        <img alt="<%=getAltText() %>" src="<%=getImgUrl() %>" width="<%=getWidth() %>" />
    </a>
</div>