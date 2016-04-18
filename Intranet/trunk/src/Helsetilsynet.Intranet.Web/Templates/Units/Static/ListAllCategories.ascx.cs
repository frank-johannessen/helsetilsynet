using System;
using System.Linq;
using System.Text;
using EPiServer.DataAbstraction;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class ListAllCategories : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected static string ListCategories()
        {
            return Category.GetRoot().Categories.Cast<Category>()
                .Aggregate(new StringBuilder(),
                           (stringBuilder, category) => stringBuilder.Append(
                               string.Format(
                                   "<p>CategoryId = {0}, CategoryName = {1}, CategoryDescription = {2}</p>",
                                   category.ID, category.Name, category.Description)))
                .ToString();
        }
    }
}