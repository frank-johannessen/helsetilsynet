using System;
using System.Collections.Generic;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using NUnit.Framework;

namespace Helsetilsynet.Intranet.Web.Tests
{
    [TestFixture]
    public class SearchIntegrationTests
    {

        [Test]
        public void GetSearchResultFromHelsetilsynetNo2()
        {
            var searchSelections = new SearchSelections()
                                       {
                                           SearchString = "",
                                           SelectedDocumentTypeList = new List<string>() {"brev"},
                                           SortOrder = SearchResultSortOrder.ByRelevanse
                                       };

            var docQuery = searchSelections.BuildDocQuery();

            docQuery.ExecuteQuery();
            List<ResultElement> resultElements = docQuery.Results;

            var result = DocQuery.Search(docQuery);

            Console.WriteLine(result);
        }


        [Test]
        public void TestTime()
        {
            var searchSelections = new SearchSelections()
            {
                SearchString = "",
                SelectedDocumentTypeList = new List<string>(){ "brev" },
                SortOrder = SearchResultSortOrder.ByRelevanse
            };

        }
       
    }
}
