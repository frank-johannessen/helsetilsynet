using System;
using EPiServer;
using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Units.Placeable
{
    public partial class LimitTextAndLinkForSearch : UserControlBase
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
        }
        protected string GetToolTipData()
        {
            if (CurrentPage.Property["LimitTextToolTip"] == null)
                return string.Empty;
            return string.IsNullOrEmpty(CurrentPage.Property["LimitTextToolTip"].Value.ToString())
                       ? ""
                       : CurrentPage.Property["LimitTextToolTip"].Value.ToString();
        }
    }
}