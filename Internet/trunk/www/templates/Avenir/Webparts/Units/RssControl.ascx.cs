using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EPiServer.Core;
using EPiCode.WebParts;

namespace Avenir.Templates.Webparts.Units
{
    public partial class RssControl : EPiCode.WebParts.UserControlWebPartBase
    {
        //private string _catalogIconImageUrl;
        //private string _description;
        //private string _subtitle;
        private PropertyString _title = new PropertyString();
        private PropertyNumber _itemCount = new PropertyNumber();
        private PropertyString _rssUrl = new PropertyString();
        //private string _titlIconImageUrl;
        //private string _titleUrl;

        [Obsolete]
        public override string Title
        {
            get
            {
                return "Rss List";
            }
            set
            {

            }
        }

        [Personalizable]
        [WebBrowsable]
        [PropertyDataLanguageAttribute(
           "/webparts/parts/rsslist/title",
           "/webparts/parts/rsslist/description")]
        public PropertyString ListTitle
        {
            get
            {
                // if no value is present return the title of the feed.
                if (string.IsNullOrEmpty(_title.ToString()))
                    _title.Value = "RSS Feed";
                return _title;
            }
            set
            {
                // reset the value if empty string is passed
                _title = value;
                SetDirty();
            }
        }

        [Personalizable]
        [WebBrowsable]
        [PropertyDataLanguageAttribute(
           "/webparts/parts/rsslist/uri",
          "/webparts/parts/rsslist/uridesc")]
        public PropertyString RssUrl
        {
            get
            {
                return _rssUrl;
            }
            set
            {
                _rssUrl = value;
                if (_rssUrl.Value != null)
                {
                    Uri rssUri = new Uri(_rssUrl.Value as string);
                    Src = rssUri;
                }
                SetDirty();
            }
        }
        
        public Uri Src
        {
            get { return RssControl1.Src; }
            set 
            {
                // this setter will be called by ApplyChanges of the PropertyGridEditorPart which will swallow any exception.
                // In order to prevent invalid uris to be passed down to the underlying RssControl we need to check for exceptions ourselves.
                string x = null;
                try
                {
                    x = value.AbsoluteUri;
                }
                catch (InvalidOperationException e)
                {
                    RssControl1.Src = null;
                    throw new EPiServer.Core.EPiServerException("Url cannot be empty.", "/templates/webparts/units/rsscontrol/emptyurl", e);
                }

                RssControl1.Src = value; 
            }
        }

        [Personalizable]
        [WebBrowsable]
        [PropertyDataLanguageAttribute(
          "/webparts/parts/rsslist/maxcount",
          "/webparts/parts/rsslist/maxcount")]
        public PropertyNumber ItemCount
        {
            get 
            {
                return _itemCount; 
            }
            set 
            {
                _itemCount = value;
                if(_itemCount.Value != null)
                    RssControl1.ItemCount = (int)_itemCount.Value;
                SetDirty();
            }
        }

    }
}