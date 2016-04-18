using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class LosenAlphabethicalIndex : System.Web.UI.UserControl
    {
        private const string ALPHABETH = "ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ";

        protected void Page_Load(object sender, EventArgs e)
        {
            rptLosenIndex.DataSource = GetLosenIndex();
            rptLosenIndex.DataBind();
        }

        private List<LetterIndex> GetLosenIndex()
        {
            var alphabeth = ALPHABETH.ToList();
            var losenIndex = LosenAlphabethicalUtils.GlobalKeywordList().ToList();
            var keywords = losenIndex.Select(keyword => keyword.Title).ToList();
            var initialLetters = keywords.Select(k => k[0]).ToList();
            var initialSpecial = initialLetters.Where(letter => !alphabeth.Contains(CharToUpper(letter)));

            var index = new List<LetterIndex>();
            
            foreach (var letter in alphabeth)
            {
                var entries = losenIndex.Where(entry => StartsWithUpper(entry.Title, letter)).ToList();
                entries.Sort(new LosenAlphabeticalItemComparator());
                index.Add(new LetterIndex {Letter = letter, EntryCount = entries.Count, Items = entries});
            }

            var specialEntries = new List<LosenAlphabethicalItem>();
            
            foreach (var letter in initialSpecial)
            {
                var entries = losenIndex.Where(entry => StartsWithUpper(entry.Title, letter)).ToList();
                specialEntries.AddRange(entries);
            }

            if (specialEntries.Count > 0)
                index.Add(new LetterIndex { Letter = '?', EntryCount = specialEntries.Count, Items = specialEntries });

            return index;
        }

        private bool StartsWithUpper(string entry, char c)
        {
            return entry.ToUpper().StartsWith(CharToUpperString(c));
        }

        private string CharToUpperString(char c)
        {
            return CharToUpper(c).ToString(CultureInfo.InvariantCulture);
        }

        protected char CharToUpper(char c)
        {
            return c.ToString(CultureInfo.InvariantCulture).ToUpper()[0];
        }
    }

    public class LetterIndex
    {
        public char Letter { get; set; }

        public int EntryCount { get; set; }

        public List<LosenAlphabethicalItem> Items { get; set; }
    }

    public class LosenAlphabeticalItemComparator : IComparer<LosenAlphabethicalItem>
    {
        public int Compare(LosenAlphabethicalItem x, LosenAlphabethicalItem y)
        {
            return String.Compare(x.Title, y.Title, true, CultureInfo.CurrentCulture);
        }
    }
}