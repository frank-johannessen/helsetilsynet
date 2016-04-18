using System;
using System.Collections.Generic;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class LosenAlphabethicalIndexItem : System.Web.UI.UserControl
    {
        public List<LosenAlphabethicalItem> Items { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Items.Count < 1)
                Visible = false;

            rptItems.DataSource = Items;
            rptItems.DataBind();
        }
    }
}