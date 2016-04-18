using System;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class MediaWatch : UserControlBase<Model.StartPage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentPage.MediaWatch == null || CurrentPage.MediaWatch.Count <= 0) 
                return;

            rptMediaWatch.DataSource = CurrentPage.MediaWatch;
            rptMediaWatch.DataBind();
        }
    }
}