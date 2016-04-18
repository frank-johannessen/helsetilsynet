using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class Tags : UserControlBase<Model.BasePage>
    {
        public PageData Article { get; set; }
        public List<Category> Categories { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private void BindRepeater()
        {
            var tags = GeTags();
            Visible = tags.Any();

            rptTags.DataSource = tags;
            rptTags.DataBind();
        }

        private IEnumerable<TagItem> GeTags()
        {
            IEnumerable<TagItem> tags = new List<TagItem>();
            if (Categories != null)
            {
                tags = Categories.Select(category => new TagItem(category.GetClassName(), category.Description));
            }

            else if (Article != null && Article.Category != null)
            {
                tags = from cat in Article.Category
                       let category = Category.Find(cat)
                       select new TagItem(category.GetClassName(), category.Description);
            }
            return tags;
        }

        public override void DataBind()
        {
            base.DataBind();
            BindRepeater();
        }
    }

    public class TagItem
    {
        public string ClassName { get; private set; }
        public string Description { get; private set; }

        public TagItem(string className, string description)
        {
            ClassName = className;
            Description = description;
        }
    }
}