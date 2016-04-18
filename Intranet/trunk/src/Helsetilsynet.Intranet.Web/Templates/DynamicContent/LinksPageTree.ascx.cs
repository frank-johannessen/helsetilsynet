using System;
using EPiServer.Core;
using EPiServer.DynamicContent;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{

    [DynamicContentPlugIn(DisplayName = "LinksPageTree",
        ViewUrl = "~/Templates/DynamicContent/LinksPageTree.ascx")]
    public partial class LinksPageTree : UserControlBase<BasePage>
    {
        public PropertyPageReference PageReference { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            plPages.PageLink = PageReference != null ? PageReference.PageLink : CurrentPage.PageLink;
            plPages.DataBind();
        }
    }
}