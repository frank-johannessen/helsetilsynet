// ##### EPiImage Property ##################################################################################
// by Alexander Haneng (Making Waves)

//AddImage ----------------------------------------------------------------------------------
function AddImage(tbID, tbAltID, imgID) {
  var returnVal = new Object();     
  var dialogArguments = returnVal;
  var callbackArguments = new Object();
  callbackArguments.tbID = tbID;
  callbackArguments.tbAltID = tbAltID;
  callbackArguments.imgID = imgID;
  EPi.CreateDialog(EPiImageDialogUrl, AddImageDialogClosed, callbackArguments, returnVal, {width: 600});
}


//AddImageDialogClosed ----------------------------------------------------------------------------
function AddImageDialogClosed(returnValue, callbackArguments) {    
  if (returnValue != undefined && returnValue != 0) 
  {
    var tbID = callbackArguments.tbID;
    var tbAltID = callbackArguments.tbAltID;
    var imgID = callbackArguments.imgID;
  
   if(returnValue.items == undefined)
      var fileSelected = returnValue; //CMS5
    else
      var fileSelected = returnValue.items[0].path; //CMS6    
  
    $.post('/EPiImage/Services/EPiImageCreateImageService.aspx', { imgpath: fileSelected }, function(msg){ UpdateImage(msg, fileSelected, tbID, tbAltID, imgID);}, 'text');        
    //document.getElementById(EPiImageUrlClientID).value = fileSelected; 
    var tbCtrl = document.getElementById(tbID);            
    tbCtrl.value = fileSelected;    
    
    MarkPageAsChanged();   
  }     
}

//LoadImageAfterPostback ----------------------------------------------------------------------------
function LoadImageAfterPostback(tbID, tbAltID, imgID) { 
  if(document.getElementById(tbID) != undefined)
  {
    var imgpath = document.getElementById(tbID).value;
    if (imgpath != undefined && imgpath != null && imgpath.length > 0) 
      $.post('/EPiImage/Services/EPiImageCreateImageService.aspx', { imgpath: imgpath }, function(msg){ UpdateImage(msg, imgpath, tbID, tbAltID, imgID);}, 'text');                   
    else
      RemoveImage(tbID, tbAltID, imgID);
  }
}


//UpdateImage
function UpdateImage(result, imgpath, tbID, tbAltID, imgID)
{
  var html = document.getElementById(imgID);                            

  if(result.indexOf('Error') != -1)                        
  {
    alert('Create thumb failed: ' + result);                     
    document.getElementById(tbCtrlID).value = '';             
  }
  else {                        

    
    var pic = '<div class=\"Image\"><div class=\"ImagePadding\"><img src=\"' + EPiImageThumbResizeUrl + imgpath + '\" title="' + imgpath + '" ></div>';
    pic += '<img src=\"/EPiImage/imgs/x.gif\" OnClick=\"RemoveImage(\'' + tbID + '\',\'' + tbAltID + '\',\'' + imgID + '\' );\" class=\"Close\">';
    pic += '<img src=\"/EPiImage/imgs/i.png\" OnClick=\"EditEPiImageInfo(\'' + imgpath + '\',\'' + tbID + '\',\'' + tbAltID + '\',\'' + imgID + '\');\" class=\"AltText\"></div>';                           
    html.innerHTML = pic;                           
  }
}

//EditEPiImageInfo -----------------------------------------------------------------------------------                         
function EditEPiImageInfo(ImageUrl, tbID, tbAltID, imgID)
{
    var dialogcontent = '<div class="PreviewImage"><img src="' + EPiImagePreviewResizeUrl + ImageUrl + '" title="' + ImageUrl + '" /></div>';
    dialogcontent += '<div class="PreviewDescLabel">' + EPiImageTranslate["imagedescription"] + ':</div>';
    dialogcontent += '<div class="PreviewDescInput"><textarea class="EPiImagePreviewAlt" cols="70" rows="2"></textarea></div>';
    dialogcontent += '<div class="PreviewButton"><span class="epi-cmsButton"><input type="button" value="' + EPiImageTranslate["saveandclose"] + '" OnClick="SaveEPiImageDescription(\'' + tbID + '\',\'' + tbAltID + '\',\'' + imgID + '\');" class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save"></span></div>';
    
    var descID = '#' + imgID + '-EPiImageDescription';
    
    $(descID + ' .EPiImageDescriptionDiv').html(dialogcontent);
    $(descID + ' .EPiImagePreviewAlt').val($('#' + tbAltID).val());
		$(descID).dialog('open');
}

	
//Save Image Description for image ------------------------------------------------------------------------	
function SaveEPiImageDescription(tbID, tbAltID, imgID)
{ 
  var descID = '#' + imgID + '-EPiImageDescription';

  $(descID).dialog('close');
  var value = $(descID + ' .EPiImagePreviewAlt').val().replace('|', '');
  $('#' + tbAltID).val(value);
  
  MarkPageAsChanged();   
}


//RemoveImage ----------------------------------------------------------------------------
function RemoveImage(tbID, tbAltID, imgID)
{
  document.getElementById(tbID).value = '';             
  LoadAddImageButton(tbID, tbAltID, imgID);
  MarkPageAsChanged();   
}


//LoadAddImageButton ----------------------------------------------------------------------------
function LoadAddImageButton(tbID, tbAltID, imgID)
{
    var html = document.getElementById(imgID);                            
    html.innerHTML = '<div class="AddImage" OnClick="javascript:AddImage(\'' + tbID + '\',\'' + tbAltID + '\',\'' + imgID + '\');"><a href="javascript:void(0);"> ' + EPiImageTranslate["selectimage"] + '</a></div>';
}


//AddFileDropAction ----------------------------------------------------------------------------
function AddFileDropAction(tbID, tbAltID, imgID)
{
    $('#' + imgID)
    .bind('dragenter', function (event) {
        event.originalEvent.dataTransfer.dropEffect = 'copy';
        if (event.preventDefault) event.preventDefault(); // required by FF + Safari
        return false; // required by IE
    })

    .bind('dragover', function (event) {
        if (event.preventDefault) event.preventDefault(); // required by FF + Safari
        return false; // required by IE
    })

    .bind('drop', function (event) {
        if (event.preventDefault) event.preventDefault();
        var path = event.originalEvent.dataTransfer.getData("Text");
        event.originalEvent.returnValue = false;

        //File dropped
        if (CheckIfImage(path)) {
            var callbackArguments = new Object();
            callbackArguments.tbID = tbID;
            callbackArguments.tbAltID = tbAltID;
            callbackArguments.imgID = imgID;
            AddImageDialogClosed(path, callbackArguments);
            return;
        }

        alert(EPiImageTranslate["errorfiltypenotsupported"] + ': ' + path);
    });
}    

//CheckIfImage   ---------------------------------------------------------------------------------
function CheckIfImage(str) {
    var ext = null;
    if (str && str.match(/\.\w{3,4}$/)) {
        // Grab the last match if a match was found
        ext = RegExp.lastMatch.toLowerCase();
    }

    return (ext == ".jpg" || ext == ".jpeg" || ext == ".gif" || ext == ".png");
}

function MarkPageAsChanged()
{
  if (EPi.PageLeaveCheck.enabled) {
      EPi.PageLeaveCheck.SetPageChanged(true);
  }
}

//$(document).ready ----------------------------------------------------------------------------
$(document).ready(function() {
  eval(EPiImageLoad);
});

