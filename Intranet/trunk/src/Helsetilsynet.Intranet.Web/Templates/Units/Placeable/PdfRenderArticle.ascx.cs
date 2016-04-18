using System;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class PdfRenderArticle : System.Web.UI.UserControl
    {
        public Article Article { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //SetMainImage();
        }
        //private void SetMainImage()
        //{
        //    if (Article.MainImage == null)
        //        return;

        //    imgMainImage.ImageUrl = Article.MainImage.ImageUrl;
        //    imgMainImage.DataBind();
        //}
    }
}