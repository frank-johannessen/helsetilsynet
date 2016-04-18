using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class LeftMenuLargeDocuments : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PageData mainDocument = LargeDocumentHelper.GetMainDocumentPage(CurrentPage);
            
            PopulateMenu(mainDocument);
            SetMainPageLink(mainDocument);
            SetLinkLevel2();
        }

        private void PopulateMenu(PageData mainDocument)
        {
            ptPageTree.PageLink = mainDocument.PageLink;
        }

        private void SetMainPageLink(PageData mainDocument)
        {
            lnkDocumentMainPage.NavigateUrl = mainDocument.LinkURL;
            lnkDocumentMainPage.Text = mainDocument.PageName;
        }

        private void SetLinkLevel2()
        {
            PageData docAtLevel2 = CurrentPage.GetAncestorAtLevel(2);
            lnkLevel2InMainMenu.NavigateUrl = docAtLevel2.LinkURL;
            lnkLevel2InMainMenu.Text = docAtLevel2.PageName;
        }
    }
}