
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using NUnit.Framework;

namespace Helsetilsynet.Intranet.Web.Tests.UC
{
    [TestFixture]
    public class SearchResultTests
    {

        [Test]
        public void TestBuildSearchString()
        {
            var searchSelections = new SearchSelections()
                                       {
                                           SearchString = "søkeord1 søkeord2",
                                           SelectedCategoryList = new List<string> { "cat1value", "cat2value" },
                                           SelectedDocumentTypeList = new List<string> { "dt1value", "dt2value" },
                                           SelectedYearList = new List<string>() {"2010", "2011"}
                                       };

            var docQuery = searchSelections.BuildDocQuery();

            var searchResult = DocQuery.Search(docQuery);

            Console.WriteLine("docQueryString: " + searchResult);


        }
    }
}
