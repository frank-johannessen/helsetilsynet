using System;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.Caching;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MegaMenuTab1 : CachedUserControlBase<Model.BasePage>
    {

        protected Category Col1Category { get; private set; }
        protected Category Col2Category { get; private set; }
        protected Category Col3Category { get; private set; }
        protected Category Col4Category { get; private set; }
        protected Category Col5Category { get; private set; }
        protected PageReference Col1RootNode { get; private set; }
        protected PageReference Col2RootNode { get; private set; }
        protected PageReference Col3RootNode { get; private set; }
        protected PageReference Col4RootNode { get; private set; }
        protected PageReference Col5RootNode { get; private set; }
     
        protected PageData GetPageData(PageReference pageReference)
        {
            if (pageReference == null)
                return null;
            return DataFactory.Instance.GetPage(pageReference);
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Col1RootNode = CurrentPage.MegaMenuSettings.Tab1Col1RootNode;
            DatabindColumn(Col1RootNode, rptCol1);
            Col1Category = GetColumnCategory(Col1RootNode);

            Col2RootNode = CurrentPage.MegaMenuSettings.Tab1Col2RootNode;
            DatabindColumn(Col2RootNode, rptCol2);
            Col2Category = GetColumnCategory(Col2RootNode);

            Col3RootNode = CurrentPage.MegaMenuSettings.Tab1Col3RootNode;
            DatabindColumn(Col3RootNode, rptCol3);
            Col3Category = GetColumnCategory(Col3RootNode);

            Col4RootNode = CurrentPage.MegaMenuSettings.Tab1Col4RootNode;
            DatabindColumn(Col4RootNode, rptCol4);
            Col4Category = GetColumnCategory(Col4RootNode);

            Col5RootNode = CurrentPage.MegaMenuSettings.Tab1Col5RootNode;
            DatabindColumn(Col5RootNode, rptCol5);
            Col5Category = GetColumnCategory(Col5RootNode);
        }

        private Category GetColumnCategory(PageReference col1RootNode)
        {
            if (col1RootNode == null)
                return null;

            var section = DataFactory.Instance.GetPage(col1RootNode) as Model.Section;
            return section == null
                ? null 
                : section.SectionMainCat;
        }

        private static void DatabindColumn(PageReference rootNode, Repeater repeater)
        {
            if (repeater == null || rootNode == null)
                return;

            repeater.DataSource = DataFactory.Instance.GetChildren(rootNode);
            repeater.DataBind();
        }

        protected string GetDescription(Category category)
        {
            return category == null ? string.Empty : category.Description;
        }
    }
}