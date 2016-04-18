using System;
using EPiServer.Core;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MegaMenuSubTree : UserControlBase<Model.BasePage>
    {
        public PageReference PageLink { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}