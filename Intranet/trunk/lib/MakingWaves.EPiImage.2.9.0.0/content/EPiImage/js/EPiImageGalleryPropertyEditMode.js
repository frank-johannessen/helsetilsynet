// ##### EPiImageGallery Property ########################################################################
// by Alexander Haneng (Making Waves)

function EPiImageGallery(ObjectID, GalleryDivID, StorageID) 
 {       
    //Create gallery object
    var object = {
    
      //Variables
      GalleryObjectID : ObjectID,
      GalleryDiv : '#'+GalleryDivID,
      StorageX : '#' + StorageID,
      Slides : new Array(),
      FirstLoad : true,

  
      //Methods
   
      //------------------------------------------------------------------------------------------------------------
      // Init
      //------------------------------------------------------------------------------------------------------------      
      init : function() {
      
        //Prepare model window for preview/edit
        $("#" + this.GalleryObjectID + "_Preview").dialog({ modal: true, autoOpen: false, width: 480, height: 510 });

        //Load slides
        this.LoadSlides();
   
        var that = this;
        $(this.GalleryDiv).sortable({ update: function (event, ui) {that.SlidePositionChanged(); }, items: '.Slide' })
                
        $(this.GalleryDiv)
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
            var callbackArguments = new Object();
            callbackArguments.GalleryObjectID = that.GalleryObjectID;

            //File dropped
            if (CheckIfImage(path)) {
                that.OnFileDialogClosed(path, callbackArguments);
                return;
            }

            //Path dropped
            if (path.match(/\/$/)) {
                that.OnFileDialogClosed(path, callbackArguments);
                return;
            }

            alert(EPiImageTranslate["errorfiltypenotsupported"] + ': ' + path);
        });
      },
      
      
      //------------------------------------------------------------------------------------------------------------
      // SlideCreated
      //------------------------------------------------------------------------------------------------------------  
      SlideCreated : function(createSlideResultArr) {
          createSlideResult = '';
          var arr = createSlideResultArr.split(';');

          for (var i in arr) {
              createSlideResult = arr[i];

              if (createSlideResult.indexOf('Error') != -1)
                  alert(EPiImageTranslate["errorcreateslidefailed"] + ': ' + createSlideResult);
              else {
                  createSlideResult = createSlideResult.replace(/(<([^>]+)>)/ig, '');
                  var createSlideReturnValue = createSlideResult.replace(/OK:/gi, '');
                  var Slide = { "id" : GetGUID(createSlideReturnValue), "url" : GetImageURL(createSlideReturnValue), "alt" : "", "link" : "", "loading" : true};
                  this.Slides.push(Slide);
                  this.Save();
              
                  this.LoadSlides();
              }
          }
      },


      //------------------------------------------------------------------------------------------------------------
      // RemoveSlide
      //------------------------------------------------------------------------------------------------------------  
      RemoveSlide : function(SlideID) {
          $('#' + SlideID).remove();
          this.SlidePositionChanged();
      },


      //------------------------------------------------------------------------------------------------------------
      // Save
      //------------------------------------------------------------------------------------------------------------  
      Save : function()
      {
        var slide;
        var value = '';
        for(slide in this.Slides) {
          value += JSON.stringify(this.Slides[slide]) + '|';
        }
        $(this.StorageX).val(value);
        return value;
      },

      //------------------------------------------------------------------------------------------------------------
      // Load
      //------------------------------------------------------------------------------------------------------------  
      Load : function()
      {
        var Value = $(this.StorageX).val();
        var SlideArray = Value.split('|');
        var s;
        this.Slides = new Array();
        for(s in SlideArray) {
          if(SlideArray[s].length > 2)
          {
            var slide = JSON.parse(SlideArray[s]);
            this.Slides.push(slide);
          }
        }
      },


      //------------------------------------------------------------------------------------------------------------
      // LoadSlide
      //------------------------------------------------------------------------------------------------------------  
       LoadSlide: function(Slide, preload) 
       {
          var thumbPath = thumbresizeurl + Slide.url;
          var loadingPath = '/EPiImage/imgs/loading.gif';   
          
          if(!preload)
            loadingPath = thumbPath;
            
          return '<div class=\"Slide\" id=\"' + Slide.id + '\" name=\"' + Slide.id + '\"><div class=\"ImagePadding\"><img src=\"' + loadingPath + '\" class=\"Image\" title=\"' + Slide.url + '\"></div><img src=\"/EPiImage/imgs/x.gif\" OnClick=\"' + this.GalleryObjectID + '.RemoveSlide(\'' + Slide.id + '\');\" class=\"Close\"><img id=\"alt' + Slide.id + '\" name=\"alt' + Slide.id + '\" src=\"/EPiImage/imgs/i.png\" OnClick=\"' + this.GalleryObjectID + '.EditImageInfo(\'' + Slide.id + '\');\" class=\"AltText\"></div>';
      },


      //------------------------------------------------------------------------------------------------------------
      // LoadSlides
      //------------------------------------------------------------------------------------------------------------  
      LoadSlides : function() 
      {
          var addButton = '<div class="AddSlide" OnClick="javascript:' + this.GalleryObjectID + '.LaunchFileManagerBrowser();" title="' + EPiImageTranslate["draganddroptooltip"] + '"><a href="javascript:void(0);">' + EPiImageTranslate["addimage"] + '</a></div>'
          
          if($(this.StorageX).val() != undefined)
          {
            if ($(this.StorageX).val().length > 0) {
               $(this.GalleryDiv + ' .AddSlide').remove(); //Remove Add button
               var ListIDs = new Array();
               var ListURLs = new Array();
               
               this.Load();
               var s;
               var html = $(this.GalleryDiv).html();
               for (s in this.Slides)
               {
                  if(this.Slides[s].loading || this.FirstLoad)
                  {
                    html += this.LoadSlide(this.Slides[s], !this.FirstLoad);
                    ListIDs.push(this.Slides[s].id);
                    ListURLs.push(thumbresizeurl + this.Slides[s].url);
                    this.Slides[s].loading = false;
                  }                
               }
               $(this.GalleryDiv).html(html + addButton);
               
               //Preload images
               preLoadImages(ListURLs, ListIDs);
               this.FirstLoad = false;
            }
            else
              $(this.GalleryDiv).html(addButton);
            
            this.Save();
            this.Load();
          }
      },


      //------------------------------------------------------------------------------------------------------------
      // SlidePositionChanged
      //------------------------------------------------------------------------------------------------------------  
       SlidePositionChanged : function() 
       { 
          var NewArray = new Array();
          var OrderArray = $(this.GalleryDiv).sortable('toArray');
          var i;
          for(i in OrderArray)
            NewArray.push(this.GetSlide(OrderArray[i]));
          this.Slides = NewArray;
          this.Save();
          MarkPageAsChanged();
      },


      //------------------------------------------------------------------------------------------------------------
      // LaunchFileManagerBrowser
      //------------------------------------------------------------------------------------------------------------  
       LaunchFileManagerBrowser : function() 
       {
          var returnVal = new Object();
          var dialogArguments = returnVal;
          var callbackArguments = new Object();
          callbackArguments.GalleryObjectID = this.GalleryObjectID;
          EPi.CreateDialog(dialogUrl + '&browserselectionmode=image&selectedfile=', this.OnFileDialogClosed, callbackArguments, returnVal, { width: 600 });
      },

      //------------------------------------------------------------------------------------------------------------
      // Image selected in FileBrowser
      //------------------------------------------------------------------------------------------------------------ 
       OnFileDialogClosed : function(returnValue, callbackArguments) 
       {
          var slideCreated = callbackArguments.GalleryObjectID + '.SlideCreated(msg)';
       
          if (returnValue != undefined && returnValue != 0) {
              if (returnValue.items == undefined)
                  var fileSelected = returnValue; //CMS5
              else
                  var fileSelected = returnValue.items[0].path; //CMS6

              //Check that we actually got a file path (and the user didn't click cancel)
              if(typeof fileSelected === 'string')
              {
                  MarkPageAsChanged();

                  $.post('/EPiImage/Services/EPiImageGalleryCreateSlideService.aspx', { imgpath: fileSelected }, function (msg) { eval(slideCreated); }, 'text');
              }
          }
      },


      //------------------------------------------------------------------------------------------------------------
      // EditImageInfo
      //------------------------------------------------------------------------------------------------------------                        
      EditImageInfo : function(SlideID) 
      {
          var Slide = this.GetSlide(SlideID);
          
          if(Slide != null)
          {
            var previewPath = previewresizeurl + Slide.url;
            var dialogcontent = 
            '<div class="PreviewImage"><img src="' + previewPath + '" title="' + Slide.url + '" /></div>    \
            <div class="PreviewDescLabel">' + EPiImageTranslate["imagedescription"] + ':</div>    \
            <div class="PreviewDescInput"><textarea class="ImageGalleryPreviewAlt" cols="70" rows="2"></textarea></div>  \
            <div class="PreviewLink">' + EPiImageTranslate["imagelink"] + ': <input type="text" class="LinkUrl" id="ImageLinkUrl" maxlength="255">  \
            <input type="button" onclick="' + this.GalleryObjectID + '.SelectImageLink();" class="epismallbutton" value="..."></div>    \
            <div class="PreviewButton"><span class="epi-cmsButton"><input type="button" value=" ' + EPiImageTranslate["saveandclose"] + ' "    \
            OnClick="' + this.GalleryObjectID + '.SaveImageDescription(\'' + SlideID + '\', true);" class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save"></span></div><div class="PreviewPrevNext"></div>';


            $("#" + this.GalleryObjectID  + "_Preview").html(dialogcontent);
            $("#" + this.GalleryObjectID  + "_Preview .ImageGalleryPreviewAlt").val(Slide.alt.replace(/&quot;/gi,'"'));
            $("#" + this.GalleryObjectID  + "_Preview .LinkUrl").val(Slide.link);
            
            //Create Prev Next links
            var index = this.GetSlideIndex(SlideID);
            var prevnext = (parseInt(index)+1) + ' of ' + this.Slides.length;
            if(index != 0)
              prevnext = '<a href="#" onclick="' + this.GalleryObjectID + '.ImageInfoPrevNext(\'' + SlideID + '\',\'' + this.Slides[parseInt(index)-1].id + '\');" title="' + EPiImageTranslate["prevtooltip"] + '">&#60; ' + EPiImageTranslate["prev"] + '</a> ' + prevnext;
            if(index != this.Slides.length - 1)
              prevnext += ' <a href="#" onclick="javascript:' + this.GalleryObjectID + '.ImageInfoPrevNext(\'' + SlideID + '\',\'' + this.Slides[parseInt(index)+1].id + '\');" title="' + EPiImageTranslate["nexttooltip"] + '">' + EPiImageTranslate["next"] + ' &#62;</a>';            
            $("#" + this.GalleryObjectID  + "_Preview .PreviewPrevNext").html(prevnext);
            
            $("#" + this.GalleryObjectID  + "_Preview").dialog('open');
          }
          else alert('Slide is null!');
      },


      //------------------------------------------------------------------------------------------------------------
      // ImageInfoPrevNext
      //------------------------------------------------------------------------------------------------------------    
      ImageInfoPrevNext : function(SaveSlideID, ShowSlideID) {
          this.SaveImageDescription(SaveSlideID, false);
          this.EditImageInfo(ShowSlideID);
      },
      
      
      //------------------------------------------------------------------------------------------------------------
      // SaveImageDescription
      //------------------------------------------------------------------------------------------------------------    
      SaveImageDescription : function(SlideID, closeWindow) {
          var newDescription = $("#" + this.GalleryObjectID  + "_Preview .ImageGalleryPreviewAlt").val().replace('|', '').replace(/"/gi,'&quot;'); 
          var Slide = this.GetSlide(SlideID);
          Slide.alt = newDescription;
          Slide.link = $("#" + this.GalleryObjectID  + "_Preview .LinkUrl").val();
          this.Save();
          MarkPageAsChanged();

          //Close dialog  
          if(closeWindow)
            $("#" + this.GalleryObjectID  + "_Preview").dialog('close');
      },
      
      
      //------------------------------------------------------------------------------------------------------------
      // SelectImageLink
      //------------------------------------------------------------------------------------------------------------    
      SelectImageLink : function() 
      {
        var existingLink = $("#" + this.GalleryObjectID  + "_Preview .LinkUrl").val();
        var url = hyperlinkDialogUrl + '?url='+ existingLink;
        var linkAttributes = new Object();
        linkAttributes.href	= existingLink;
        linkAttributes.parentWindow	= window;
        linkAttributes.fileManagerBrowserUrl = dialogUrl;

        var dialogArguments = linkAttributes;
        var features = {width: 460, height: 430};
        var callbackArguments = new Object();
        callbackArguments.GalleryObjectID = this.GalleryObjectID;
        
        /* opens the hyperlinkproperty dialog */       
        EPi.CreateDialog(url, this.OnLinkDialogClosed, callbackArguments, dialogArguments, features);   
      },
      

      //------------------------------------------------------------------------------------------------------------
      // OnLinkDialogClosed
      //------------------------------------------------------------------------------------------------------------    
      OnLinkDialogClosed : function(returnValue, callbackArguments)
      {
        if (returnValue != undefined && returnValue != 0)
        { 	    
           $("#" + callbackArguments.GalleryObjectID  + "_Preview .LinkUrl").val(returnValue.href);  
        }
      },
      

      //------------------------------------------------------------------------------------------------------------
      // GetSlide
      //------------------------------------------------------------------------------------------------------------   
      GetSlide : function(slideID) { 
         var s;
         for (s in this.Slides)
         {
            if(this.Slides[s].id == slideID)
              return this.Slides[s];
         }
         return null;
      },
      
      //------------------------------------------------------------------------------------------------------------
      // GetSlide
      //------------------------------------------------------------------------------------------------------------   
      GetSlideIndex : function(slideID) { 
         var s;
         for (s in this.Slides)
         {
            if(this.Slides[s].id == slideID)
              return s;
         }
         return null;
      }      
              
    };
    
    if($(this.StorageX).val() != undefined)
      object.init();
      
    return object;
}
    
