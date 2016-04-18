using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class SectionLastPublished : UserControlBase<Model.Section>
    {
        protected string FormatDateTime(DateTime? dateTime, string format, string alternativeValue)
        {
            return dateTime.HasValue ? dateTime.Value.ToString(format) : alternativeValue;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateLastPublishedLosen();
            PopulateLastPublishedHtil();
        }

        private void PopulateLastPublishedLosen()
        {
            PopulateRepeater(rptLastPublishedLosen, SearchCollections.LosenCollection);
        }

        private void PopulateLastPublishedHtil()
        {
            PopulateRepeater(rptLastPublishedHtil, SearchCollections.HelsetilsynetNO);
        }

        private void PopulateRepeater(Repeater repeater, string searchCollection)
        {
            var selections = new SearchSelections
                                 {
                                     SelectedCategoryList = new List<string> {CurrentPage.SectionMainCat.Name},
                                     SelectedCollectionsList = new List<string> {searchCollection},
                                     MaxReturn = CurrentPage.NumberOfItemsInLastPublished ?? 10,
                                     SortOrder = SearchResultSortOrder.ByDate
                                 };
            var query = selections.BuildDocQuery();
            query.ExecuteQuery();


            repeater.DataSource = query.Results;
            repeater.DataBind();
        }
    }
}