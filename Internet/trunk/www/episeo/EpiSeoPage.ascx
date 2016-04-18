<%@ Control Language="c#" Codebehind="EpiSeoPage.ascx.cs" AutoEventWireup="True" Inherits="EpiSeoPlugin.EpiSeoPage" %>
<script language="javascript" type="text/javascript" src="<%=ResolveUrl("~/EpiSeo/xtsync.js")%>"></script>


<style type="text/css">

div#PageContainer iframe
{
    float:left;
    width:100%;
    height:790px;
}

div#PageStatsContainer table tr td.Heading{
    border-bottom:solid 1px #000; 
    background-color:#d8e1eb;
    font-weight:bold;
    width:15%;
}
div#lblcurrentpage,
div#currentpage{
    float:left;
    clear:none;
    padding-right:5px; 
    padding-top:7px;
    padding-bottom:5px;    
}
div#precheck{
    float:left;
    clear:none;
    padding-right:5px; 
    padding-top:7px;
    padding-bottom:5px;       
}

div#tabsmenu{
    clear:both;
}
div#leftpanel{
    float:left;
    overflow:hidden;
    width:30px;
    height:300px;
    z-index:0;
    position:absolute;
}
div#rightpanel{
    float:left;
    left:38px;
    padding:10px 5px 5px 10px;    
    width:92%;
    z-index:2;
    border-color:#79828A rgb(121, 130, 138) rgb(111, 120, 127);
    border-style:solid;
    border-width:1px;
    position:absolute;
}
div.published_active{
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabpublished_active.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div.published_inactive{    
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabpublished_inactive.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div.published_inactiveover{    
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabpublished_inactiveover.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div.precheck_active{    
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabprecheck_active.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div.precheck_inactive{    
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabprecheck_inactive.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div.precheck_inactiveover{    
    clear:both;
    float:left;
    background-image:url(<%=ResolveUrl("~/episeo/tabprecheck_inactiveover.png")%>);
    width:30px;
    height:100px;
    cursor:pointer;
}
div#precheckButton{
    float:left;
    clear:none;
    overflow:hidden; 
    cursor:pointer;   
}
div#prechecksel2,
div#prechecksel3
{
    float:left;
    clear:none;
    overflow:hidden;  
    margin:5px 3px 0px 0px;
    vertical-align:middle;
    padding-right:7px;
}
</style>

<script type="text/javascript">
var Url_ajax = "<%=ResolveUrl("~/EpiSeo/sync.aspx")%>";
//var UrlContainer ="http://spider02.osas.no/episeo/container.aspx?EpiVer=5&regrefid=";
//var UrlContainer ="http://sync.seo.episerver.com/episeo/container.aspx?EpiVer=5&regrefid=";
//var UrlContainer ="http://sync.seo.episerver.com/episeo/container.aspx?EpiVer=5&regrefid=";
var UrlContainer ="http://sync.seo.onlineservices.no/episeoxt/container.aspx?EpiVer=5&regrefid=";

function getCurrentRegRefId(){

    try{
          var hidregrefid = document.getElementById("hid_regrefid");                 
          return hidregrefid.value;    
    }
     catch(err){       
    }
}
function getCurrentRoleId(){

    try{
          var hidroleid = document.getElementById("hid_role");                 
          return hidroleid.value;    
    }
     catch(err){ 
        return 3;      
    }
}
function getCurrentUrl(){
    try{       
        var hidregistered = document.getElementById("hid_referer");                
        var xtDomain = hidregistered.value;                
        var currenturl = document.getElementById("currentpage").innerHTML;                       
        var currenturl2 = currenturl.replace("http://", "");       
        currenturl2 = currenturl2.replace("https://", "");
        var indexSlash = currenturl2.indexOf("/");
        var indexQmark = currenturl2.indexOf("?");
        
        if(indexSlash >= 0){
            var curDomain = currenturl2.substring(0, indexSlash);                    
            currenturl = "http://" + currenturl2.replace(curDomain, xtDomain);                      
        }
        else if(indexQmark >= 0){
            var curDomain2 = currenturl2.substring(0, indexQmark);            
            currenturl = "http://" + currenturl2.replace(curDomain2, xtDomain);
        }   
        else{
            currenturl2 = xtDomain;
            currenturl="http://" + currenturl2;                     
        }        
        return currenturl;        
    }
    catch(err){        
    }   
    return currenturl;
}

function switchmodePrecheck(){
    try{
        var pubDiv = document.getElementById("pub");
        var notpubDiv = document.getElementById("notpub");
        var precheckDiv = document.getElementById("precheck");
        var currentpageDiv = document.getElementById("currPage");
        
        if(pubDiv.className="published_active"){              
            pubDiv.className="published_inactive";
            notpubDiv.className="precheck_active";
            currentpageDiv.style.display="none";
            precheckDiv.style.display="block";        
        }
        if(getPvlcount()==0){        
            disablePreCheckBtn();
        }
      }
      catch(e){
      // some error
      }
}
function switchmodePublished(){
    try{
        var pubDiv = document.getElementById("pub");
        var notpubDiv = document.getElementById("notpub");
        var precheckDiv = document.getElementById("precheck");
        var currentpageDiv = document.getElementById("currPage");
        
        if(notpubDiv.className="precheck_active"){              
            pubDiv.className="published_active";
            notpubDiv.className="precheck_inactive";
            currentpageDiv.style.display="block";
            precheckDiv.style.display="none"; 
	var precheckIsSet = document.getElementById("hid_precheckSet");

	if(precheckIsSet.value=="true"){
      		frames['frameContainer'].location.href = UrlContainer + getCurrentRegRefId()+ "&role=" + getCurrentRoleId() + "&epiPrecheck=false&p=" + getCurrentUrl();
		precheckIsSet.value="false";
	}
        }
      }
      catch(e){
      }
}

function initTab(name){    
    try{                 
        var elem1 = document.getElementById(name); 
        var elem2 = document.getElementById("leftpanel"); 
        var elem3 = document.getElementById("rightpanel"); 
        if(name == "PageContainer"){                    
            frames['frameContainer'].location.href = UrlContainer + getCurrentRegRefId()+ "&role="+ getCurrentRoleId() + "&p=" + getCurrentUrl();            
        }       
        elem1.style.display = "block";
        elem2.style.display = "block";
        elem3.style.display = "block";
    }
    catch(err){     
    }    
}
function pubMouseover(elem){
        
	if(elem.className == "published_inactive"){
		elem.className = "published_inactiveover";
	}	
}
function pubMouseout(elem){
       
	if(elem.className == "published_inactiveover"){
		elem.className = "published_inactive";
	}
}
function precheckMouseover(elem){    
        
	if(elem.className == "precheck_inactive"){
		elem.className = "precheck_inactiveover";
	}		
}
function precheckMouseout(elem){		
       
	if(elem.className == "precheck_inactiveover"){
		elem.className = "precheck_inactive";
	}			
}
</script>
<div id="lblmsg" style="display:none;"></div>
<div id="leftpanel" style="display:none;"> 
    <div id="pub" class="published_active" onclick="switchmodePublished()" onmouseover="pubMouseover(this)" onmouseout="pubMouseout(this)"></div>
    <div id="notpub" class="precheck_inactive" onclick="switchmodePrecheck()" onmouseover="precheckMouseover(this)" onmouseout="precheckMouseout(this)"></div>
</div>
<div id="rightpanel" style="display:none;">
    <div id="currPage">
        <div id="lblcurrentpage">Current page URL:</div> <div id="currentpage"><%=st%></div>
    </div>
    <div id="precheck" style="display:none;">        
        <div>The 'Pre-check' feature allows you to analyze unpublished versions of this page with the 'Editor Advices', 'Keyword Analysis' and 'Robot View'</div>        
        <br/> 
        <div id="prechecksel">            
            <div id="prechecksel2">Select the version of the page to analyze:</div>            
            <div id="prechecksel3"><asp:DropDownList runat="server" id="ddlversions" AutoPostBack="false" ></asp:DropDownList></div>            
            
            <div id="precheckButton" class="epitoolbuttoncontainer">
                <div id="precheckButton2" class="epitoolbuttoncontaineritem">
                    <span class="epitoolbutton">
                        <input type="button" ID="BtnPreCheck" value="Pre-Check" OnClick="ChangeIframeLocation(<%=ddlversions.ClientID%>.value)" />
                    </span>
                </div>
            </div>
            
        </div>
    </div>
    
    <div id ="hide" >    
        <input id="hid_regrefid" type="hidden" name="RegRefId"/>
        <input id="hid_referer" type="hidden" name="Referer" />       
        <input id="hid_host" type="hidden" name="Host" value="<%=domain %>" />     
        <input id="hid_count" type="hidden" name="hid_count" value="0" />
        <input id="hid_countprecheck" type="hidden" name="hid_countprecheck" value="0" />
	    <input id="hid_precheckSet" type="hidden" name="hid_precheckSet" />
	    
	    <input id="hid_pvlcount" type="hidden" name="hid_pvlcount" value="<%=pvlCount %>" />
	    
        <input id="hid_stats" type="hidden" name="stats" value="0" />
        <input id="hid_seo" type="hidden" name="seo" value="0" />
        <input id="hid_adv" type="hidden" name="adv" value="0" /> 
        <input id="hid_rv" type="hidden" name="adv" value="0" /> 
        <input id="hid_hm" type="hidden" name="adv" value="0" /> 
        <input id="hid_cm" type="hidden" name="adv" value="0" />     
        <input id="hid_role" type="hidden" name="role" value="<%=roleID %>" />   
    </div>
    <div id="PageContainer" style="border:none; display:none;">
        <iframe id="frameContainer" name="frameContainer" frameborder="no" src="" ></iframe>    
    </div>
</div>