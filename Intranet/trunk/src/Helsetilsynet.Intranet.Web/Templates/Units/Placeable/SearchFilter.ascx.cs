using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Util;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{

    public partial class SearchFilter : UserControlBase<Model.BasePage>, ISearchFilter
    {
        /// <summary>
        /// Used with paging, to prevent refresh (with search count) of the filter
        /// </summary>
        public bool DoNotPopulate { set; private get; }

        public string PreDefinedFreetextSearch { get; set; }

        private SearchSelections _selectedSearchSelectionsFromPostback;

        private static readonly List<ListItem> Collections = new List<ListItem>
                                                         {
                                                             new ListItem("Losen", SearchCollections.LosenCollection),
                                                             new ListItem("Helsetilsynet.no",
                                                                          SearchCollections.HelsetilsynetNO),
                                                             new ListItem("HR-portal",
                                                                          SearchCollections.CompendiaCollection)
                                                         };

        /// <summary>
        /// The search criterias set by the user
        /// </summary>
        /// <returns></returns>
        public SearchSelections GetSearchSelections()
        {
            return new SearchSelections
                       {
                               SearchString = GetSearchString(),
                               
                               SelectedDocumentTypeList = GetSelectedItems(cblDocumentTypeList),
                               SelectedCategoryList = GetSelectedItems(cblCategoryList),
                               SelectedYearList = GetSelectedItems(cblYearList),
                               SelectedCollectionsList = GetSelectedCollections(cblCollections),
                               NotDocumentTypeList = GetNotDocumentTypeList()
                           };
        }

        private string GetSearchString()
        {
            if (!string.IsNullOrWhiteSpace(tbxSearchString.Text))
                return tbxSearchString.Text;

            if (!string.IsNullOrWhiteSpace(PreDefinedFreetextSearch))
                return PreDefinedFreetextSearch;

            return string.Empty;
        }

        private List<string> GetNotDocumentTypeList()
        {
            if (chbRemoveInspectionReports.Checked)
            {
                return new List<string> { SearchConstants.SearchKey_InspectionReport };
            }
            return new List<string>();
        }

        private static IList<string> GetSelectedItems(CheckBoxList checkBoxList)
        {
            var selectedItems = checkBoxList.Items.Cast<ListItem>()
                .Where(l => l.Selected)
                .Select(l => l.Value)
                .ToList();

            return selectedItems;
        }

        private IList<string> GetSelectedCollections(CheckBoxList checkBoxList)
        {
            var selectedItems = checkBoxList.Items.Cast<ListItem>()
                .Where(l => l.Selected)
                .Select<ListItem, string>(l => GetCollectionValue(l.Text))
                .ToList();

            return selectedItems;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (DoNotPopulate)
                return;

            if (IsPostBack)
            {
                _selectedSearchSelectionsFromPostback = GetSearchSelections();
            }
            PopulateFreetextSearchBox();
            
            PopulateDocumentTypeList();
            PopulateCategoryList();
            PopulateYearList();
            PopulateCollectionsList();
            
            if (IsPostBack)
            {
                SetCheckedItems();
            }
        }

        private void PopulateFreetextSearchBox()
        {
            if (!string.IsNullOrWhiteSpace(PreDefinedFreetextSearch))
                tbxSearchString.Text = PreDefinedFreetextSearch;
        }

        private void PopulateCollectionsList()
        {
            // TODO: NEIO: sikre at key/value blir korrekt

            cblCollections.DataSource = Collections;
            cblDocumentTypeList.DataValueField = "Value";
            cblDocumentTypeList.DataTextFormatString = "Text";
            cblCollections.DataBind();
        }

        private void SetCheckedItems()
        {
            SetCheckedItems(_selectedSearchSelectionsFromPostback.SelectedCategoryList, cblCategoryList);
            SetCheckedItems(_selectedSearchSelectionsFromPostback.SelectedDocumentTypeList, cblDocumentTypeList);
            SetCheckedItems(_selectedSearchSelectionsFromPostback.SelectedYearList, cblYearList);
            SetCheckedCollections(_selectedSearchSelectionsFromPostback.SelectedCollectionsList, cblCollections);
        }

        private void PopulateDocumentTypeList()
        {
            cblDocumentTypeList.DataSource = GetDocumentTypes();
            cblDocumentTypeList.DataValueField = "Value";
            cblDocumentTypeList.DataTextFormatString = "Text";
            cblDocumentTypeList.DataBind();
        }

        private object GetDocumentTypes()
        {
            return CheckBoxLists.GetCheckBoxListSettings(CurrentPage, "DocumentType");
        }

        private void PopulateCategoryList()
        {
            cblCategoryList.DataSource = GetCategories();
            cblCategoryList.DataValueField = "Value";
            cblCategoryList.DataTextFormatString = "Text";
            cblCategoryList.DataBind();
        }

        private static void SetCheckedItems(IList<string> selectedItemsList, CheckBoxList checkBoxList)
        {
            foreach (ListItem listItem in checkBoxList.Items)
            {
                listItem.Selected = selectedItemsList.Any(e => e == listItem.Value);
            }
        }

        private void SetCheckedCollections(IList<string> selectedCollectionsList, CheckBoxList checkBoxList)
        {
            foreach (ListItem listItem in checkBoxList.Items)
            {
                listItem.Selected = selectedCollectionsList.Any(e => e == GetCollectionValue(listItem.Text));
            }
        }

        private string GetCollectionValue(string text)
        {
            var retval = Collections.Where(o => o.Text == text).Select(o => o.Value).FirstOrDefault();
            return retval;
        }
        
        private static IEnumerable<ListItem> GetCategories()
        {
            return (from Category x in Category.GetRoot().Categories
                    select new ListItem(x.Name, x.Name)).ToList();
        }

        private void PopulateYearList()
        {
            const int yearCount = SearchConstants.NumberOfSearchYearsInList;

            cblYearList.DataSource = GetYearList(yearCount);
            cblYearList.DataValueField = "Value";
            cblYearList.DataTextField = "Text";
            cblYearList.DataBind();
        }

        private IEnumerable<ListItem> GetYearList(int yearCount)
        {
            var yearList = Enumerable.Range(DateTime.Now.Year - yearCount + 1, yearCount)
                .OrderByDescending(n => n)
                .Select(n => n.ToString())
                .Select(n => new ListItem(n,n))
                .ToList();

            yearList.Add(new ListItem(base.Translate("/SearchFilter/EarlierYears"), SearchConstants.EarlierYearsValue.ToString()));

            return yearList;
        }

    }
}