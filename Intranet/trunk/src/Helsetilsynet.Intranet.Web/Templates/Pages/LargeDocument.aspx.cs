using System;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class LargeDocument : RelateTemplatePage<Model.LargeDocument>
    {
        private const int SimpleViewLevel = 2;
        private const int DetailedViewLevel = 4;

        private const string QueryStringDetailsValueTrue = "true";

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "large-doc-toc";

            author.DataBind();
        }

        protected int GetDisplayNumberOfLevels()
        {
            return IsDisplayDetailedView() ? DetailedViewLevel : SimpleViewLevel;
        }

        protected string GetDetailsLinkText()
        {
            return Translate(IsDisplayDetailedView() ? "/LargeDocuments/SimpleTocLinkText" : "/LargeDocuments/DetailedTocLinkText");
        }

        protected string GetDetailsLinkUrl()
        {
            return IsDisplayDetailedView() ? CurrentPage.LinkURL : CreateDetailsLinkUrl();
        }

        private string CreateDetailsLinkUrl()
        {
            return CurrentPage.LinkURL + "&" + GlobalName.QueryStringName.Details + "=" + QueryStringDetailsValueTrue;
        }

        protected bool IsDisplayDetailedView()
        {
            var detailValue = Request.QueryString[GlobalName.QueryStringName.Details];
            
            return (detailValue != null && detailValue == QueryStringDetailsValueTrue);
        }

        //Note: Had to check document type because the PageTree control is also rendering the root node even if ShowRootPage="False"

        protected string GetLargeDocumentChapterNumber(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? "" : obj.ChapterNumber;
        }

        protected int GetLargeDocumentChapterLevel(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? 0 : obj.GetChapterLevel();
        }

        protected string GetLargeDocumentChapterPageNameWithoutChapterNumber(object page)
        {
            var obj = page as Model.LargeDocumentChapter;
            return obj == null ? "" : obj.PageNameWithoutChapterNumber;
        }
    }
}
