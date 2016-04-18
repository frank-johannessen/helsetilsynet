using System;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer;
using EPiServer.Core;

namespace Avenir.Templates.Webparts.Units
{
    public partial class PageListWebPart : EPiCode.WebParts.UserControlWebPartBase
    {
        private PropertyPageReference _listingContainer = new PropertyPageReference();
        private PropertyLongString _mainBody = new PropertyLongString();
        private PropertyString _listTitle = new PropertyString();

        public PageListWebPart()
        {
            // The properties needs a name, or they won't save
            _listingContainer.Name = "ListingContainerProperty";
            _mainBody.Name = "MainBodyProperty";
            _mainBody.EditorToolOptions = EPiServer.Editor.EditorToolOption.All;
        }

        [Obsolete]
        public override string Title
        {
            get
            {
                return "Page List";
            }
            set
            {
                
            }
        }

        [Personalizable]
        [WebBrowsable]
        [WebDisplayName("List Title")]
        [PropertyDataLanguageAttribute(
           "/webparts/parts/pagesummarywebpart/listtitlelabel",
           "/webparts/parts/pagesummarywebpart/listtitledesc")]
        public PropertyString ListTitle
        {
            get
            {
                return _listTitle;
            }
            set
            {
                _listTitle = value;
                SetDirty();
            }
        }
        /// <summary>
        /// Gets or sets the page link to a PageData.
        /// </summary>
        /// <value>The page link</value>
        [Personalizable]
        [PropertyDataLanguageAttribute(
            "/webparts/parts/pagesummarywebpart/articlepagelinklabel",
            "/webparts/parts/pagesummarywebpart/articlepagelinkdesc")]
        public PropertyPageReference ListingContainer
        {
            get { return _listingContainer; }
            set
            {
                _listingContainer = value;
                //SetDirty();
            }
        }

       

        [Personalizable]
        public PropertyLongString MainBody
        {
            get
            {
                return _mainBody;
            }
            set
            {
                _mainBody = value;
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

            if (!PageReference.IsNullOrEmpty(_listingContainer.PageLink))
            {
                PageDataCollection pages = Global.EPDataFactory.GetChildren(_listingContainer.PageLink);
                lstPages.DataSource = pages;
                lstPages.DataBind();

                if (pages.Count > 0 && string.IsNullOrEmpty(_listTitle.ToString()) == false)
                {
                    lblListTitle.Text = _listTitle.ToString();
                }

            }
            
        }
    }
}