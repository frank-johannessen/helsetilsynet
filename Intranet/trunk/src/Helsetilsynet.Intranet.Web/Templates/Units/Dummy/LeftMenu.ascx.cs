using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Dummy
{
    public partial class LeftMenu : System.Web.UI.UserControl
    {
        public string XEllerHvaSomHelst { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string GetCssClassName(string x)
        {
            return "xxx-vvv-uff" + x + XEllerHvaSomHelst;
        }
    }
}