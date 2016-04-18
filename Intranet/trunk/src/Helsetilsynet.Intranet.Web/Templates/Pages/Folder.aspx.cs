using System;
using EPiServer;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class Folder : RelateTemplatePage<Model.Folder>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            rptChildren.DataSource = DataFactory.Instance.GetChildren(CurrentPage.PageLink);
            rptChildren.DataBind();
        }
    }
}