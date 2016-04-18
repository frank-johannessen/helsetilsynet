<%@ Control Language="c#" AutoEventWireup="True" Codebehind="EpiSeoDomain.ascx.cs" Inherits="EpiSeoPlugin.EpiSeoDomain" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type="text/javascript">

var url = "<%=ResolveUrl("~/EpiSeo/xReport.aspx")%>"; 

function showReport(val){
    window.open(url + "?report=" + val, "EditPanel");
}


</script>

<table width="100%" border="0">
    <tr>
        <td height="20px">
        <b>Domain stats - Period last 30 days</b>
        </td>
    </tr>
    <tr>
        <td height="40px">
            <div style="display:block;">
            SEO Status:<br />
            - <a id="A7" href="#" onclick="showReport('seostatus');">SEO KPI report</a><br />            
            <br />
            </div>
            <div style="display:block;">
            Links to this website:<br />
            - <a id="A2" href="#" onclick="showReport('ReportActiveExternLinks');">Traffic-generating domains</a><br /> 
            - <a id="A1" href="#" onclick="showReport('reportnewtrafficreferrers')">New traffic-generating domains</a><br />                      
            - <a id="A4" href="#" onclick="showReport('reportdomainsperCountry');">Traffic-generating domains per country</a><br />            
            <br />
            </div>
            <div style="display:block;">
            Keyword analysis and reporting:<br />
            - <a id="l101" href="#" onclick="showReport('reportpriokeywordanalysis');">Prioritized keywords (PK) - Analysis</a><br />           
            - <a id="l206" href="#" onclick="showReport('priokeywordsdetails');">Prioritized keywords - Rankings</a><br />                           
            - <a id="A11" href="#" onclick="showReport('searchphrases');">Most popular search phrases</a><br />                                                                                        <br />
            </div>
            <div style="display:block;">
            Benchmarking:<br />
            - <a id="A13" href="#" onclick="showReport('benchmarking');">Benchmarking - per site category</a><br />            
            <br />
            </div>
            <div style="display:block;">
            Alerts:<br />
            - <a id="l301" href="#" onclick="showReport('alerts');">Alerts list</a><br />                    
            <br />
            </div>          
            <div style="display:block;">
            SEO Admin:<br />
            - <a id="A3" href="http://settings.seo.onlineservices.no/">Edit your settings</a><br />
            <br />
            </div>
          </td>
    </tr>    
</table>