using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;


// Example url: http://losen.helsetilsynet.no/Ansatte-og-fagomrader/?cat=2_3&dep=19_20

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class UserSearch : RelateTemplatePage<Model.UserSearch>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "user-search";

            PopulateLists();
            
            var userSearchQueryStringReader = CreateUserSearchSelectionsFromQueryString();

            SetSelectedValuesInFormBasedOnQueryString(userSearchQueryStringReader);

            //Note:  Search result is set using Ajax call against the UserSearchService.asmx
            
            PopulateInitialResult(userSearchQueryStringReader);

        }

        private void PopulateLists()
        {
            PopulateServiceList();
            PopulateDepartmentList();
            PopulateCountyList();

            PopulateProfessionsList();
            PopulateDoctorSpecialitiesList();
            PopulateNurseSpecialitiesList();
            PopulateOtherProfessionsList();
            PopulateTasksList();
        }

        private void PopulateInitialResult(UserSearchQueryStringReader userSearchQueryStringReader)
        {
            
            var userSearchParameters = CreateUserSearchParametersFromQueryString(userSearchQueryStringReader);

            var maxResultFromProperty = CurrentPage.MaxResult;

            var maxResult = maxResultFromProperty.HasValue && maxResultFromProperty.Value > 0
                                ? maxResultFromProperty.Value
                                : int.MaxValue;
            
            int totalResult;
            var result = Util.UserSearch.UserSearch.Search(userSearchParameters, "", maxResult, out totalResult);

            rltUsers.Users = result;
            rltUsers.TotalResult = totalResult;
            rltUsers.DataBind();

        }

        private static UserSearchParameters CreateUserSearchParametersFromQueryString(UserSearchQueryStringReader userSearchQueryStringReader)
        {
            //TODO: Temporarily convert to names. Should use IDs for dep and cat when IDs and not names are returned from JS Ajax!

            return new UserSearchParameters
                       {
                           Departments =
                               userSearchQueryStringReader.DepartmentIds.Select(
                                   did => DepartmentHelper.GetDepartment(did).Name).ToList(),
                           Services =
                               userSearchQueryStringReader.CategoryIds.Select(
                                   cid => Category.Find(cid).Name).ToList()
                       };
        }


        private void SetSelectedValuesInFormBasedOnQueryString(UserSearchQueryStringReader userSearchQueryStringReader)
        {
            SetSelectedCategoryList(userSearchQueryStringReader);
            SetSelectedDepartmentList(userSearchQueryStringReader);
        }

        
        private void SetSelectedDepartmentList(UserSearchQueryStringReader userSearchQueryStringReader)
        {
            SetSelectedValues(userSearchQueryStringReader.DepartmentIds, cblDepartmentList.Items);

            if (AnyChecked(cblDepartmentList))
                cbxSelectAllDepartments.Checked = false;

        }

        private void SetSelectedCategoryList(UserSearchQueryStringReader userSearchQueryStringReader)
        {
            SetSelectedValues(userSearchQueryStringReader.CategoryIds, cblCategoryList.Items);

            if (AnyChecked(cblCategoryList))
                cbxSelectAllCategories.Checked = false;
            
        }

        private static bool AnyChecked(CheckBoxList checkBoxList)
        {
            return checkBoxList.Items.Cast<ListItem>().Any(e => e.Selected);
        }

        
        private UserSearchQueryStringReader CreateUserSearchSelectionsFromQueryString()
        {
            var userSearchSelections = UserSearchQueryStringReader.CreateFromQueryString(Request.QueryString);
            return userSearchSelections;
        }

        // More info here: http://karolikl.blogspot.no/2009/09/using-query-system-in-episerver.html
        
        private void PopulateServiceList()
        {
            Bind(cblCategoryList, GetServices());
        }
        
        private void PopulateDepartmentList()
        {
            Bind(cblDepartmentList, GetDepartments());
        }

        private void PopulateCountyList()
        {
            Bind(ddlCounty, GetCounties());
        }

        private void PopulateProfessionsList()
        {
            Bind(cblProfessions, GetProfessions());
        }

        private void PopulateDoctorSpecialitiesList()
        {
            Bind(ddlDoctorSpecialties, GetDoctorSpecialities());
        }

        private void PopulateNurseSpecialitiesList()
        {
            Bind(ddlNurseSpecialties,GetNurseSpecialities());
        }

        private void PopulateOtherProfessionsList()
        {
            Bind(ddlOtherProfessions, GetOtherProfessions());
        }

        private void PopulateTasksList()
        {
            Bind(cblTasks,GetTasks());
        }

        private void Bind(DropDownList dropDownList, List<ListItem> list)
        {
            dropDownList.DataSource = list;
            dropDownList.Items.Add(new ListItem("Alle", string.Empty));
            dropDownList.AppendDataBoundItems = true;
            dropDownList.DataValueField = "Value";
            dropDownList.DataTextField = "Text";
            dropDownList.DataBind();
        }

        private static void Bind(CheckBoxList checkBoxList, List<ListItem> departments)
        {
            checkBoxList.DataSource = departments;
            checkBoxList.DataValueField = "Value";
            checkBoxList.DataTextField = "Text";
            checkBoxList.DataBind();
        }
        
        private static void Bind(CheckBoxList checkBoxList, CategoryCollection categories)
        {
            checkBoxList.DataSource = categories;
            checkBoxList.DataValueField = "ID";
            checkBoxList.DataTextField = "Name";
            checkBoxList.DataBind();
        }

        private static CategoryCollection GetServices()
        {
            return Category.GetRoot().Categories;
        }

        private static List<ListItem> GetDepartments()
        {
            return DepartmentHelper.GetAllDepartments().Select(g => new ListItem(g.Name, g.ID.ToString())).ToList();
        }

        private static List<ListItem> GetCounties()
        {
            return DepartmentHelper.GetAllFylkesmannsEmbete().Select(o => new ListItem(o.Name, o.ID.ToString())).ToList();
        }

        private static List<ListItem> GetProfessions()
        {
            return RelateTemplatePage<RelateGlobalSettings>.Professions.Select(ToListItem).ToList();
        }

        private static List<ListItem> GetDoctorSpecialities()
        {
            return RelateTemplatePage<RelateGlobalSettings>.PhysicianSpecialties.Select(ToListItem).ToList(); 
        }

        private static List<ListItem> GetNurseSpecialities()
        {
            return RelateTemplatePage<RelateGlobalSettings>.NurseSpecialties.Select(ToListItem).ToList(); 
        }

        private static List<ListItem> GetOtherProfessions()
        {
            return RelateTemplatePage<RelateGlobalSettings>.OtherProfessions.Select(ToListItem).ToList(); 
        }

        private static List<ListItem> GetTasks()
        {
            return RelateTemplatePage<RelateGlobalSettings>.Tasks.Select(ToListItem).ToList();
        }
        
        private static ListItem ToListItem(string s)
        {
            return new ListItem(s,s);
        }


        private static void SetSelectedValues(IEnumerable<int> selectedValues, ListItemCollection listItemCollection)
        {
            listItemCollection.Cast<ListItem>()
                .ForEach(c => c.Selected = IsInSelectedList(selectedValues, c) );
        }

        private static bool IsInSelectedList(IEnumerable<int> selectedValues, ListItem c)
        {
            return selectedValues.Any(s => s.ToString() == c.Value);
        }
        
        protected void cblProfessions_OnDataBOund(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                li.Attributes.Add("class", "profession-selector profession-" + li.Value.ToLower());
            }
        }
        
        protected void cblDepartmentList_OnDataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                li.Attributes.Add("class", "department-selector department-" + li.Text.ToLower().Replace(" ", ""));
                li.Attributes.Add("alt", li.Value);
            }
        }

        protected void cblCategoryList_OnDataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                li.Attributes.Add("alt", li.Value);
            }
        }

        protected string GetMaxResults()
        {
            return CurrentPage.MaxResult != null && !string.IsNullOrWhiteSpace(CurrentPage.MaxResult.ToString()) ? CurrentPage.MaxResult.ToString() : "50";
        }

        protected void ddlOtherProfessions_OnDataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((DropDownList)sender).Items)
            {
                if(!string.IsNullOrWhiteSpace(li.Value))
                    li.Value = string.Format("other{0}", li.Value);
            }
        }
    }
}