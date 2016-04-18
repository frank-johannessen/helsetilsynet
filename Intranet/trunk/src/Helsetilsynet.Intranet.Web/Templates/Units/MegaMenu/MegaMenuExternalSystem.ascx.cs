using System;
using MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu
{
    public partial class MegaMenuExternalSystem : System.Web.UI.UserControl
    {
        protected ExternalSystemConfigElement ExternalSystemConfigElement
        {
            get
            {
                if (string.IsNullOrEmpty(ExternalSystem))
                    return null;

                int system;
                return int.TryParse(ExternalSystem, out system)
                           ? ExternalSystemsConfig.GetExternalSystem(system)
                           : null;
            }
        }

        public string ExternalSystem { set; private get; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Visible = ExternalSystem != null;
            if (string.IsNullOrEmpty(ExternalSystem))
                return;

            if (ExternalSystemConfigElement == null || string.IsNullOrEmpty(ExternalSystemConfigElement.Logo))
                return;

            img.ImageUrl = ExternalSystemConfigElement.Logo;
            img.AlternateText = ExternalSystemConfigElement.Name;
            img.DataBind();
        }
    }
}