using System;
using System.Linq;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using MakingWaves.Helsetilsynet.Intranet.Web.Util;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class Article : RelateTemplatePage<Model.Article>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            var sectionCategory = BaseEditorialPage.GetMainCategoryClass(CurrentPage.PageLink);
            CurrentPage.LayoutClassName = "article " + sectionCategory;

            SetAttachmentLink();
            //SetMainImage();
            ucComments.Visible = CurrentPage.IsCommentable;
            responsibleAuthor.DataBind();
        }

        //private void SetMainImage()
        //{
        //    if (CurrentPage.MainImage == null)
        //        return;

        //    imgMainImage.ImageUrl = CurrentPage.MainImage.ImageUrl;
        //    imgMainImage.DataBind();
        //}

        private void SetAttachmentLink()
        {
            var visible = !string.IsNullOrEmpty(CurrentPage.AttachedDocument);
            lnkAttachment.Visible = visible;
            if (!visible)
                return;

            lnkAttachment.NavigateUrl = CurrentPage.AttachedDocument;
            lnkAttachment.DataBind();
        }

        public string GetCategoryInfo()
        {
            var retval = string.Empty;

            foreach (var x in CurrentPage.Category.GetList())
            {
                retval += string.Format("<p>{0} : {1} - {2}</p>", x.ID, x.Name, x.Description);
            }

            return retval;
        }

        public string AllCategories()
        {
            var retval = string.Empty;

            foreach (Category x in Category.GetRoot().Categories)
            {
                retval += string.Format("<p>{0} : {1} - {2}</p>", x.ID, x.Name, x.Description);
            }

            return retval;
        }

        protected string GetFullListOfDocumentTypes()
        {
            var values = from setting in CheckBoxLists.GetCheckBoxListSettings(CurrentPage, "DocumentType")
                         select setting.Value;

            return string.Join(",", values);
        }

        protected string GetToBeRevised()
        {
            if (!CurrentPage.ToBeRevised.HasValue)
                return "[NULL]";

            return CurrentPage.ToBeRevised.FormatToShortDateString();
        }
    }
}
