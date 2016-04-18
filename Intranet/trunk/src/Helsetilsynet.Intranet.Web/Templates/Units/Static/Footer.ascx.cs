using System;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class Footer : UserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var globalSettings = CurrentPage.GlobalSettings;

            rptLeftLinks.DataSource = globalSettings.FooterLeftLinkList;
            rptLeftLinks.DataBind(); 
            
            rptRightLinks.DataSource = globalSettings.FooterRightLinkList;
            rptRightLinks.DataBind();

            if (globalSettings.FooterRightImage == null) 
                return;

            footerRightImage.ImageUrl = globalSettings.FooterRightImage.ImageUrl;
            footerRightImage.LinkURL = globalSettings.FooterRightImageUrl;
            footerRightImage.DataBind();
        }
    }
}