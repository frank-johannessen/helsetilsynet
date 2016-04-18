using System.Collections.Generic;
using System.Linq;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini;
using MakingWaves.Helsetilsynet.Util.GoogleMini;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    /// <summary>
    /// Used to get keep values for seaches against GoogleMini and to create a <see cref="DocQuery"/> (using the <see cref="BuildDocQuery"/> method).
    /// Lists should only contain values indexed by GoogleMini.
    /// </summary>
    public class SearchSelections
    {

        /// <summary>
        /// Select only pages 
        /// </summary>
        public int EPiParentPageId { get; set; }
        
        public IList<string> SelectedDocumentTypeList { get; set; }

        public IList<string> SelectedCategoryList { get; set; }

        public IList<string> SelectedYearList { get; set; }

        public IList<string> NotDocumentTypeList { get; set; }

        public string SearchString { get; set; }

        public SearchResultSortOrder SortOrder { get; set; }

        /// <summary>
        /// Restrict search results to these many at most.
        /// </summary>
        public int MaxReturn { get; set; }

        /// <summary>
        /// Scroll ahead to display (n+1)th result as the first result. 
        /// </summary>
        public int ScrollAhead { get; set; }

        public IList<string> SelectedCollectionsList { get; set; }

        //TEST
        public DocQuery BuildDocQuery()
        {
            var docQuery = new DocQuery();

            docQuery.Collection = SearchCollections.CombinedCollection;
            if (SelectedCollectionsList != null && SelectedCollectionsList.Count > 0)
                docQuery.Collection = string.Join("|", SelectedCollectionsList);

            AddListItemToDocQuery(docQuery, SearchConstants.SearchKey_DocumentType, SelectedDocumentTypeList);
            AddListItemToDocQuery(docQuery, SearchConstants.SearchKey_Category, SelectedCategoryList);
            AddListItemToDocQuery(docQuery, SearchConstants.GetNotExpression(SearchConstants.SearchKey_DocumentType), NotDocumentTypeList);
            AddListItemToDocQuery(docQuery, SearchConstants.SearchKey_Year, GetYearList());

            AddItemToDocQuery(docQuery, SearchConstants.SearchKey_EPiParentPageId, EPiParentPageId);

            docQuery.Query = SearchString;

            docQuery.SortbyDate = SortOrder == SearchResultSortOrder.ByDate;

            if (MaxReturn > 0)
                docQuery.MaxReturn = MaxReturn;

            if (ScrollAhead > 0)
                docQuery.Scroll = ScrollAhead;

            return docQuery;
        }

        private void AddItemToDocQuery(DocQuery docQuery, string searchKeyEPiParentPageId, int value)
        {
            if(value>0)
                docQuery.AddSearchItem(new SearchItem(searchKeyEPiParentPageId, new List<string>{value.ToString()}));
        }

        private IEnumerable<string> GetYearList()
        {
            var selectedYears = GetSelectedYears();
            var previousYears = GetEarlierYearList();

            var concatList = selectedYears.Concat(previousYears);

            return concatList;
        }

        private IEnumerable<string> GetSelectedYears()
        {
            if(SelectedYearList == null)
                return new List<string>();
            
            return SelectedYearList.Where(y => y != SearchConstants.EarlierYearsValue.ToString());
        }

        private IEnumerable<string> GetEarlierYearList()
        {
            if (SelectedYearList == null)
                return new List<string>();
            
            if (SelectedYearList.Any(y => y == SearchConstants.EarlierYearsValue.ToString()))
            {
                const int numOfYears = SearchConstants.SearchNumberOfYearsEarliery;
                return Enumerable.Range(SearchConstants.MinSearchYearInList - numOfYears, numOfYears).Select(e => e.ToString()).ToList();
            }
            return new List<string>();
        }

        private static void AddListItemToDocQuery(DocQuery docQuery, string key, IEnumerable<string> itemList)
        {
            if (itemList == null || !itemList.Any() )
                return;

            if(string.IsNullOrEmpty(key))
                return;

            var categorySearchItem = new SearchItem(key, itemList.ToList());
            docQuery.AddSearchItem(categorySearchItem);
        }
    }

}