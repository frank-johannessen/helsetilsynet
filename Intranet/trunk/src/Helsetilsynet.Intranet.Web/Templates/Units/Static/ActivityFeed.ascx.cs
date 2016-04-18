using System;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class ActivityFeed : UserControlBase<Model.StartPage>
    {
        public string CssClass { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ActivityFeed1.CssClass = "activity-feed" + (String.Empty.Equals(CssClass) ? "" : " " + CssClass);
        }
    }
}