using System;
using EPiServer.DynamicContent;
using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{
    // Simple walk-through on DynamicContent:
    // http://blog.fredrikhaglund.se/blog/2011/06/28/dynamic-content-in-episerver-cms-6-r2/

    [DynamicContentPlugIn(DisplayName = "LinksInternal",
        ViewUrl = "~/Templates/DynamicContent/LinksInternal.ascx")]
    public partial class LinksInternal : UserControlBase<BasePage>
    {
// ReSharper disable MemberCanBePrivate.Global
        public PropertyLinkCollection Links { get; set; }
// ReSharper restore MemberCanBePrivate.Global
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Links != null)
            {
                rptLinks.DataSource = Links;
                rptLinks.DataBind();
            }
        }
    }
}