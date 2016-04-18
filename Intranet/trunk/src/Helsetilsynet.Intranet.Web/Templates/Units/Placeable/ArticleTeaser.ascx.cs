using System;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ArticleTeaser : UserControlBase<Model.BasePage>
    {
        public Model.Article Article { protected get; set; }

        public int ShortTextLength { private get; set; }

        public int LongTextLength { private get; set; }

        protected CroppedText CroppedTextFirst { get; private set; }

        protected CroppedText CroppedTextSecond { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Article == null)
            {
                Visible = false;
                return;
            }

            tags.Article = Article;
            tags.DataBind();

            if (Article.MainImage != null)
            {
                imgMainImage.ImageUrl = Article.MainImage.ImageUrl;
                imgMainImage.DataBind();
            }

            SetCroppedTexts(Article.MainIntro, Article.MainBody, ShortTextLength, LongTextLength);
        }

        private void SetCroppedTexts(string mainIntro, string mainBody, int shortCount, int longCount)
        {
            bool fullTextWasCropped;
            var fullText = (string.IsNullOrEmpty(mainIntro) ? mainBody : mainIntro)
                .CropText(longCount, out fullTextWasCropped);

            if (fullText.Length <= shortCount)
            {
                CroppedTextFirst = new CroppedText(fullText, fullTextWasCropped);
                CroppedTextSecond = new CroppedText(string.Empty, false);
            }
            else
            {
                var tempShortText = fullText.Substring(0, shortCount);
                var lastSpace = tempShortText.LastIndexOf(' ');
                var splitPos = lastSpace > 0 ? lastSpace : shortCount;

                CroppedTextFirst = new CroppedText(fullText.Substring(0, splitPos), fullText.Length > shortCount);
                CroppedTextSecond = new CroppedText(fullText.Substring(splitPos), fullTextWasCropped);
            }
        }
    }

    public class CroppedText
    {
        private string Text { get; set; }

        private bool IsCropped { get; set; }

        public CroppedText(string text, bool isCropped)
        {
            Text = text;
            IsCropped = isCropped;
        }

        public override string ToString()
        {
            return string.IsNullOrEmpty(Text)
                       ? string.Empty
                       : string.Format("<span{0}>{1}</span>", IsCropped ? " class=\"shortened\"" : string.Empty, Text);
        }
    }
}