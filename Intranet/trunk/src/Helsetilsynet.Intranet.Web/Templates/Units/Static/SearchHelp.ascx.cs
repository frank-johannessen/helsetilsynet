using System;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class SearchHelp : UserControlBase<Model.Search>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Visible =
                !(string.IsNullOrEmpty(CurrentPage.RightContentHeading) ||
                  string.IsNullOrEmpty(CurrentPage.RightContent));
        }
    }
}