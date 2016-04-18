using System;
using System.Text.RegularExpressions;
using EPiServer;
using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Units.Placeable.LargeDocuments
{
    public partial class PdfRenderLargeDocument : System.Web.UI.UserControl
    {
        protected int TargetCounter { get; set; }
        protected int ItemCounter { get; set; }

        public PageData RequestedLargeDocument { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        protected static string GetLargeDocumentChapterNumber(object page)
        {
            var obj = page as PageData;
            var match = Regex.Match(obj.PageName, LARGE_DOCUMENT_CHAPTER_HEADING_REGEX, RegexOptions.IgnoreCase);
            return match.Success
                ? match.Groups["number"].ToString()
                : string.Empty;

            //return obj == null ? "" : obj.ChapterNumber;
            return "";
        }

        protected static int GetLargeDocumentChapterLevel(object page)
        {
            var obj = page as PageData;
            PageData currentPage = obj;

            int counter = 0;
            while (IsChapterPage(currentPage))
            {
                var parentPage = DataFactory.Instance.GetPage(currentPage.ParentLink);
                currentPage = parentPage;
                counter++;
            }
            return counter;
            //return obj == null ? 0 : obj.GetChapterLevel();
            return 0;
        }

        private static bool IsChapterPage(PageData currentPage)
        {
            return currentPage.PageTypeName == "LargeDocument";
        }

        private const string LARGE_DOCUMENT_CHAPTER_HEADING_REGEX = @"(?<number>(((\d\.)*\d)+)|vedlegg\s+\d)\s+(?<title>.+)";
        protected static string GetLargeDocumentChapterPageNameWithoutChapterNumber(object page)
        {
            var obj = page as PageData;
            var match = Regex.Match(obj.PageName, LARGE_DOCUMENT_CHAPTER_HEADING_REGEX, RegexOptions.IgnoreCase);
            return match.Success
                ? match.Groups["title"].ToString()
                : obj.PageName;
            //return obj == null ? "" : obj.PageNameWithoutChapterNumber;
            return "";
        }

        protected static string GetStyle(object dataItem)
        {
            return GetLargeDocumentChapterLevel(dataItem) == 1 ? "page‐break‐after : always" : string.Empty;
        }

        protected static string GetLevel(object dataItem)
        {
            return "level" + GetLargeDocumentChapterLevel(dataItem);
        }

        protected string GetMainBody(PageData dataItem)
        {
            if (dataItem != null)
            {
                return string.IsNullOrEmpty(dataItem.Property["MainBody"].ToString())
                           ? ""
                           : dataItem.Property["MainBody"].ToString();
            }
            return "";
        }
    }
}