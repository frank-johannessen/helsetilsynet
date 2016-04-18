using System;
using System.Web;

namespace Helsetilsynet
{
    public partial class NotFound404 : BVNetwork.FileNotFound.NotFoundBase
    {
        private const string SearchUrl = "{0}&quicksearchquery={1}";
        protected System.Web.UI.WebControls.TextBox SearchText;

        /// <summary>
        /// Redirects to the search result page
        /// </summary>
        protected void Search_Click(object sender, EventArgs e)
        {
            string searchText = HttpUtility.UrlEncode(SearchText.Text.Trim());
            HttpContext.Current.Response.Redirect(string.Format(SearchUrl, "https://helsetilsynet.no/no/ts/sokeside/?", searchText));
        }
    }
}
