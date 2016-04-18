using System;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer.Core;
using EPiServer.SpecializedProperties;

namespace Avenir.Templates.Webparts.Units
{
    public partial class FlashWP : EPiCode.WebParts.UserControlWebPartBase
    {
        //private string _width;
        private string _height;

        #region Private Property Declarations

            private PropertyDocumentUrl _flashUrl = new PropertyDocumentUrl();
            //private PageData _page = null;
            private PropertyString _titleText = new PropertyString();
            private PropertyNumber _sizeHeight = new PropertyNumber();
            private PropertyNumber _sizeWidth = new PropertyNumber();
            private PropertyString _imageAltText = new PropertyString();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IWebPart Members
        [Obsolete]
        public override string Title
        {
            get
            {
                return "Flash Banner";
            }
            set
            {
            }
        }
        #endregion

        [Personalizable]
        [WebBrowsable]
        [WebDisplayName("FlashURL")]
        [PropertyDataLanguageAttribute(
           "/webparts/parts/Flash/FlashUrlLabel",
           "/webparts/parts/Flash/FlashUrlDesc")]
        public PropertyDocumentUrl FlashURL
        {
            get
            {
                return _flashUrl;
            }
            set
            {
                _flashUrl = value;
                //SetDirty();
            }
        }

        [Personalizable()]
        [PropertyDataLanguageAttribute(
          "/webparts/parts/flash/SizeWidthlabel",
        "/webparts/parts/flash/SizeWidthdesc")]
        public PropertyNumber SizeWidth
        {
            get
            {
                return _sizeWidth;
            }
            set
            {
                _sizeWidth = value;
                //SetDirty();
            }
        }

        [Personalizable()]
        [PropertyDataLanguageAttribute(
           "/webparts/parts/flash/SizeHeightlabel",
         "/webparts/parts/flash/SizeHeightdesc")]
        public PropertyNumber SizeHeight
        {
            get
            {
                return _sizeHeight;
            }
            set
            {
                _sizeHeight = value;
                //SetDirty();
            }
        }
        [Personalizable()]
        [PropertyDataLanguageAttribute(
                    "/webparts/parts/imagebanner/imagealttextlabel",
                    "/webparts/parts/imagebanner/imagealttextdesc")]
        public PropertyString ImageAltText
        {
            get
            {
                return _imageAltText;
            }
            set
            {
                _imageAltText = value;
                //SetDirty();
            }
        }
        protected string Height
        {
            get
            {
                if (String.IsNullOrEmpty(_height))
                {
                    if (SizeHeight.Number > 0)
                        _height = SizeHeight.Number.ToString();
                    else
                        _height = "229";
                }
                return _height;
            }
        }
        protected string Width
        {
            get
            {
                return "100%";
                //if (String.IsNullOrEmpty(_width))
                //{
                //    if (SizeWidth.Number > 0)
                //        _width = SizeWidth.Number.ToString();
                //    else
                //        _width = "229";
                //}
                //return _width;
            }
        }
        protected string AtlText
        {

            get
            {
                if (ImageAltText != null && ImageAltText.Value != null)
                    return ImageAltText.Value.ToString();
                return "FlashBanner";
            }
        }
    }
}