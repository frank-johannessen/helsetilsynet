using System;
using EPiServer.DynamicContent;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{
    // Simple walk-through on DynamicContent:
    // http://blog.fredrikhaglund.se/blog/2011/06/28/dynamic-content-in-episerver-cms-6-r2/

    [DynamicContentPlugIn(DisplayName = "LinksGoogle",
        ViewUrl = "~/Templates/DynamicContent/LinksGoogle.ascx")]
    public partial class LinksGoogle : UserControlBase<BasePage>
    {
        public string DocQuery { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var resultElements = Helsetilsynet.Util.GoogleMini.DocQuery.Search(DocQuery);

            rptSearchResult.DataSource = resultElements;
            rptSearchResult.DataBind(); ;
        }
    }
}