<%@ Control Language="c#" AutoEventWireup="false" Codebehind="GoogleSearch.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.GoogleSearch" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>


<style type="text/css">
/*<![CDATA[*/
body * {
        FONT-FAMILY: verdana, sans-serif; FONT-SIZE: 13px
}
table * {
        FONT-FAMILY: verdana, sans-serif; FONT-SIZE: 13px
}
body {
        FONT-FAMILY: verdana, sans-serif; FONT-SIZE: 13px; background:#d9e5eb url(images/bg.png) repeat-x left top; margin:0; padding:0;
}
td {
        PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; VERTICAL-ALIGN: top; PADDING-TOP: 0px
}
table {
        BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BORDER-SPACING: 0px 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none
}
td.content {
        WIDTH: 70%; BORDER-RIGHT: rgb(204,204,204) 2px solid
}
#content {
        PADDING-BOTTOM: 10px; PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: 10px
}
#sidebar {
        PADDING-BOTTOM: 10px; PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: 10px
}
#sidebar h2 {
        BORDER-BOTTOM: rgb(204,204,204) 1px solid; MARGIN-TOP: 8px; MARGIN-BOTTOM: 8px; COLOR: rgb(51,51,51); FONT-SIZE: 11px
}
#sidebar a {
        BORDER-BOTTOM: rgb(221,204,204) 1px solid; LINE-HEIGHT: 20px; COLOR: rgb(204,0,0); TEXT-DECORATION: none
}
#sidebar a:hover {
        BORDER-BOTTOM: rgb(204,0,0) 2px solid
}
#searchForm input.gsc-input {
        BORDER-BOTTOM: rgb(204,204,204) 1px solid; BORDER-LEFT: rgb(204,204,204) 1px solid; PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; COLOR: rgb(51,51,51); BORDER-TOP: rgb(204,204,204) 1px solid; BORDER-RIGHT: rgb(204,204,204) 1px solid; PADDING-TOP: 2px
}
h1 {
        TEXT-ALIGN: center; PADDING-BOTTOM: 4px; FONT-FAMILY: arial, sans-serif; MARGIN-BOTTOM: 10px; COLOR: rgb(204,0,0); FONT-SIZE: 16px; BORDER-TOP: #e0e0e0 1px solid; FONT-WEIGHT: bold
}
h1 .tagline {
        COLOR: rgb(204,0,0); FONT-SIZE: 13px; CURSOR: pointer; FONT-WEIGHT: normal; TEXT-DECORATION: none
}
h1 a {
        COLOR: rgb(204,0,0); FONT-SIZE: 13px; CURSOR: pointer; FONT-WEIGHT: normal; TEXT-DECORATION: none
}
h1 a .tagline {
        COLOR: rgb(204,0,0); FONT-SIZE: 13px; CURSOR: pointer; FONT-WEIGHT: normal; TEXT-DECORATION: none
}
h1 a span.tagline {
        BORDER-BOTTOM: rgb(221,204,204) 1px solid; PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; PADDING-TOP: 2px
}
a span.tagline:hover {
        BORDER-BOTTOM: rgb(204,0,0) 2px solid; COLOR: rgb(204,0,0)
}
.gsc-control {
        WIDTH: 100%
}
#searchResults form.gsc-search-box {
        DISPLAY: none
}
#hKolonne form.gsc-search-box {
        DISPLAY: none
}
#e8e8e8
#branding {
        BACKGROUND-COLOR: #e8e8e8; WIDTH: 100%; PADDING-TOP: 10px
}
#searchResults .gsc-control {
        WIDTH: 100%
}
.wrapper { width:967px; margin:0 auto; }
.top { margin-top:27px; }
.top img { vertical-align:bottom; }
.main { background:#fff url(images/bunn.png) no-repeat left bottom; margin-bottom:20px; padding-bottom:13px; }

.gsc-resultsHeader td.gsc-twiddleRegionCell { width:90% !important; padding-bottom:4px; }
/*.gsc-resultsHeader td.gsc-configLabelCell { width:10%; }*/

/*]]>*/
</style>

<script type="text/javascript" src="https://www.google.com/jsapi">
</script>
<script type="text/javascript">
//<![CDATA[
      google.load('search', '1');
      var searchControl;
      var searchControl2;
      var start = true;

      function Tema(t) {
          sokInput.value = "";
          searchControl.execute(t);
      }

//      function Sok() {
//          if (start) {
//                searchControl2.draw(document.getElementById("hKolonne"));
//                start = false
//            }
//          searchControl.execute(sokInput.value);
//          searchControl2.execute(sokInput.value);

//      }
//      
      function OnLoad() {
        var extendedArgs = google.search.Search.RESTRICT_EXTENDED_ARGS;
        google.search.Search.getBranding(document.getElementById("branding"));

        var ht = new google.search.WebSearch();
        ht.setUserDefinedLabel(" Alle sider ");
        ht.setSiteRestriction("017123675700087879920:233obpcfm38");
        ht.setRestriction(extendedArgs, { lr: 'lang_no' });

        var htRapporter = new google.search.WebSearch();
        htRapporter.setUserDefinedLabel(" Tilsynsrapporter ");
        htRapporter.setSiteRestriction("017123675700087879920:233obpcfm38", "Tilsynsrapporter");
        htRapporter.setRestriction(extendedArgs, { lr: 'lang_no' });

        var htHendelse = new google.search.WebSearch();
        htHendelse.setUserDefinedLabel(" Hendelsesbasert tilsyn ");
        htHendelse.setSiteRestriction("017123675700087879920:233obpcfm38", "Hendelsesbasert tilsyn");
        htHendelse.setRestriction(extendedArgs, { lr: 'lang_no' });

        var htRegler = new google.search.WebSearch();
        htRegler.setUserDefinedLabel(" Lover og regler ");
        htRegler.setSiteRestriction("017123675700087879920:233obpcfm38", "Regelverk");
        htRegler.setRestriction(extendedArgs, { lr: 'lang_no' });

        var nyheter = new google.search.NewsSearch();
        nyheter.setUserDefinedLabel(" Nyheter ");

        var hd = new google.search.WebSearch();
        hd.setUserDefinedLabel(" Helsedirektoratet ");
        hd.setSiteRestriction("helsedirektoratet.no");

        var dd = new google.search.WebSearch();
        dd.setUserDefinedLabel(" Helse- og omsorgsdepartementet ");
        dd.setSiteRestriction("regjeringen.no/nb/dep/hod/");

        var ld = new google.search.WebSearch();
        ld.setUserDefinedLabel(" Lovdata ");
        ld.setSiteRestriction("lovdata.no");
       
        var bs = new google.search.BlogSearch();
        bs.setUserDefinedLabel(" Blogger ");

        var fhi = new google.search.WebSearch();
        fhi.setUserDefinedLabel(" Folkehelseinstituttet ");
        fhi.setSiteRestriction("fhi.no");

        var legemiddelv = new google.search.WebSearch();
        legemiddelv.setUserDefinedLabel(" Legemiddelverket ");
        legemiddelv.setSiteRestriction("legemiddelverket.no");

        var ws = new google.search.WebSearch();
        ws.setUserDefinedLabel(" Alle norske nettsteder ");

        var alleHelse = new google.search.WebSearch();
        alleHelse.setUserDefinedLabel(" Offentlige Helsenettsteder ");
        alleHelse.setSiteRestriction("017123675700087879920:233obpcfm38");
        
        searchControl = new google.search.SearchControl();
        searchControl.setLinkTarget(google.search.Search.LINK_TARGET_SELF);
        searchControl.setResultSetSize(google.search.Search.LARGE_RESULTSET);   
                                searchControl.addSearcher(ht);
                                searchControl.addSearcher(htRapporter);
                                searchControl.addSearcher(htHendelse);
                                searchControl.addSearcher(htRegler);

        var opLukket = new google.search.SearcherOptions();
        opLukket.setExpandMode(google.search.SearchControl.EXPAND_MODE_CLOSED);
        searchControl2 = new google.search.SearchControl();
        searchControl2.setLinkTarget(google.search.Search.LINK_TARGET_BLANK);
        searchControl2.addSearcher(alleHelse, opLukket);
        searchControl2.addSearcher(dd, opLukket);
        searchControl2.addSearcher(hd, opLukket);
        searchControl2.addSearcher(fhi, opLukket);
        searchControl2.addSearcher(legemiddelv, opLukket);
        searchControl2.addSearcher(ld, opLukket);
        searchControl2.addSearcher(ws, opLukket);
        searchControl2.addSearcher(bs, opLukket);
        searchControl2.addSearcher(nyheter, opLukket);
       

        var options = new google.search.DrawOptions();
        options.setDrawMode(GSearchControl.DRAW_MODE_TABBED);
        searchControl.draw(document.getElementById("searchResults"), options);
        if (sokInput.value != "") {
            searchControl2.draw(document.getElementById("hKolonne"));
//            alert("init funksjons");

        // Execute an inital search
            searchControl.execute(sokInput.value);
            searchControl2.execute(sokInput.value);
        }
     }

      google.setOnLoadCallback(OnLoad, true);

    //]]>
</script>
<style type="text/css">
/*<![CDATA[*/
 li.c2 {list-style: none}
 p.c1 {font-size: 80%}
/*]]>*/
</style>



<div class="wrapper">

<div class="main">
<div class="input"><input id="sokInput" type="text" size="10" value="" /> <input id="Button1" type="button" value=" søk " onclick="Sok()" />

<br /></div>
<table width="100%">
<tbody>
<tr>
<td class="content" valign="top" width="60%">
<div id="content">
<div id="searchResults">Loading...</div>
<!-- <div id=branding>Loading...</div> --></div>
</td>
<td class="sidebar" width="40%">
<div id="sidebar">
<br />
<br />
<div id="hKolonne">
</div>
<table width="94%">
<tr>
<td rowspan="5px">
<div id="branding"></div>
</td>
</tr>
</table>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>	
