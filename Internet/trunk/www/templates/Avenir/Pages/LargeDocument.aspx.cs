using System;
using EPiServer;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Classes.Constants;
using Helsetilsynet.templates.Avenir.Classes.Filters;

namespace Helsetilsynet.templates.Avenir.Pages
{
    public partial class LargeDocument : TemplatePage
    {
        private PageDataCollection resultPages = new PageDataCollection();

        protected override void OnLoad(System.EventArgs e)
        {
            GeneratePdf.PageToConvert = CurrentPage;
            GeneratePdf.DataBind();
            phDocumentTableOfContents.Visible = IsLargeDocumentRootPage();

            if (!IsLargeDocumentRootPage())
            {
                GetAllDocsBelow();
            }
        }

        private void GetAllDocsBelow()
        {
            GetAllChildren(CurrentPage.PageLink);
            new PageTypeFilter(PageTypeName.LargeDocument).Filter(resultPages);

            phContentOfBelowDocs.Visible = true;
            rptBelowDocs.DataSource = resultPages;
            rptBelowDocs.DataBind();
        }
        protected string Date
        {
            get
            {
                return CurrentPage["AltPubDate"] != null && CurrentPage["AltPubDate"].ToString() != string.Empty
                           ? DateTime.Parse(CurrentPage.Property["AltPubDate"].ToString()).ToShortDateString()
                           : CurrentPage.StartPublish.ToShortDateString();
            }
        }

        private bool IsLargeDocumentRootPage()
        {
            if (DataFactory.Instance.GetPage(CurrentPage.ParentLink).PageTypeName == PageTypeName.LargeDocument)
                return false;
            return true;
        }

        private void GetAllChildren(PageReference pageLink)
        {
            var children = GetChildren(pageLink);
            foreach (var child in children)
            {
                resultPages.Add(child);
                GetAllChildren(child.PageLink);
            }
        }
    }
}