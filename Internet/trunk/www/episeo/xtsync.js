function parseXML(text)
{   
    try //Internet Explorer
    {
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(text);
    }  
    catch(e)
    {
        try // Firefox, Mozilla, Opera, etc.
        {
            parser=new DOMParser();
            xmlDoc=parser.parseFromString(text,"text/xml");
        }
        catch(e)
        {           
            return ;
        }
    }    
    return xmlDoc;    
}
/*
function feedSiteID(regrefID){
    var divElem = document.getElementById("siteid");
      if(!divElem)
        return;

    var re= new RegExp('hid_siteid','g')
    var el = divElem.getElementsByTagName('input');
    for(var i=0;i<el.length;i++){
    if(el[i].id.match(re)){
        alert(el[i].id + " lll " + regrefID);
        el[i].value=regrefID;
        }
    }
}
*/

// == Start: Update Priority ==
function priorityChanged(){	
	try{
	     checkDomain();		
	}
	catch(err){ 
	   
	}
}

function checkDate(validuntil){
    try{                        
        var myyear = validuntil.substr(0,4);        
        var mymonth = validuntil.substr(5,2);        
        var myday = validuntil.substr(8,2);
                        
        var validationdate = new Date();
        validationdate.setFullYear(myyear,mymonth,myday);        
        var today = new Date();  

        if (today<validationdate) 
            return 1;
        else
            return 0;        
    }
    catch(err){
       
       return 0;
    }
}
function getPvlcount(){
    try{
          var hidregrefid = document.getElementById("hid_pvlcount");                 
          return hidregrefid.value;    
    }
     catch(err){  
        return 0;     
    }
}
function disablePreCheckBtn(){
    var btn = document.getElementById("BtnPreCheck");  
    var parentN = btn.parentNode; 
    if(btn != null){
        btn.disabled = true; 
        parentN.className = "epitoolbuttondisabled";
    }    
}
function idFailed(){
    var lblmsg = document.getElementById("lblmsg");                                     
    lblmsg.innerHTML = "<h3>This SEO module licence seems not activated for this website, please contact your partner.</h3>";
    lblmsg.style.display = "block";                                   
}
// == End: Update Priority ==
function ChangeIframeLocation(pageID){

var httpPreCheck=getHTTPObject();

httpPreCheck.open("GET", Url_ajax + "?pageref=" + pageID + "&regrefid=" + getCurrentRegRefId()+ "&p=" + getCurrentUrl(), true);

	    httpPreCheck.onreadystatechange  = function()
	    {	
		    if(httpPreCheck.readyState  == 4)
		    {    		
			    if(httpPreCheck.status  == 404){ 
			       // alert("Function currently unavailable. Check back later");
			    }
			    
			    else if(httpPreCheck.status  == 200){
			        try{
        			        var results = httpPreCheck.responseText;    				
                            var XML = parseXML(results);                            
                            var hid_countprecheck = document.getElementById("hid_countprecheck").value;                            
                            
                            if(results=="" && hid_countprecheck < 5){
                                 ChangeIframeLocation();
                                 hid_countprecheck = hid_countprecheck + 1;
                            }                                                       
                            else{                                  
                                  var checkResult = XML.getElementsByTagName("filegenerated")[0].childNodes[0].nodeValue;                                  
                                  
                                  if(checkResult=="True") { 
                                    frames['frameContainer'].location.href = UrlContainer + getCurrentRegRefId()+ "&role=" + getCurrentRoleId() +"&epiPrecheck=true&pagename=" + pageID + "&p=" + getCurrentUrl(); 
					                var precheckSet = document.getElementById("hid_precheckSet");
					                precheckSet.value="true";
                                  }					
                            }                             
                         }                        
                        catch(erroObj)
                        {
                            // alert(erroObj);
                        }				
			     }
			    else{
			        //alert("Http status: " + httpCheckDomain.status);			        
			    }
		    }    		
		   // alert("Http readystate " + httpCheckDomain.readystate);
	    }
	    httpPreCheck.send(null);
}
        
function checkDomain(){    
    var hid_host = document.getElementById("hid_host").value;    
    var currDomain = hid_host.replace("http://", "");  
        
    httpCheckDomain.open("GET", Url_ajax+ "?domain=" + currDomain, true);
	    httpCheckDomain.onreadystatechange  = function()
	    {	
		    if(httpCheckDomain.readyState  == 4)
		    {    		
			    if(httpCheckDomain.status  == 404){ 
			       // alert("Function currently unavailable. Check back later");
			    }			    
			    else if(httpCheckDomain.status  == 200){
			        try{
        			        var results = httpCheckDomain.responseText;    				
                            var XML = parseXML(results);                            
                            var hid_count = document.getElementById("hid_count").value;                          
                            
                            if(results=="" && hid_count < 5){
                                 checkDomain();
                                 hid_count = hid_count + 1;
                            }                                                                                      
                            
                            var validUntil = XML.getElementsByTagName("ValidUntil")[0].childNodes[0].nodeValue;
                            try{
                                    var registeredReferer = XML.getElementsByTagName("Referer")[0].childNodes[0].nodeValue;
                                }
                            catch(E){
                                idFailed();                                
                            }
                            var rerefID = XML.getElementsByTagName("RegRefID")[0].childNodes[0].nodeValue;  
                            
                            if(rerefID=="-1"){                                
                               idFailed();                             
                            }
                            else{
                                if(checkDate(validUntil)>0){                                    
                                     var hidref = document.getElementById("hid_referer");
                                     hidref.value = registeredReferer;
                                     var hidreg = document.getElementById("hid_regrefid");
                                     hidreg.value = rerefID;   
                                     initTab("PageContainer"); 
                                }                               
                                else
                                {
                                   var lblmsg = document.getElementById("lblmsg");                                 
                                   lblmsg.innerHTML = "Your module licence seems to have expired, please contact your partner.";
                                   lblmsg.style.display = "block";                               
                                }                             
                            }                        			    
                        }
                        
                    catch(erroObj)
                    {
                      // alert(erroObj);
                       }					
			     }
			    else{
			        //alert("Http status: " + httpCheckDomain.status);			        
			    }
		    }    		
		   // alert("Http readystate " + httpCheckDomain.readystate);
	    }
	    httpCheckDomain.send(null);
}

function getHTTPObject() {
	var xmlhttp;
	/*@cc_on
	@if (@_jscript_version >= 5)
		try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
			xmlhttp = false;
		}
		}
	@else
	xmlhttp = false;
	@end @*/
	if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
		try {
		xmlhttp = new XMLHttpRequest();
		} catch (e) {
		xmlhttp = false;
		}
	}
	return xmlhttp;
}

var httpCheckDomain = getHTTPObject();

function addEvent(obj, evType, fn){
 if(obj.addEventListener)
 { 
 obj.addEventListener(evType, fn, false); 
 return true; }
 else if(obj.attachEvent)
 { var r = obj.attachEvent("on"+evType, fn); return r;}
   else{ return false; }
  } 
 
   try{  
  
   addEvent(window, 'load', priorityChanged);
 
 }
 catch(err){}