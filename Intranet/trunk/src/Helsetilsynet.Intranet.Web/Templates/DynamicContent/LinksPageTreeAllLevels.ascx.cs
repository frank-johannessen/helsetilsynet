using System;
using System.Linq;
using EPiServer;
using EPiServer.Core;
using EPiServer.DynamicContent;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{
    [DynamicContentPlugIn(DisplayName = "LinksPageTreeAllLevels",
        ViewUrl = "~/Templates/DynamicContent/LinksPageTreeAllLevels.ascx")]
    public partial class LinksPageTreeAllLevels : UserControlBase<BasePage>
    {
        public PropertyPageReference PageReference { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            var pages =  DataFactory.Instance.GetDescendents(PageReference != null ?  PageReference.PageLink : CurrentPage.PageLink);
            plPages.DataSource = pages.FilterForVisitor();
            plPages.DataBind();
        }
    }
}