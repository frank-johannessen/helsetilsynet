using System;
using System.Web.UI.WebControls;
using EPiServer.SpecializedProperties;
using EPiUtilities.Extensions;
using MakingWaves.Helsetilsynet.Intranet.Web.Caching;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MegaMenuTab3 : CachedUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab3Col1RootNodes, rptCol1);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab3Col2RootNodes, rptCol2);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab3Col3RootNodes, rptCol3);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab3Col4RootNodes, rptCol4);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab3Col5RootNodes, rptCol5);
        }

        private static void DatabindColumn(LinkItemCollection rootNodes, Repeater repeater)
        {
            if (repeater == null || rootNodes == null || rootNodes.Count < 1)
                return;

            repeater.DataSource = rootNodes.ToPageDataCollection();
            repeater.DataBind();
        }
    }
}