using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public class SearchConstants
    {
        // Used as search keys against google mini

        public const string SearchKey_Category = "kategori";
        public const string SearchKey_DocumentType = "dokumenttype";
        public const string SearchKey_Year = "year";
        public const string SearchKey_EPiParentPageId = "parentid"; 
        
        public const string SearchKey_InspectionReport = "Tilsynsrapport";

        public static string GetNotExpression(string searchKey)
        {
            return "-" + searchKey;
        }

        /// <summary>
        /// Number of years (from current year) to display in search filters
        /// </summary>
        public const int NumberOfSearchYearsInList = 5;

        /// <summary>
        /// When earlier years is selected, this is the number of years searched back in time, before MinSearchYearInList
        /// </summary>
        public const int SearchNumberOfYearsEarliery = 30;

        public static int MinSearchYearInList { get { return DateTime.Now.Year - NumberOfSearchYearsInList + 1; } }

        public const int EarlierYearsValue = 0;

        
    }
}