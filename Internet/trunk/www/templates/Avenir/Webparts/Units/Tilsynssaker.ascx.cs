using System;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer;
using EPiServer.Core;

namespace Avenir.Templates.Webparts.Units
{
    public partial class Tilsynssaker : EPiCode.WebParts.UserControlWebPartBase
    {
        private PropertyPageReference _listingContainer = new PropertyPageReference();
        private PropertyNumber _antSaker = new PropertyNumber();
        private PropertyNumber _antTimer = new PropertyNumber();
        private PropertyString _listTitle = new PropertyString();
        private PropertyPageReference _alleSaker = new PropertyPageReference();

        public Tilsynssaker()
        {
            // The properties needs a name, or they won't save
            _listingContainer.Name = "ListingContainerProperty";
            _antSaker.Name = "Antsaker";
            _antSaker.Number = 4;
            _antTimer.Name = "antTimer";
            _antTimer.Number = 1440;
            _alleSaker.Name = "alleSaker";
            //_mainBody.EditorToolOptions = EPiServer.Editor.EditorToolOption.All;
        }

        [Obsolete]
        public override string Title
        {
            get
            {
                return "Tilsynssaker"; 
            }
            set
            {
                
            }
        }


        //[Personalizable]
        //[WebDisplayName("Rootside som det skal søkes fra ")]
        //public PropertyPageReference ListingContainer
        //{
        //    get { return _listingContainer; }
        //    set
        //    {
        //        _listingContainer = value;
        //        //SetDirty();
        //    }
        //}
        



        [Personalizable]
        [WebDisplayName("Ant. saker i listen ")]
        public  PropertyNumber AntSaker
        {
            get
            {
                return _antSaker;
            }
            set
            {
                _antSaker = value;
                SetDirty();
            }
        }

        //[Personalizable]
        //[WebDisplayName("Max ant. timer fra publisering ")]
        //public PropertyNumber AntTimer
        //{
        //    get
        //    {
        //        return _antTimer;
        //    }
        //    set
        //    {
        //        _antTimer = value;
        //        //SetDirty();
        //    }
        //}


        /// <summary>
        /// Gets or sets the page link to a PageData.
        /// </summary>
        /// <value>The page link</value>
        [Personalizable]
        //[PropertyDataLanguageAttribute(
        //    "/webparts/parts/pagesummarywebpart/articlepagelinklabel",
        //    "/webparts/parts/pagesummarywebpart/articlepagelinkdesc")]
        [WebDisplayName("Link til alle tilsynssaker")]
        public PropertyPageReference AlleSaker
        {
            get { return _alleSaker; }
            set
            {
                _alleSaker = value;
                //SetDirty();
            }
        }


        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //ChangedPages.RootPage = ListingContainer.PageLink;
            //ChangedPages.ChangedHours = getHours();
            ChangedPages.MaxNumber = getCases();
            ChangedPages.DocType = "Vedtak tilsynssak";
        }

        //protected override void OnPreRender(EventArgs e)
        //{
        //    base.OnPreRender(e);            
        //}

        protected string getLink()
        {
            if (PageReference.IsNullOrEmpty(AlleSaker.PageLink))
                return "#";
            return GetPage(AlleSaker.PageLink).LinkURL;
        }

        //protected int getHours()
        //{
        //    int i = AntTimer.Number;
        //    return i; 
        //}

        protected int getCases()
        {
            int i = AntSaker.Number;
            return i;
        }

    }
}