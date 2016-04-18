using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Common.Security;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class PhoneList : RelateTemplatePage<Model.PhoneList>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "phone-list";

            var department = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(CurrentPage.Department);
            if (department == null) 
                return;
            rptPhoneList.DataSource = GetPhoneListForDepartment(department.Name);
            rptPhoneList.DataBind();
        }

        private static IEnumerable<IUser> GetPhoneListForDepartment(string departmentName)
        {
            var userSearchParameters = new UserSearchParameters { Departments = new List<string> { departmentName } };
            var searchResult = UserParameterSearch.SearchReturnAll(userSearchParameters);

            return searchResult;
        }
    }
}