using System;
using EPiServer;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class GoogleAnalytics : UserControlBase
    {
        protected string GoogleAnalyticsAccount { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Visible = false;
            if (!(CurrentPage is Model.BasePage))
                return;

            GoogleAnalyticsAccount = (CurrentPage as Model.BasePage).GlobalSettings.GoogleAnalyticsAccount;
            if (string.IsNullOrEmpty(GoogleAnalyticsAccount))
                return;

            Visible = true;
        }
    }
}