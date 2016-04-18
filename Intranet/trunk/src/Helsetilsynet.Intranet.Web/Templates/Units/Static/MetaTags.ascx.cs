using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Web;
using MakingWaves.EPiImage.Code;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions.ExtensionMethods;
using System.Text.RegularExpressions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class MetaTags : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected static string CreateMetaTagDateTime(string name, DateTime? value, string format)
        {
            return !value.HasValue 
                       ? string.Empty
                       : CreateMetaTag(name, value.Value.ToString(format));
            
        }

        protected string addEmulationTagOnProjectRoomForIE11()
        {
            if (this.CurrentPage is ClubPage && Regex.IsMatch(this.Request.UserAgent, @"Trident/7.*rv:11"))
            {
                return "<meta content=\"IE=EmulateIE10\" http-equiv=\"X-UA-Compatible\">";
            }
            return "";
        }

        protected static string CreateMetaTag(string name, object value)
        {
            return value == null || string.IsNullOrEmpty(value.ToString())
                       ? string.Empty
                       : string.Format("<meta name=\"{0}\" content=\"{1}\" />", name, value);
        }

        protected static string GetImageUrl(PageData page)
        {
            var article = page as Article;

            return article != null ? new EPiImageEngine().ResizeImage(60, 60, EPiImageEngine.Transformation.ScaleToFill, EPiImageEngine.Rotation.NoRotation, article.GetArticleIcon()) : null;
        }

        protected static string CreateMetaTag(string name, CategoryList value)
        {
            return value
                .Select(Category.Find)
                .Where(category => category != null)
                .Aggregate<Category, string>(null, (current, category) => current + string.Format("<meta name=\"{0}\" content=\"{1}\" />", name, category.Name));
        }

        protected string CreateMetaTagHeading(string name)
        {
            var baseEditorialPage = CurrentPage as Model.BaseEditorialPage;
            return baseEditorialPage == null 
                ? CreateMetaTag(name, CurrentPage.PageName)
                : CreateMetaTag(name, baseEditorialPage.Heading);
        }

        protected string CreateMetaTagFriendlyUrl(string name, PageData pageData)
        {
            return CreateMetaTag(name, ExtensionMethods.FriendlyURL.GetFriendlyURL(pageData, true));
        }

        protected int GetParentLinkID()
        {
            var currParent = GetPage(CurrentPage.ParentLink);

            while(currParent!=null)
            {
                if (!(currParent is IVirtualFolder))
                    return currParent.PageLink.ID;

                currParent = GetPage(currParent.ParentLink);
            }

            throw new Exception("Invalid page structure");
            
        }

        protected string CreateMetaTagForCategoryIds(string name, IEnumerable<int> category)
        {
            var ids = category.ToList();
            return CreateMetaTag(name, string.Join(",", ids));
        }

        protected string GetDescription()
        {
            var article = CurrentPage as Article;
            var section = CurrentPage as Section;
            if (article != null)
            {
                if(!string.IsNullOrWhiteSpace(article.Description))
                    return article.Description;
                if(!string.IsNullOrWhiteSpace(article.MainIntro))
                    return article.MainIntro;
                if(!string.IsNullOrWhiteSpace(article.MainBody))
                    return article.MainBody.CropText(200);
                
            }
            else if(section != null)
            {
                if(!string.IsNullOrWhiteSpace(section.Heading))
                    return section.Heading;
            }
            return CurrentPage.PageName;
        }
    }
}