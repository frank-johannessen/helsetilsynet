using System;
using System.Web.UI.WebControls;
using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.Caching;
using EPiUtilities.Extensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MegaMenuTab2 : CachedUserControlBase<Model.BasePage>
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab2Col1RootNodes, rptCol1);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab2Col2RootNodes, rptCol2);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab2Col3RootNodes, rptCol3);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab2Col4RootNodes, rptCol4);
            DatabindColumn(CurrentPage.MegaMenuSettings.Tab2Col5RootNodes, rptCol5);

            externalSystem1.ExternalSystem = CurrentPage.MegaMenuSettings.ExternalSystem1;
            externalSystem2.ExternalSystem = CurrentPage.MegaMenuSettings.ExternalSystem2;
            externalSystem3.ExternalSystem = CurrentPage.MegaMenuSettings.ExternalSystem3;
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