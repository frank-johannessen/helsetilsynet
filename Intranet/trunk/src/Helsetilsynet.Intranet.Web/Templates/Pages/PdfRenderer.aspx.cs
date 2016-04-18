using System;
using EPiServer;
using EPiServer.Core;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class PdfRenderer : TemplatePage<Model.PdfRenderer>
    {
        protected PageData PageToConvert { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var section = Request.QueryString[GlobalName.QueryStringName.Section];

            plhContent.Visible = section == GlobalName.QueryStringName.SectionValue.Main;
            plhFooter.Visible = section == GlobalName.QueryStringName.SectionValue.Footer;
            plhHeader.Visible = section == GlobalName.QueryStringName.SectionValue.Header;

            if (section != GlobalName.QueryStringName.SectionValue.Main)
                return;

            GetRequestedDocument();

            if (PageToConvert is Model.LargeDocument)
            {
                RenderLargeDocument.RequestedLargeDocument = PageToConvert as Model.LargeDocument;
                RenderLargeDocument.Visible = true;
                RenderLargeDocument.DataBind();
            }
            if (PageToConvert is Model.Article)
            {
                RenderArticle.Article = PageToConvert as Model.Article;
                RenderArticle.Visible = true;
                RenderArticle.DataBind();
            }

            plhContent.Visible = PageToConvert != null;
        }

        private void GetRequestedDocument()
        {
            
            var guid = Request.QueryString[GlobalName.QueryStringName.PdfView];
            if (string.IsNullOrEmpty(guid))
                return;

            var cachedId = Cache[guid];
            if (cachedId == null)
                return;

            int number;
            if(!int.TryParse(cachedId.ToString(), out number))
                return;

            PageReference requestedLargeDocument;
            var ok = PageReference.TryParse(number.ToString(), out requestedLargeDocument);
            if (!ok || requestedLargeDocument == null)
                return;

            PageToConvert = DataFactory.Instance.GetPage(requestedLargeDocument);
        }

        
    }
}