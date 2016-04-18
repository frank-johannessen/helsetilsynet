using System;
using EPiServer.Core;
using EPiServer.Filters;

namespace Helsetilsynet.templates.Avenir.Classes.Filters
{
    /// <summary>
    /// The filter removes pages that are not of specified page type.
    /// </summary>
    public class PageTypeFilter : IPageFilter
    {
        private readonly string[] _availablePageTypes;

        /// <summary>
        /// Constructs object of PageTypeFilter class
        /// </summary>
        /// <param name="availablePageTypes">Array of page types names. Pages of these types are kept in output PageDataCollection.</param>
        public PageTypeFilter(params string[] availablePageTypes)
        {
            _availablePageTypes = availablePageTypes;
        }

        public void Filter(PageDataCollection pages)
        {
            //no filtering required
            if (_availablePageTypes == null || _availablePageTypes.Length == 0)
                return;

            for (int i = pages.Count - 1; i >= 0; i--)
            {
                if (ShouldFilter(pages[i]))
                {
                    pages.RemoveAt(i);
                }
            }

        }

        public void Filter(object sender, FilterEventArgs e)
        {
            Filter(e.Pages);
        }

        public bool ShouldFilter(PageData pageData)
        {
            foreach (string avaiablePageType in _availablePageTypes)
            {
                if (pageData.PageTypeName.Equals(avaiablePageType, StringComparison.InvariantCultureIgnoreCase))
                {
                    return false;
                }
            }

            return true;
        }
    }
}