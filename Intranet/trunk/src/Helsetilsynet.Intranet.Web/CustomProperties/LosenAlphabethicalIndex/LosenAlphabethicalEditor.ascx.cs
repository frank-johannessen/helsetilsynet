using System;
using System.Configuration;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex
{
    public partial class LosenAlphabethicalEditor : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnConformDeleteAll.Visible = false;


            plhDeleteAll.Visible = GetDisplayDeleteAll();
        }

        private bool GetDisplayDeleteAll()
        {
            bool displayDeleteAll;
            var displayDeleteAllSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.DisplayLosenAlphabethicalIndexDeleteAllButton];
            bool.TryParse(displayDeleteAllSetting, out displayDeleteAll);
            
            return displayDeleteAll;
        }

        protected void AddNewLosenAlphabethicalItem(object sender, EventArgs e)
        {
            LosenAlphabethicalUtils.InsertLosenAlphabethicalItem(txtNewLosenAlphabethicalItemTitle.Text, txtNewLosenAlphabethicalItemUrl.Text);
            GridView1.DataBind();
            txtNewLosenAlphabethicalItemTitle.Text = string.Empty;
            txtNewLosenAlphabethicalItemUrl.Text = string.Empty;
        }

        protected void DeleteAll(object sender, EventArgs e)
        {
            btnConformDeleteAll.Visible = true;
        }

        protected void ConfirmDeleteAll(object sender, EventArgs e)
        {
            LosenAlphabethicalUtils.DeleteStore();
            GridView1.DataBind();
            btnConformDeleteAll.Visible = false;
        }
    }
}