using System;
using System.Web;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class Search : RelateTemplatePage<Model.Search>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            SetPagerIfNewSearch();
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "search-result filtered";

            htSearchResult.SearchFilterInstance = htSearchFilter;
            if(!IsPostBack)
            {
                if (Request.QueryString[GlobalName.QueryStringName.Q] != null && !string.IsNullOrWhiteSpace(Request.QueryString[GlobalName.QueryStringName.Q]))
                {
                    htSearchResult.PreDefinedFreetextSearch = HttpUtility.UrlDecode(Request.QueryString[GlobalName.QueryStringName.Q]);
                    htSearchFilter.PreDefinedFreetextSearch = HttpUtility.UrlDecode(Request.QueryString[GlobalName.QueryStringName.Q]);
                }    
            }
        }

        private void SetPagerIfNewSearch()
        {
            if (IsPostBack)
            {
                string ctrlname = Request.Params.Get("__EVENTTARGET");
                if (string.IsNullOrWhiteSpace(ctrlname))
                {
                    SetPagerToPage(1);
                    return;
                }
                
                var ctrl = FindControl(ctrlname);
                if (ctrl != null)
                {
                    var pagerContrl = ctrl.NamingContainer.Parent.Parent as ResultPager;
                    if (pagerContrl == null)
                        SetPagerToPage(1);
                }
                else
                {
                    if (Request.QueryString[GlobalName.QueryStringName.Page] != null)
                        htSearchFilter.DoNotPopulate = true;
                }
            }
        }

        private void SetPagerToPage(int pageNumber)
        {
            var pager = htSearchResult.FindControl("pager") as ResultPager;
            if (pager != null)
            {
                pager.CurrentPagingNumber = pageNumber;
            }
        }
    }
}