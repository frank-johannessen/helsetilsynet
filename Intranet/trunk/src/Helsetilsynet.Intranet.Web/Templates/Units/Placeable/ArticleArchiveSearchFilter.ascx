<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ArticleArchiveSearchFilter.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.ArticleArchiveSearchFilter" %>


<h2><%= Translate("/ArticleArchive/ArticleArchiveSearchFilter/Heading")%></h2>

<h3><%= Translate("/ArticleArchive/ArticleArchiveSearchFilter/ServicesList")%></h3>
<asp:CheckBoxList runat="server" ID="cblCategoryList" CssClass="article-archive-filter-categories" RepeatLayout="UnorderedList" AutoPostBack="true" ></asp:CheckBoxList>

<h3><%= Translate("/time/year") %></h3>
<asp:CheckBoxList runat="server" ID="cblYearList" CssClass="article-archive-filter-years" RepeatLayout="OrderedList" AutoPostBack="true"></asp:CheckBoxList>
