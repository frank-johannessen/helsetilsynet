using System;

namespace Helsetilsynet.CustomProperties.htilDictionaryProperty
{
    public partial class AlphabethicalEditor : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnConformDeleteAll.Visible = false;
            plhDeleteAll.Visible = GetDisplayDeleteAll();
        }

        private bool GetDisplayDeleteAll()
        {
            return true;
            //return false if we do not want to show the delete butto
            //bool displayDeleteAll;
            //var displayDeleteAllSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.DisplayLosenAlphabethicalIndexDeleteAllButton];
            //bool.TryParse(displayDeleteAllSetting, out displayDeleteAll);

            //return displayDeleteAll;
        }

        protected void AddNewAlphabethicalItem(object sender, EventArgs e)
        {
            AlphabethicalUtils.InsertAlphabethicalItem(txtNewAlphabethicalItemTitle.Text, txtNewAlphabethicalItemUrl.Text, txtNewAlphabethicalItemIngress.Text);
            GridView1.DataBind();
            txtNewAlphabethicalItemTitle.Text = string.Empty;
            txtNewAlphabethicalItemUrl.Text = string.Empty;
            txtNewAlphabethicalItemIngress.Text = string.Empty;
        }

        protected void DeleteAll(object sender, EventArgs e)
        {
            btnConformDeleteAll.Visible = true;
        }

        protected void ConfirmDeleteAll(object sender, EventArgs e)
        {
            AlphabethicalUtils.DeleteStore();
            GridView1.DataBind();
            btnConformDeleteAll.Visible = false;
        }
    }
}