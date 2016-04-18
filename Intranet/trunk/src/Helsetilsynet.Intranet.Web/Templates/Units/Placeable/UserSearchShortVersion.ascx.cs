using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Common.Security;
using EPiServer.DataAbstraction;
using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class UserSearchShortVersion : RelateUserControlBase<BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Category sectionCategory = null;
            var list = new List<LinkItem>();
            var currentPage = CurrentPage as Section;
            if (currentPage != null)
                sectionCategory = Category.Find(int.Parse((currentPage).SectionMainCategory));
            
            if(sectionCategory != null)
            {
                list.Add(CreateLinkItemFromCategory(sectionCategory));
            }
            else
            {
                var departments = DepartmentHelper.GetAllDepartments();
                list.AddRange(departments.Select(CreateLinkItemFromDepartment));
            }
            lvSearchTerms.DataSource = list;
            lvSearchTerms.DataBind();
        }

        private LinkItem CreateLinkItemFromDepartment(IGroup group)
        {
            return new LinkItem
                        {
                            Href = UriSupport.AddQueryString(RelateTemplatePage<RelateGlobalSettings>.UserSearchPage.LinkURL, "dep" , group.ID.ToString()),
                            Title = group.Name,
                            Text = group.Name
                        };
        }

        private LinkItem CreateLinkItemFromCategory(Category category)
        {
            return new LinkItem
                       {
                           Href = UriSupport.AddQueryString(RelateTemplatePage<RelateGlobalSettings>.UserSearchPage.LinkURL, "cat", category.ID.ToString()),
                           Title = category.Name,
                           Text = category.Name
                       };
        }
    }
}