//On Load  ---------------------------------------------------------------------------------
$(document).ready(function () {

   //Create EPiImageGallery object
   eval(EPiImageGalleryLoad);
});


//CheckIfImage   ---------------------------------------------------------------------------------
function CheckIfImage(str) {
    var ext = null;
    if (str && str.match(/\.\w{3,4}$/)) {
        // Grab the last match if a match was found
        ext = RegExp.lastMatch.toLowerCase();
    }

    return (ext == ".jpg" || ext == ".jpeg" || ext == ".gif" || ext == ".png");
}

//GetImageURL   ---------------------------------------------------------------------------------
// Extracts the url to the original image from the createSlideReturnValue
function GetImageURL(createSlideReturnValue) {
    return createSlideReturnValue.substring(createSlideReturnValue.indexOf('|')+1, createSlideReturnValue.length);
}

//GetGUID   ---------------------------------------------------------------------------------
// Extracts the guid from the createSlideReturnValue
function GetGUID(createSlideReturnValue) { 
    return createSlideReturnValue.substring(0, createSlideReturnValue.indexOf('|'));
}

//MarkPageAsChanged   ---------------------------------------------------------------------------------
function MarkPageAsChanged()
{
  if (EPi.PageLeaveCheck.enabled) {
      EPi.PageLeaveCheck.SetPageChanged(true);
  }
}

//preLoadImages  ---------------------------------------------------------------------------------
//Loads all the images in the queue one by one 
var preLoadImages = function(imageList, idList) {
  var count = -1;
  var loading = false;
  var pic;

  //loadNext will be called every 50ms while the queue is not empty
  var loadNext = function(){
    if(!loading){
      count++;
      loading = true;
      
      var pic = new Image();
      pic.onload = function(){
          imageLoaded(); 
      }
      pic.src = imageList[count];
    }
  }

  function imageLoaded()
  {
    loading = false;

    //Swap loading image with actual image now that it has loaded
    $('#'+idList[count] + ' .ImagePadding img').attr('src', imageList[count]);

    if(count >= imageList.length-1){
      clearInterval(loadInterval);  
    }    
  }
    
  var loadInterval = window.setInterval(loadNext, 50); //Start loading
};
