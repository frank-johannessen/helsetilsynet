      var searchControl;
      var searchControl2;
      var start = true;
      google.load('search', '1');


      function OnLoad() {
          //return;
        var extendedArgs = google.search.Search.RESTRICT_EXTENDED_ARGS;
        google.search.Search.getBranding(document.getElementById("branding"));

        var hb = new google.search.WebSearch();
        hb.setUserDefinedLabel(" Helsebiblioteket ");
        hb.setSiteRestriction("helsebiblioteket.no/");

        var bl = new google.search.WebSearch();
        bl.setUserDefinedLabel(" Barne-, likestillings- og inkluderingsdepartementet BLD");
        bl.setSiteRestriction("regjeringen.no/nb/dep/bld.html?id=298");

        var bu = new google.search.WebSearch();
        bu.setUserDefinedLabel(" Bufetat ");
        bu.setSiteRestriction("bufetat.no/");

        var hd = new google.search.WebSearch();
        hd.setUserDefinedLabel(" Helsedirektoratet ");
        hd.setSiteRestriction("helsedirektoratet.no");

        var dd = new google.search.WebSearch();
        dd.setUserDefinedLabel(" Helse- og omsorgsdep. ");
        dd.setSiteRestriction("regjeringen.no/nb/dep/hod/");

        var ld = new google.search.WebSearch();
        ld.setUserDefinedLabel(" Lovdata ");
        ld.setSiteRestriction("lovdata.no");
       

        var fhi = new google.search.WebSearch();
        fhi.setUserDefinedLabel(" Folkehelseinstituttet ");
        fhi.setSiteRestriction("fhi.no");

        var legemiddelv = new google.search.WebSearch();
        legemiddelv.setUserDefinedLabel(" Legemiddelverket ");
        legemiddelv.setSiteRestriction("legemiddelverket.no");

        var ws = new google.search.WebSearch();
        ws.setUserDefinedLabel(" Alle norske nettsteder ");


        var opLukket = new google.search.SearcherOptions();
        opLukket.setExpandMode(google.search.SearchControl.EXPAND_MODE_CLOSED);
        searchControl2 = new google.search.SearchControl();
        searchControl2.setLinkTarget(google.search.Search.LINK_TARGET_BLANK);
        searchControl2.addSearcher(bl, opLukket);
        searchControl2.addSearcher(bu, opLukket);
        searchControl2.addSearcher(fhi, opLukket);
        searchControl2.addSearcher(dd, opLukket);
        searchControl2.addSearcher(hd, opLukket);
        searchControl2.addSearcher(hb, opLukket);
        searchControl2.addSearcher(legemiddelv, opLukket);
        searchControl2.addSearcher(ld, opLukket);
        searchControl2.addSearcher(ws, opLukket);

        var q = document.getElementById("ctl00_LeftArea_Sok");
        if (q != null && q.value != "") {
            searchControl2.draw(document.getElementById("venstreKolonne"));
            searchControl2.execute(q);        
                }
      }
      google.setOnLoadCallback(OnLoad, true);
