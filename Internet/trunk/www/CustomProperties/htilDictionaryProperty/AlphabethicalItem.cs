using System.Diagnostics;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace Helsetilsynet.CustomProperties.htilDictionaryProperty
{
    [DebuggerDisplay("AlphabethicalItem: Id={Id}, Title={Word}, Url={Url}")]
    public class AlphabethicalItem : IDynamicData
    {
        public Identity Id { get; set; }

        public string IdString
        {
            get { return Id.ToString(); }
            set { Id = Identity.Parse(value); }
        }

        public string Title { get; set; }
        public string Url { get; set; }
        public string Ingress { get; set; }
    }
}