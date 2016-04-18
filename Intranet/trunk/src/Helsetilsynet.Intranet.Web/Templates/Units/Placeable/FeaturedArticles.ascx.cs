using System;
using System.Collections.Generic;
using System.Linq;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class FeaturedArticles : UserControlBase<BasePage>
    {
        public IEnumerable<Model.Article> Articles { get; set; }

        public string Title { get; set; }

        public string Count { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            rptArticles.DataSource = Articles.ToList();
            rptArticles.DataBind();

            Count = Articles.Count().ToString();
        }
    }
}