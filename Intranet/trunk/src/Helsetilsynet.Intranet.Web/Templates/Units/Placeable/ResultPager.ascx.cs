using System;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using EPiServer;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ResultPager : UserControlBase<Model.BasePage>
    {
        protected int NumberOfPages { get; private set; }

        public int HitsPerPage { get; set; }

        private int? _currentPagingNumber;
        public int CurrentPagingNumber
        {
            get
            {
                if (_currentPagingNumber.HasValue)
                    return _currentPagingNumber.Value;
                int page;
                var pageParam = Request.QueryString[GlobalName.QueryStringName.Page];
                return int.TryParse(pageParam, out page) ? page : 1;
            }
            set
            {
                _currentPagingNumber = value;
            }
        }

        public int ScrollAhead
        {
            get
            {
                return (CurrentPagingNumber - 1) * HitsPerPage;
            }
        }
        
        public void BindPagerControl(int hitsPerPage, long hitcount)
        {
            HitsPerPage = hitsPerPage;
            NumberOfPages = GetNumberOfPages(hitsPerPage, hitcount);

            var start = CurrentPagingNumber > 5 ? CurrentPagingNumber - 5 : 1;
            var end = CurrentPagingNumber + 5 > NumberOfPages ? NumberOfPages : CurrentPagingNumber + 5;
            var count = end - start + 1;

            rptPager.DataSource = Enumerable.Range(start, count).ToList();
            rptPager.DataBind();
        }

        private int GetNumberOfPages(int hitsPerPage, long hitcount)
        {
            decimal pages = (decimal)hitcount / hitsPerPage;
            var retval = Math.Ceiling(pages);
            return (int)retval;
        }


        protected string GetPagingUrl(int pageNumber)
        {
            //return QueryString.AddQueryStrings(FriendlyURL.GetFriendlyURL(CurrentPage.LinkURL),
            //    string.Format("{0}={1}", GlobalName.QueryStringName.Page, pageNumber));

            var urlBuilder = new UrlBuilder(CurrentPage.LinkURL);
            var q = new NameValueCollection(Request.QueryString);
            q.Remove(GlobalName.QueryStringName.ID);
            q.Set(GlobalName.QueryStringName.Page, pageNumber.ToString());
            urlBuilder.MergeQueryCollection(q);
            EPiServer.Global.UrlRewriteProvider.ConvertToExternal(urlBuilder, CurrentPage, Encoding.UTF8);
            return urlBuilder.ToString();
        }
    }
}