using System;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer.Core;
//using Avenir.Utilities;
using EPiServer.SpecializedProperties;

namespace Avenir.Templates.Webparts.Units
{
    /// <summary>
    /// PageList with preview text webpart
    /// 
    /// </summary>
    public partial class BannerWP : EPiCode.WebParts.UserControlWebPartBase
    {
        private static readonly log4net.ILog _log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Private Property Declarations
        // Example data
        private PropertyDate _myDate = new PropertyDate(DateTime.Now);
        // Holds url to image
        private PropertyImageUrl _imageUrl = new PropertyImageUrl();
        // Holds link when clicking on the image
        private PropertyUrl _imageClickUrl = new PropertyUrl();
        private PropertyString _imageAltText = new PropertyString();
        private PropertyBoolean _RightColumn = new PropertyBoolean();

        //private PropertyLongString _mainBody = new PropertyLongString();

        #endregion

        public BannerWP()
        {
            this.Title = WebPartUtil.Translate("/webparts/parts/bdoimagebanner/title");
            this.Description = WebPartUtil.Translate("/webparts/parts/bdoimagebanner/description");

            //_mainBody.EditorSettings = EPiServer.SystemControls.EditorOption.All;
            _imageUrl.Name = "ImageUrl";
            _imageClickUrl.Name = "ImageClickUrl";
            _imageAltText.Name = "ImageAltText";
        }

        public override string Title
        {
            get
            {
                return "Image/Banner"; ;
            }
            set
            {

            }
        }


        [Personalizable()]
        [PropertyDataLanguageAttribute(
            "/webparts/parts/imagebanner/imageurllabel",
          "/webparts/parts/imagebanner/imageurldesc")]
        public PropertyImageUrl ImageUrl
        {
            get
            {
                return _imageUrl;
            }
            set
            {
                _imageUrl = value;
                SetDirty();
            }
        }

        [Personalizable()]
        [PropertyDataLanguageAttribute(
            "/webparts/parts/imagebanner/imageclickurllabel",
          "/webparts/parts/imagebanner/imageclickurldesc")]
        public PropertyUrl ImageClickUrl
        {
            get
            {
                return _imageClickUrl;
            }
            set
            {
                _imageClickUrl = value;
                SetDirty();
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
                SetDirty();
            }
        }

        /// <summary>
        /// Gets or sets the ShowDate.
        /// </summary>
        /// <value>The page link</value>
        [Personalizable]
        [PropertyDataLanguageAttribute(
            "/webparts/parts/imagebanner/RightColumn",
            "/webparts/parts/imagebanner/RightColumn")]
        public PropertyBoolean RightColumn
        {
            get { return _RightColumn; }
            set
            {
                _RightColumn = value;
                //SetDirty();
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            
        }

        protected string getAltText()
        {
            if (ImageAltText != null && ImageAltText.Value != null)
                return ImageAltText.Value.ToString();
            return string.Empty;
        }
        protected string getImgUrl()
        {
            if (_imageUrl != null && _imageUrl.Value != null)
                return _imageUrl.Value.ToString();
            return string.Empty;
        }
        protected string getLink()
        {
            if (_imageClickUrl != null && _imageClickUrl.Value != null)
                return _imageClickUrl.Value.ToString();
            return "#";
        }

        protected string getWidth()
        {
            int width = 229;
            //try
            //{
            //    if (Library.isStartPage(CurrentPage))
            //    {
            //        if (_RightColumn != null &&  RightColumn.Boolean)
            //            width = 290;
            //        else
            //            width = 229;
            //    }
            //}
            //catch (Exception)
            //{
            //}
            return width.ToString();
        }

    }
}
