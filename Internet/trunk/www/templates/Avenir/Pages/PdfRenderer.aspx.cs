using System;
using EPiServer;
using EPiServer.Core;
using Helsetilsynet.Class;


namespace Helsetilsynet.templates.Avinir.Units.Placeable.LargeDocuments.Pages
{
    public partial class PdfRenderer : TemplatePage
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

            if (PageToConvert.PageTypeName == "LargeDocument")
            {
                RenderLargeDocument.RequestedLargeDocument = PageToConvert as PageData;
                RenderLargeDocument.Visible = true;
                RenderLargeDocument.DataBind();
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