<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EPiImageGalleryViewer.ascx.cs" Inherits="MakingWaves.EPiImage.UserControls.EPiImageGalleryViewer" %>
<asp:Panel ID="panelSlider" runat="server" Visible="false">
	<script src="/EPiImage/flowplayer/jquery.tools.1.2.3.min.js"></script> 
	<link rel="stylesheet" type="text/css" href="/EPiImage/flowplayer/standalone.css"/>	
	<link rel="stylesheet" type="text/css" href="/EPiImage/flowplayer/scrollable-horizontal.css" /> 
	<link rel="stylesheet" type="text/css" href="/EPiImage/flowplayer/scrollable-buttons.css" /> 
  <style type="text/css">
	  #image_wrap {width:600px; text-align:center;}
	  .scrollable {position:relative; overflow:hidden; width: 500px; height:90px; background: none; border: none;}
    .scrollable img {-moz-border-radius: none; background-color: white; border: none; width: 90px; height: 50px;}
    #description {font-family: Arial; font-size: 11px; margin-top: 5px;}
    .scrollable img:hover{cursor: pointer;}
  </style>
  	
  <div id="EPiImageGalleryViewer-<%= this.ID %>" class="ImageGallery" style="overflow: hidden;">
  <div id="image_wrap">
	  <!-- Initially the image is a simple 1x1 pixel transparent GIF -->
	  <img src="/EPiImage/flowplayer/blank.gif"  />
	  <div id="description"></div>
  </div>

  <a class="prev browse left"></a>
  <div class="scrollable">   
  <div class="items">
  <asp:Literal ID="litImages" runat="server" />
  </div>
  </div>
  <a class="next browse right"></a>

  <script type="text/javascript">
  $(function() {

  $("#EPiImageGalleryViewer-<%=this.ID %> .scrollable").scrollable();

  if($("#EPiImageGalleryViewer-<%=this.ID %> .scrollable").data("scrollable").getSize() == 1)
  {
    $("#EPiImageGalleryViewer-<%=this.ID %> a.next").addClass("disabled");
    $("#EPiImageGalleryViewer-<%=this.ID %> a.prev").addClass("disabled");
  }
  
  $("#EPiImageGalleryViewer-<%=this.ID %> .items img").click(function() {
	  // see if same thumb is being clicked
	  if ($(this).hasClass("active")) { return; }

	  // get large image's URL
    var url = $(this).attr("longdesc");
	  var wrap = $("#EPiImageGalleryViewer-<%=this.ID %> #image_wrap");
	  var img = new Image();
	  var alt = $(this).attr("title");

	  // call this function after it's loaded
	  img.onload = function() {

		  // change the image
		  wrap.find("img").attr("src", url);
  		
		  //change the desc
		  $("#EPiImageGalleryViewer-<%=this.ID %> #description").html(alt + '&nbsp;');

	  };
	  img.src = url;

	  // activate item
	  $("#EPiImageGalleryViewer-<%=this.ID %> .items img").removeClass("active");
	  $(this).addClass("active");

  // when page loads simulate a "click" on the first image
  }).filter(":first").click();
 
  });
  </script>
  </div>
</asp:Panel>
<asp:Literal ID="litMessage" runat="server" />
