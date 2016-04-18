using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.DataAbstraction;
using EPiUtilities.Extensions;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class Section : RelateTemplatePage<Model.Section>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            var sectionCategory = BaseEditorialPage.GetMainCategoryClass(CurrentPage.PageLink);
            CurrentPage.LayoutClassName = "section-front " + sectionCategory;
            
            BindSelectedArticles();
            BindCalendar();
        }

        private void BindCalendar()
        {
            ucCalendar.Calendar = RelateTemplatePage<RelateGlobalSettings>.GlobalCalendar;
            ucCalendar.Categories = new List<Category> { Category.Find(int.Parse(CurrentPage.SectionMainCategory)) };
            ucCalendar.DataBind();
        }

        private void BindSelectedArticles()
        {
            if (CurrentPage.SelectedArticles == null)
                return;

            rptSelectedArticles.DataSource = CurrentPage.SelectedArticles.ToPageDataCollection().OfType<Model.Article>();
            rptSelectedArticles.DataBind();
        }

    }
}