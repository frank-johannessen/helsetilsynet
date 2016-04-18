<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MetaTags.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.MetaTags" %>
<%= CreateMetaTag("keywords", CurrentPage["Keywords"]) %>
<%= CreateMetaTagDateTime("revised", CurrentPage["ToBeRevised"] as DateTime?, "yyyy-MM-dd") %>
<%= CreateMetaTag("description", GetDescription()) %>
<%--<%= CreateMetaTag("DC.Description", GetDescription()) %> test to see if the google mini takes this metattag.--%> 
<%= CreateMetaTag("imageurl", GetImageUrl(CurrentPage)) %>
<%= CreateMetaTagDateTime("last-modified", CurrentPage.Changed, "yyyy-MM-dd") %>
<%= CreateMetaTagDateTime("publication_date", CurrentPage.StartPublish, "yyyy-MM-dd") %>
<%= CreateMetaTagDateTime("creation_date", CurrentPage.StartPublish, "yyyy-MM-dd") %>
<%= CreateMetaTag("year", CurrentPage.StartPublish.Year) %>
<%= CreateMetaTag("kode", "losen-test") %> <%-- TODO: Set up with correct "kode" according to GoogleMini index --%>
<%= CreateMetaTag("pageid", CurrentPage.PageLink.ID)%>
<%= CreateMetaTag("parentid", GetParentLinkID())%>
<%= CreateMetaTag("dokumenttype", CurrentPage["DocumentType"]) %>
<%= CreateMetaTag("kategori", CurrentPage.Category) %>
<%= CreateMetaTagForCategoryIds("kategori-id", CurrentPage.Category) %>
<%= CreateMetaTag("DC.Type", CurrentPage["DocumentType"]) %>
<%= CreateMetaTag("DC.Publisher", "Statens helsetilsyn") %>
<%= CreateMetaTagHeading("DC.Title") %>
<%= CreateMetaTagFriendlyUrl("DC.Identifier.URL", CurrentPage) %>
<%= CreateMetaTag("google-site-verification", ((MakingWaves.Helsetilsynet.Intranet.Web.Model.BasePage)CurrentPage).GlobalSettings.GoogleSiteVerification) %>
<%= addEmulationTagOnProjectRoomForIE11() %>

<%--
<meta content="984V3ST1A?TKywaJsDm47/1MpOvW0P49sNPvHjkU/s=" name="verify-v1">
x <meta content="jHIQ2svFnq91_8V_K6F65JdG_7pr601qepuZs_IDc60" name="google-site-verification">
x <meta content="2012-05-10" name="publication_date">
x <meta content="2012-05-10" name="last-modified">
x <meta content="2012-05-10" name="revised">
x <meta content="Kataraktoperasjon, Forsvarlighet, Øyesykdommer, Advarsel, " name="keywords">
<meta content="Forsvarlighet,Spesialisthelsetjeneste" name="emne">
x <meta content="Vedtak i tilsynssak 2012." name="description">
x <meta content="Advarsel - Øyelege - kataraktoperasjon" name="DC.Title">
x <meta content="Statens helsetilsyn" name="DC.Publisher">
x <meta content="Htil" name="kode">
x <meta content="17832" name="pageid">
x <meta content="10932" name="parentid">
x <meta content="Vedtak tilsynssak" name="dokumenttype">
x <meta content="Vedtak tilsynssak" name="DC.Type">
x <meta content="2012" name="year">
<meta content="Lege" name="hpkategori">
<meta content="Advarsel" name="reaksjon">
<meta content="Spesialisthelsetjeneste - offentlig" name="tjeneste">
<meta content="Forsvarlig virksomhet undersøkelse diagnostikk og behandling" name="vurdering">
<meta content="Tilsyn" name="menugroup">
x <meta content="2012-05-10" name="creation_date">
x <meta content="http://www.helsetilsynet.no/no/Tilsyn/Tilsynssaker/Advarsel-Oyelege-kataraktoperasjon/" name="DC.Identifier.URL">
 --%>