﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class SystemMessage : RelateTemplatePage<Model.SystemMessagePage>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }
    }
}