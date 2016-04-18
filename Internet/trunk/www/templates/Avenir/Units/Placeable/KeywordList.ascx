<%@ Control Language="C#" AutoEventWireup="False" CodeBehind="KeywordList.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.KeywordList" %>
<div class="box topicBox" id="KeyBox" runat="server" >
	<%--<h2>Emner</h2>--%>
	<img class="topicImage" src="/templates/avenir/styles/gfx/topicDude.jpg" alt="Emner" />
    <%=GetKeywordList()%>
</div>	
