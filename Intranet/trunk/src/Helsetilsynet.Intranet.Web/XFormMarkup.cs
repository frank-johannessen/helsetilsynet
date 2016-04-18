using System.Web.UI;
using EPiServer;
using EPiServer.XForms.WebControls;

namespace MakingWaves.Helsetilsynet.Intranet.Web
{
    public static class XFormMarkup
    {
        /// <summary>
        /// Renders all XForms as fieldset/div instead of table
        /// </summary>
        /// <param name="formControl"></param>
        public static void CleanupXFormHtmlMarkup(XFormControl formControl)
        {
            if (formControl.EditMode)
            {
                // We need to render the default table when in edit mode, otherwise the form wizard won't work
                return;
            }

            if (formControl.Page as TemplatePage == null)
                return;

            var currentPage = ((TemplatePage)formControl.Page).CurrentPage;
            if (!(currentPage is Model.BasePage))
                return;

            bool firstLiteralControl = false;
            LiteralControl literalControl = null;

            ControlCollection controls = formControl.Controls;

            foreach (object control in controls)
            {
                if (control is LiteralControl)
                {
                    literalControl = control as LiteralControl;

                    // find the first literal control
                    if (!firstLiteralControl)
                    {
                        literalControl.Text = "<fieldset><div class='formRow'>";
                        firstLiteralControl = true;
                    }
                    else
                    {
                        literalControl.Text = "</div><div class='formRow'>";
                    }
                }
            }

            // update markup for the last literal control
            if (literalControl != null)
            {
                literalControl.Text = "</div></fieldset>";
            }
        }

    }
}