using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ArticleArchiveSearchFilter : UserControlBase<Model.BasePage>, ISearchFilter
    {

        public SearchSelections GetSearchSelections()
        {
            return new SearchSelections()
                       {
                           SelectedYearList = GetSelectedItems(cblYearList),
                           SelectedCategoryList = GetSelectedItems(cblCategoryList),
                       };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCategoryList();
                PopulateYearList();
            }
        }

        private static IList<string> GetSelectedItems(CheckBoxList checkBoxList)
        {
            var selectedItems = checkBoxList.Items.Cast<ListItem>()
                .Where(l => l.Selected)
                .Select(l => l.Value)
                .ToList();

            return selectedItems;
        }

        private void PopulateYearList()
        {
            const int yearCount = SearchConstants.NumberOfSearchYearsInList;
            cblYearList.DataSource = GetYearList(yearCount);
            cblYearList.DataValueField = "Value";
            cblYearList.DataTextField = "Text";
            cblYearList.DataBind();
        }

        private List<ListItem> GetYearList(int yearCount)
        {
            var yearList = Enumerable.Range(DateTime.Now.Year - yearCount + 1, yearCount).OrderByDescending(n => n).Select(n => n.ToString()).Select(n => new ListItem(n, n)).ToList();

            yearList.Add(new ListItem(base.Translate("/SearchFilter/EarlierYears"), SearchConstants.EarlierYearsValue.ToString()));

            return yearList;

        }

        private void PopulateCategoryList()
        {
            cblCategoryList.DataSource = GetCategories();
            cblCategoryList.DataValueField = "Value";
            cblCategoryList.DataTextField = "Text";
            cblCategoryList.DataBind();
        }

        private static IEnumerable<ListItem> GetCategories()
        {
            var categoryQuery = from Category x in Category.GetRoot().Categories
                                select new ListItem(x.Name, x.Name); // Use name instead of ID when searching against Google Mini

            return categoryQuery.ToList();
        }


    }
}
