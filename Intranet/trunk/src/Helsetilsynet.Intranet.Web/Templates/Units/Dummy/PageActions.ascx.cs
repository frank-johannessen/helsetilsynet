using System;
using EPiServer.Core;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Dummy
{
    public partial class PageActions : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = CurrentPage.PageLink.ID != PageReference.StartPage.ID;
        }
    }
}