using System;
using EPiServer;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ArticleArciveButton : UserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string GetArchiveUrl()
        {
            return DataFactory.Instance.GetPage(CurrentPage.GlobalSettings.ArticleArchive).LinkURL;
        }

        protected string GetArchiveTitle()
        {
            return DataFactory.Instance.GetPage(CurrentPage.GlobalSettings.ArticleArchive).PageName;
        }
    }
}