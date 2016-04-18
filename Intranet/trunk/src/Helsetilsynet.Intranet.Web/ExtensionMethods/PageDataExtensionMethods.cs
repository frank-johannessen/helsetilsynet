using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class PageDataExtensionMethods
    {
        public static PageData SafeGetPageData(this PageReference pageReference)
        {
            try
            {
                return DataFactory.Instance.GetPage(pageReference);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static bool IsSectionPage(this PageData currentPage)
        {
            return currentPage as Section != null;
        }

        public static string PageNameWithMaxLength(this PageData page, int maxLength)
        {
            var pageName = page.PageName;

            if (pageName.Length > maxLength)
                return pageName.Substring(0, maxLength) + "...";

            return pageName;

        }
        
        /// <summary>
        /// Root node is level=1
        /// </summary>
        /// <param name="page"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        public static PageData GetAncestorAtLevel(this PageData page, int level)
        {
            var ancestorList = DataFactory.Instance.GetParents(page.ParentLink);
            
            if (level > ancestorList.Count)
                throw new Exception("Invalid level " + level);

            ancestorList.Reverse();

            PageReference pageAtLevel = ancestorList[level - 1];

            return DataFactory.Instance.GetPage(pageAtLevel);
        }

        public static string GetArticleIcon(this Article article)
        {
            if (article.MainImage != null && !string.IsNullOrWhiteSpace(article.MainImage.ImageUrl))
            {
                var imageUrl = new UrlBuilder(article.MainImage.ImageUrl);
                PermanentLinkMapStore.ToMapped(imageUrl);
                return imageUrl.Uri.ToString();
            }
            return UriSupport.Combine(GlobalName.PathToRelateImageFolder.PathToRelateImagesFolder, "/artikkel_standard_icon.jpg");
        }

    }
}