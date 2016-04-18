using System;
using System.Collections.Generic;
using EPiServer;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class ArticleArchive : RelateTemplatePage<Model.ArticleArchive>
    {
        private int HitsPerPage
        {
            get
            {
                return CurrentPage.HitsPerPage.HasValue ? CurrentPage.HitsPerPage.Value : 10;
            }
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "article-archive filtered";

            var searchSelections = GetSearchSelections();
            var docQuery = searchSelections.BuildDocQuery();
            var result = Search(docQuery);

            Bind(result);
            pager.BindPagerControl(HitsPerPage, docQuery.Count);
        }

        private SearchSelections GetSearchSelections()
        {
            var searchSelections = htArticleArchiveSearchFilter.GetSearchSelections();

            searchSelections.MaxReturn = HitsPerPage;
            pager.HitsPerPage = HitsPerPage;
            searchSelections.ScrollAhead = pager.ScrollAhead;
            searchSelections.EPiParentPageId = CurrentPage.GlobalSettings.ArticleArchive.ID;
            
            return searchSelections;
        }

        private void Bind(List<ResultElement> result)
        {
            rptArticles.DataSource = result;
            rptArticles.DataBind();
        }

        private static List<ResultElement> Search(DocQuery docQuery)
        {
            docQuery.ExecuteQuery();
            return docQuery.Results;
        }

        protected string GetImageUrl(ResultElement resultElement)
        {
            if (!string.IsNullOrEmpty(resultElement.ImageUrl))
                return resultElement.ImageUrl;

            return UriSupport.Combine(GlobalName.PathToRelateImageFolder.PathToRelateImagesFolder, "/artikkel_standard_icon.jpg");
        }

        protected string GetImageUrlFromPage(ResultElement resultElement)
        {
            if (!string.IsNullOrEmpty(resultElement.Pageid))
            {
                var intPageRef = 0;
                if(int.TryParse(resultElement.Pageid, out intPageRef))
                {
                    var pageRef = new PageReference(intPageRef);
                    var page = GetPage(pageRef) as Model.Article;
                    if (page != null && page.MainImage != null)
                        return page.MainImage.ImageUrl;
                }
            }

            return UriSupport.Combine(GlobalName.PathToRelateImageFolder.PathToRelateImagesFolder, "/artikkel_standard_icon.jpg");
        }
    }
}