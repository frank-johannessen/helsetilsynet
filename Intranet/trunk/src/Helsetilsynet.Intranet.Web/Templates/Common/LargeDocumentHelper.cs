using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages;
using LargeDocumentChapter = MakingWaves.Helsetilsynet.Intranet.Web.Model.LargeDocumentChapter;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common
{
    /// <summary>
    /// Used in navigation to find documents related to a <see cref="LargeDocumentChapter" />
    /// </summary>
    public static class LargeDocumentHelper
    {
        /// <summary>
        /// Returns first ancestor of type <see cref="LargeDocument"/>
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        public static PageData GetMainDocumentPage(PageData page)
        {

            var currentPage = page;

            while (currentPage != null)
            {
                if (PageIsOfType<LargeDocument>(currentPage))
                    return currentPage;

                currentPage = GetPage(currentPage.ParentLink);
            }

            throw new Exception("Invalid document structure! Could not find parent page of type " + typeof(LargeDocument).Name);
        }

        public static PageData GetPreviousClosestDocument(PageData page)
        {
            var prevPage = GetPrevSibelingOrNull(page);

            if (prevPage == null)
                prevPage = GetParentPage(page);

            return prevPage;
        }

        public static PageData GetNextClosestDocuemnt(PageData page)
        {
            var nextPage = GetNextSibelingOrNull(page);

            if (nextPage == null)
                nextPage = GetNextClosestDocumentOrNull(page);

            return nextPage;
        }

        private static bool PageIsOfType<T>(PageData page)
        {
            return page.PageTypeName == typeof(T).Name;
        }

        private static PageData GetNextSibelingOrNull(PageData currentPage)
        {
            var sibelings = GetSibelings(currentPage);
            var maxIndex = Enumerable.Count(sibelings) - 1;
            var indexOfCurrent = GetIndexOfPageInArray(sibelings, currentPage);

            if (indexOfCurrent >= maxIndex) // current doc is the last 
                return null;

            return sibelings[indexOfCurrent + 1];

        }

        private static PageData GetPrevSibelingOrNull(PageData currentPage)
        {
            List<PageData> sibelings = GetSibelings(currentPage);
            const int minIndex = 0;
            var indexOfCurrent = GetIndexOfPageInArray(sibelings, currentPage);

            if (indexOfCurrent <= minIndex) // current doc is the last 
                return null;

            return sibelings[indexOfCurrent - 1];
        }

        private static List<PageData> GetSibelings(PageData currentPage)
        {
            var parent = currentPage.ParentLink;
            return DataFactory.Instance.GetChildren(parent).ToList();
        }

        private static int GetIndexOfPageInArray(IList<PageData> list, PageData page)
        {
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].PageLink.ID == page.PageLink.ID)
                    return i;
            }
            throw new Exception("Could not find page in list");

        }

        private static PageData GetNextClosestDocumentOrNull(PageData page)
        {
            var currentPage = GetParentPage(page);

            while(currentPage!=null && PageIsOfType<LargeDocumentChapter>(currentPage))
            {
                var parentSibeling = GetNextSibelingOrNull(currentPage);
                if (parentSibeling != null) 
                    return parentSibeling;

                currentPage = GetParentPage(currentPage);
            }
            return null; 
        }



        private static PageData GetPage(PageReference pageReference)
        {
            return DataFactory.Instance.GetPage(pageReference);
        }

        private static PageData GetParentPage(PageData parent)
        {
            return GetPage(parent.ParentLink);
        }



    }
}