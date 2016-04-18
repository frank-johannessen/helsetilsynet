using System;
using MakingWaves.EPiImage.Code;
using Org.BouncyCastle.Asn1.Ocsp;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.ActivityFeed
{
    public partial class CreateThumbnail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        //Service to provide the URL to resize versions of the image
        string QS_OriginalImageURL = Request.QueryString["url"];
        string QS_Transformation = Request.QueryString["t"];
        string QS_Width = Request.QueryString["w"];
        string QS_Height = Request.QueryString["h"];

        if (!String.IsNullOrEmpty(QS_OriginalImageURL))
        {
          int Width, Height;

          //Try parsing with and height
          if (!(Int32.TryParse(QS_Width, out Width) && Int32.TryParse(QS_Height, out Height)))
            Width = Height = 100; //Default: 100 x 100

          //Try parsing Transformation
          EPiImageEngine.Transformation Trans = EPiImageEngine.Transformation.ScaleToFit; //Default: ScaleToFit
          if (!String.IsNullOrEmpty(QS_Transformation))
          {
            if (QS_Transformation.ToLower() == "scaletofill")
              Trans = EPiImageEngine.Transformation.ScaleToFill;
            else if (QS_Transformation.ToLower() == "stretch")
              Trans = EPiImageEngine.Transformation.Stretch;
          }


          string resizedImageUrl = new EPiImageEngine().ResizeImage(Width, Height, Trans, EPiImageEngine.Rotation.NoRotation, QS_OriginalImageURL);

          Response.Redirect(resizedImageUrl);
        }
        else
          Response.Write("error");

    
        }
    }

}