using System;
using EPiServer;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Dummy
{
    public partial class FeaturedArticlesFrontpage : UserControlBase<BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var article = DataFactory.Instance.GetPage(new PageReference(56)) as Model.Article;
            teaser.Article = article;
        }
    }
}