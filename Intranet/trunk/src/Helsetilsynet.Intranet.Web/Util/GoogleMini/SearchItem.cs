using System.Collections.Generic;
using System.Linq;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini
{
    public struct SearchItem
    {
        private KeyValuePair<string, List<string>> _item;

        public string Key { get { return _item.Key; } }

        public IEnumerable<string> Value
        {
            get { return _item.Value; }
        }

        public SearchItem(string key, IEnumerable<string> value)
        {
            _item = new KeyValuePair<string, List<string>>(key, value.ToList());
        }
    }
}