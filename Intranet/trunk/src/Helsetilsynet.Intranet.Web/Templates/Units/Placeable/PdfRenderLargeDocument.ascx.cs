using System;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class PdfRenderLargeDocument : System.Web.UI.UserControl
    {
        protected int TargetCounter { get; set; }
        protected int ItemCounter { get; set; }

        public LargeDocument RequestedLargeDocument { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected static string GetLargeDocumentChapterNumber(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? "" : obj.ChapterNumber;
        }

        protected static int GetLargeDocumentChapterLevel(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? 0 : obj.GetChapterLevel();
        }

        protected static string GetLargeDocumentChapterPageNameWithoutChapterNumber(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? "" : obj.PageNameWithoutChapterNumber;
        }

        protected static string GetStyle(object dataItem)
        {
            return GetLargeDocumentChapterLevel(dataItem) == 1 ? "page‐break‐after : always" : string.Empty;
        }

        protected static string GetLevel(object dataItem)
        {
            return "level" + GetLargeDocumentChapterLevel(dataItem);
        }
    }
}