<%@ Page Language="C#" AutoEventWireup="False" MasterPageFile="~/Templates/AlloyTech/MasterPages/MasterPage.master" Inherits="EPiServer.TemplatePage" %>
<%-- CMS 6 R1: <%@ Page Language="C#" AutoEventWireup="False" MasterPageFile="~/Templates/Public/MasterPages/MasterPage.master" Inherits="EPiServer.TemplatePage" %>--%>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageGalleryViewer" Src="~/EPiImage/UserControls/EPiImageGalleryViewer.ascx" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageGalleryGrid" Src="~/EPiImage/UserControls/EPiImageGalleryGrid.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainRegion" runat="server">
  <style type="text/css">
  .box {float: left; margin-right: 10px;}
  </style>

	<div id="StageArea" class="StartPage">
	<div style="margin: 40px;">
	
	<h1><EPiServer:Property ID="Heading" PropertyName="Heading" runat="server" /></h1>
	
	<h2>EPiImageResizer Transformation types:</h2>
	
	The EPiImageResizer control supports 3 types of transformations: ScaleToFit, ScaleToFill and Stretch:<br /><br />
	
	<div style="overflow: hidden;">
	<div class="box">
	ScaleToFit:<br />
	<EPiImage:EPiImageResizer ID="EPiImageProperty" PropertyName="EPiImageProperty" Transformation="ScaleToFit" Width="250" Height="250" runat="server" />
	</div>
	<div class="box">
	ScaleToFill:<br />
	<EPiImage:EPiImageResizer ID="EPiImageResizer1" PropertyName="EPiImageProperty" Transformation="ScaleToFill" Width="250" Height="250" runat="server" />
	</div>
    <div class="box">
    Stretch:<br />
	<EPiImage:EPiImageResizer ID="EPiImageResizer2" PropertyName="EPiImageProperty" Transformation="Stretch" Width="250" Height="250" runat="server" />
	</div>
	</div>
	
	<br /><br />

	The EPiImageResizer control also supports rotation: Clockwise, UpsideDown and CounterClockwise:<br /><br />
	
	<div style="overflow: hidden;">
	<div class="box">
	Clockwise:<br />
	<EPiImage:EPiImageResizer ID="EPiImageResizer3" PropertyName="EPiImageProperty" Transformation="ScaleToFit" Rotate="Clockwise" Width="250" Height="250" runat="server" />
	</div>
    <div class="box">
    UpsideDown:<br />
	<EPiImage:EPiImageResizer ID="EPiImageResizer5" PropertyName="EPiImageProperty" Transformation="ScaleToFit" Rotate="UpsideDown" Width="250" Height="250" runat="server" />
	</div>
	<div class="box">
	CounterClockwise:<br />
	<EPiImage:EPiImageResizer ID="EPiImageResizer4" PropertyName="EPiImageProperty" Transformation="ScaleToFit" Rotate="CounterClockwise" Width="250" Height="250" runat="server" />
	</div>
	</div>
	
	<br /><br />


  <h2>Accessing EPiImageProperty:</h2>
	
	The example above access the EPiImage property through the EPiImageResizer control. But you can of course also access the property directly:<br />
	As a string: <strong><%= CurrentPage["EPiImageProperty"].ToString() %></strong><br />
	Just the image url: <strong><%= !(CurrentPage.Property["EPiImageProperty"] as MakingWaves.EPiImage.EPiImageProperty).IsNull ? (CurrentPage.Property["EPiImageProperty"] as MakingWaves.EPiImage.EPiImageProperty).ImageUrl : ""%></strong><br />
	Just the description: <strong><%= (CurrentPage.Property["EPiImageProperty"] as MakingWaves.EPiImage.EPiImageProperty).ImageDescription %></strong>
	
  <br /><br />

  <h2>EPiImageGallery Viewer user control:</h2>  
  The EPiImageGalleryViewer shows one way to render the contents of a EPiImageGalleryProperty:
  
  <div style="margin-left: 150px; margin-top: 10px;">
  <EPiImage:EPiImageGalleryViewer id="EPiImageGalleryProperty" PropertyName="EPiImageGalleryProperty" runat="server" />
	</div>
	
	<br /><br />
	
	<h2>EPiImageGallery Grid user control:</h2>  
  The EPiImageGalleryGrid shows another way to render the contents of a EPiImageGalleryProperty:
	<div>
  <EPiImage:EPiImageGalleryGrid ID="EPiImageGalleryGrid" PropertyName="EPiImageGalleryProperty" ThumbnailHeight="150" ThumbnailWidth="150" DescriptionHeight="20" DownloadLinkHeight="20" Transformation="ScaleToFill" ShowDescription="true" ShowDownloadLink="true" LinkThumbnailsTo="OriginalImage" runat="server" />
  </div>
	
	
	<h2>Access the images stored in a EPiImageGalleryProperty</h2>
  You can also access the images directly:<br /><br />
  
  <script type="text/C#" runat="server">
  protected override void OnLoad(EventArgs e)
  {
    //Get the property
    if (!CurrentPage.Property["EPiImageGalleryProperty"].IsNull)
    {
      MakingWaves.EPiImage.EPiImageGalleryProperty galleryProperty = CurrentPage.Property["EPiImageGalleryProperty"] as MakingWaves.EPiImage.EPiImageGalleryProperty;
      if (galleryProperty != null)
      {
        //Get the images by calling GetImages(CurrentPage)
        MakingWaves.EPiImage.EPiImageGalleryImageCollection imageCollection = galleryProperty.GetImages(CurrentPage);

        //Databind the image collection to a repeater 
        repGallery.DataSource = imageCollection;
        repGallery.DataBind();        
      }
    }
  }
  </script>

  
  
  <asp:Repeater ID="repGallery" runat="server">
    <HeaderTemplate><ul></HeaderTemplate>
    <ItemTemplate>
      <li>
      Image url: <strong><%# (Container.DataItem as MakingWaves.EPiImage.EPiImageGalleryImage).ImageURL %> </strong><br />
      Description: <strong><%# (Container.DataItem as MakingWaves.EPiImage.EPiImageGalleryImage).Description %></strong><br />
      Link: <strong><%# (Container.DataItem as MakingWaves.EPiImage.EPiImageGalleryImage).LinkURL %></strong>  
      </li>
    </ItemTemplate>
    <FooterTemplate></ul></FooterTemplate>
  </asp:Repeater>
  	
	
	<br /><br /><br />
	</div>
	</div>
	
	

</asp:Content>

