using EPiServer;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Classes.Constants;

namespace Helsetilsynet.templates.Avenir.Units.Placeable.LargeDocuments
{
    public partial class MenuOnRootChapter : UserControlBase
    {
        private const string QueryStringDetailsValueTrue = "true";
        private const int SimpleViewLevel = 2;
        private const int DetailedViewLevel = 4;

        protected int GetDisplayNumberOfLevels()
        {
            return IsDisplayDetailedView() ? DetailedViewLevel : SimpleViewLevel;
        }

        protected string GetDetailsLinkUrl()
        {
            return IsDisplayDetailedView() ? CurrentPage.LinkURL : CreateDetailsLinkUrl();
        }

        protected string GetDetailsLinkText()
        {
            return Translate(IsDisplayDetailedView() ? "/LargeDocuments/SimpleTocLinkText" : "/LargeDocuments/DetailedTocLinkText");
        }

        private string CreateDetailsLinkUrl()
        {
            return CurrentPage.LinkURL + "&" + QueryStringName.Details + "=" + QueryStringDetailsValueTrue;
        }

        protected bool IsDisplayDetailedView()
        {
            var detailValue = Request.QueryString[QueryStringName.Details];
            return (detailValue != null && detailValue == QueryStringDetailsValueTrue);
        }

        protected int GetLargeDocumentLevel(PageData pageData)
        {
            int counter = 0;
            PageData currentPage = pageData;
            while(currentPage.PageTypeName == PageTypeName.LargeDocument)
            {
                var parentPage = DataFactory.Instance.GetPage(currentPage.ParentLink);
                currentPage = parentPage;
                counter++;
            }
            return counter;
        }
    }
}