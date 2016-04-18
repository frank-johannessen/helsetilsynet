using System;
using System.Collections.Generic;
using System.Text;
using EPiServer;
using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Units.Placeable
{
    public partial class SearchSummary : UserControlBase
    {
        private string hitsCount = "0";

        public string Query { get; set; }
        public List<string> Filters { get; set; }

        public string HitsCount
        {
            get { return hitsCount; }
            set { hitsCount = value; }
        }

        protected override void OnDataBinding(EventArgs e)
        {
            litSearchSummary.Text = PrepareSearchSummary();
        }

        private string PrepareSearchSummary()
        {
            //"Ditt søk på tilsyn og barnevern med filter tilsynsmelding og forskrift hadde 135 treff"
            
            var searchSummary = new StringBuilder();

            if (string.IsNullOrEmpty(Query) && (Filters == null || Filters.Count == 0))
            {
                searchSummary.Append(string.Format("{0} {1} {2} {3}",
                    LanguageManager.Instance.Translate("/search/summary/yoursearch"),
                    LanguageManager.Instance.Translate("/search/summary/found"),
                    HitsCount,
                    LanguageManager.Instance.Translate("/search/summary/hits")));

                return searchSummary.ToString();
            }

            var searchKeywords = Query.Split(new[] { " " }, StringSplitOptions.RemoveEmptyEntries);
            searchSummary.Append(string.Format("{0} ", LanguageManager.Instance.Translate("/search/summary/yoursearch")));

            if (searchKeywords.Length != 0)
                searchSummary.Append(string.Format("{0} ", LanguageManager.Instance.Translate("/search/summary/for")));

            for (int i = 0; i < searchKeywords.Length; i++)
            {
                searchSummary.Append(string.Format("<i>{0}</i>", searchKeywords[i]));
                if (i < searchKeywords.Length - 2)
                    searchSummary.Append(", ");
                else if (i == searchKeywords.Length - 2)
                    searchSummary.Append(string.Format(" {0} ", LanguageManager.Instance.Translate("/search/summary/and")));
            }

            if (Filters.Count != 0)
            {
                searchSummary.Append(string.Format(" {0} ", LanguageManager.Instance.Translate("/search/summary/withfilter")));
            }

            for (int i = 0; i < Filters.Count; i++)
            {
                searchSummary.Append(string.Format("<i>{0}</i>", Filters[i]));
                if (i < Filters.Count - 2)
                    searchSummary.Append(", ");
                else if (i == Filters.Count - 2)
                    searchSummary.Append(string.Format(" {0} ", LanguageManager.Instance.Translate("/search/summary/and")));
            }

            searchSummary.Append(string.Format(" {0} {1} {2}",
                                               LanguageManager.Instance.Translate("/search/summary/found"),
                                               HitsCount,
                                               LanguageManager.Instance.Translate("/search/summary/hits")));

            return searchSummary.ToString();
        }
    }
}