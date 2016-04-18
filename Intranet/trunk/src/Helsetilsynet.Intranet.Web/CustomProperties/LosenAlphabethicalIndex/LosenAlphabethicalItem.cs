using System.Diagnostics;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex
{
    [DebuggerDisplay("LosenAlphabethicalItem: Id={Id}, Title={Word}, Url={Url}")]
    public class LosenAlphabethicalItem : IDynamicData
    {
        public Identity Id { get; set; }

        public string IdString
        {
            get
            {
                return Id.ToString();
            }
            set
            {
                Id = Identity.Parse(value);
            }
        }

        public string Title { get; set; }
        public string Url { get; set; }
    }
}