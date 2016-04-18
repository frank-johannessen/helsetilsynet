using System;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class PrintPdfButton : UserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = false;
            if (!(CurrentPage is LargeDocument || CurrentPage is LargeDocumentChapter || CurrentPage is Article))
                return;

            this.Visible = true;
            if (CurrentPage is LargeDocument || CurrentPage is Article)
            {
                pdfConverter.PageToConvert = CurrentPage;
            }

            if (CurrentPage is LargeDocumentChapter)
            {
                pdfConverter.PageToConvert =
                    LargeDocumentHelper.GetMainDocumentPage(CurrentPage as LargeDocumentChapter);
            }
            pdfConverter.DataBind();
        }
    }
}