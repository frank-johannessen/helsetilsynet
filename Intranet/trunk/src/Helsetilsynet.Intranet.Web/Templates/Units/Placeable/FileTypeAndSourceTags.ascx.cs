using System;
using MakingWaves.Helsetilsynet.Util.GoogleMini;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class FileTypeAndSourceTags : System.Web.UI.UserControl
    {
        public ResultElement ResultElement { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static bool DisplaySourceName(ResultElement dataItem)
        {
            return dataItem.Source != GlobalName.SiteSourceName.Losen;
        }

        public static string GetSourceName(ResultElement dataItem)
        {
            return dataItem.Source;
        }

        public static string GetFileExtension(ResultElement dataItem)
        {
            return dataItem.FileExtension;
        }

        public static bool DisplayFileExtension(ResultElement dataItem)
        {
            return dataItem.FileExtension != string.Empty;
        }
    }
}