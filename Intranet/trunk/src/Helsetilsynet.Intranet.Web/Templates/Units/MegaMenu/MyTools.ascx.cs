using System;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MyTools : RelateUserControlBase<BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lvExternalSystems.DataSource = CurrentUser.GetExternalSystemsId();
            lvExternalSystems.DataBind();
        }
    }
}