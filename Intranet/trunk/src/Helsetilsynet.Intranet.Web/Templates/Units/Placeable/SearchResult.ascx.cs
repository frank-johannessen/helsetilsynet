using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class SearchResult : UserControlBase<Model.Search>
    {
        public ISearchFilter SearchFilterInstance { get; set; }
        public string PreDefinedFreetextSearch { get; set; }
        public string ResultText = "Ditt søk på \"{0}\" hadde {1} treff";

        private readonly string SortOrderByDateValue = LanguageManager.Instance.Translate("/SearchFilter/SortOrderByDate");
        private readonly string SortOrderByRelevanceValue = LanguageManager.Instance.Translate("/SearchFilter/SortOrderByRelevance");
        
        protected void Page_Load(object sender, EventArgs e)
        {
            var searchSelections = GetSearchSelections();
            if (!IsPostBack)
            {
                ltrSearchCount.Text = "0";
                PopulateSortOrderList();
            }

            if (string.IsNullOrWhiteSpace(searchSelections.SearchString))
                searchSelections.SearchString = PreDefinedFreetextSearch;

            var docQuery = searchSelections.BuildDocQuery();
            var searchResult = DocQuery.Search(docQuery);

            pager.BindPagerControl(CurrentPage.HitsPerPage.HasValue ? CurrentPage.HitsPerPage.Value : 10, docQuery.Count);
            
            BindSearchResult(searchResult);

            PopulateSearchRelatedControls(docQuery);

        }

        private void PopulateSortOrderList()
        {
            rblSortOrder.DataSource = new List<string> { SortOrderByRelevanceValue, SortOrderByDateValue };
            if (!IsPostBack)
                rblSortOrder.SelectedValue = SortOrderByRelevanceValue;
            rblSortOrder.DataBind();
        }

        private void PopulateSearchRelatedControls(DocQuery docQuery)
        {
            var searchQ = "";
            if (!string.IsNullOrWhiteSpace(GetSearchSelections().SearchString))
                searchQ = GetSearchSelections().SearchString;

            ltrSearchCount.Text = string.Format(ResultText, searchQ, docQuery.Count.ToString(CultureInfo.InvariantCulture));
            rblSortOrder.Visible = true;
        }

        private void BindSearchResult(IEnumerable<ResultElement> searchResult)
        {
            lvSearchResult.DataSource = searchResult;
            lvSearchResult.DataBind();
        }

        private SearchSelections GetSearchSelections()
        {
            var searchSelections = SearchFilterInstance.GetSearchSelections();
            searchSelections.SortOrder = GetSortOrder();

            searchSelections.MaxReturn = CurrentPage.HitsPerPage.HasValue ? CurrentPage.HitsPerPage.Value : 10;
            pager.HitsPerPage = CurrentPage.HitsPerPage.HasValue ? CurrentPage.HitsPerPage.Value : 10;
            searchSelections.ScrollAhead = pager.ScrollAhead;

            return searchSelections;
        }


        private SearchResultSortOrder GetSortOrder()
        {
            if (rblSortOrder.SelectedItem == null)
                return SearchResultSortOrder.Default;

            if (rblSortOrder.SelectedItem.Value==SortOrderByDateValue)
                return SearchResultSortOrder.ByDate;

            if (rblSortOrder.SelectedItem.Value == SortOrderByRelevanceValue)
                return SearchResultSortOrder.ByRelevanse;

            throw new Exception("Sort order value not defined");
        }
    }
}