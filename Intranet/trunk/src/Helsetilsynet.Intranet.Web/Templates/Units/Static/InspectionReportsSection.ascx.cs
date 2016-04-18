using System;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class InspectionReportsSection : UserControlBase<Model.Search>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lnkTilsynsrapporter.NavigateUrl = CurrentPage.Tilsynsrapporter;
            lnkTilsynsrapporter.Text = string.IsNullOrEmpty(CurrentPage.TilsynsrapporterLenketekst)
                                           ? CurrentPage.Tilsynsrapporter
                                           : CurrentPage.TilsynsrapporterLenketekst;
            lnkTilsynsrapporter.DataBind();

            lnkTilsynssaker.NavigateUrl = CurrentPage.Tilsynssaker;
            lnkTilsynssaker.Text = string.IsNullOrEmpty(CurrentPage.TilsynssakerLenketekst)
                                           ? CurrentPage.Tilsynssaker
                                           : CurrentPage.TilsynssakerLenketekst;
            lnkTilsynssaker.DataBind();
        }
    }
}