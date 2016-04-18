using System;
using EPiServer;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Classes.Constants;

namespace Helsetilsynet.templates.Avenir.Units.Placeable.LargeDocuments
{
    public partial class LeftMenuLargeDocuments : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PageData mainDocument = GetMainDocumentPage();
            PopulateMenu(mainDocument);
        }

        private void PopulateMenu(PageData mainDocument)
        {
            ptPageTree.PageLink = mainDocument.PageLink;
        }

        public PageData GetMainDocumentPage()
        {
            PageData currentPage = CurrentPage;
            PageData parentPage = DataFactory.Instance.GetPage(currentPage.ParentLink);

            while (parentPage.PageTypeName == PageTypeName.LargeDocument)
            {
                currentPage = parentPage;
                parentPage = DataFactory.Instance.GetPage(parentPage.ParentLink);
            }

            return currentPage;
        }

        public static string PageNameWithMaxLength(PageData page, int maxLength)
        {
            var pageName = page.PageName;

            if (pageName.Length > maxLength)
                return pageName.Substring(0, maxLength) + "...";

            return pageName;
        }
    }
}