using System;
using System.Text.RegularExpressions;
using EPiServer;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "LargeDocumentChapter",
        Description = "LargeDocumentChapter",
        Filename = "/Templates/Pages/LargeDocumentChapter.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int) PageTypeSortOrder.LargeDocumentChapter,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = true,
        AvailablePageTypes = new Type[] {typeof(LargeDocumentChapter)})]
// ReSharper disable ClassWithVirtualMembersNeverInherited.Global
    public class LargeDocumentChapter : BasePage
// ReSharper restore ClassWithVirtualMembersNeverInherited.Global
    {
        private const string LARGE_DOCUMENT_CHAPTER_HEADING_REGEX = @"(?<number>(((\d\.)*\d)+)|vedlegg\s+\d)\s+(?<title>.+)";

        [PageTypeProperty(
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString)) ]
        public virtual string MainBody { get; set; }


        /// <summary>
        /// Uses a regex to extract the chapter number from the page name
        /// </summary>
        public string PageNameWithoutChapterNumber
        {
            get
            {
                var match = Regex.Match(PageName, LARGE_DOCUMENT_CHAPTER_HEADING_REGEX, RegexOptions.IgnoreCase);
                return match.Success 
                    ? match.Groups["title"].ToString() 
                    : PageName;
            }
        }


        /// <summary>
        /// Uses regex to remove chapter information from the page name
        /// </summary>
        public string ChapterNumber
        {
            get
            {
                var match = Regex.Match(PageName, LARGE_DOCUMENT_CHAPTER_HEADING_REGEX, RegexOptions.IgnoreCase);
                return match.Success 
                    ? match.Groups["number"].ToString() 
                    : string.Empty;
            }
        }

        public int GetChapterLevel()
        {

            PageData currentPage = this;

            int counter = 0;
            while (IsChapterPage(currentPage))
            {
                var parentPage = DataFactory.Instance.GetPage(currentPage.ParentLink);
                currentPage = parentPage;
                counter++;
            }
            return counter;
        }

        private static bool IsChapterPage(PageData currentPage)
        {
            return currentPage != null && currentPage.PageTypeName == typeof(LargeDocumentChapter).Name;
        }
    }
}