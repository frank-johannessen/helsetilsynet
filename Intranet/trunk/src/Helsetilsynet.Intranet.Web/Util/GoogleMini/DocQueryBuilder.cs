using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Util.GoogleMini;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini
{
    
    internal class DocQueryBuilder
    {
        public static DocQuery Build(string docQueryString)
        {
            if (String.IsNullOrEmpty(docQueryString))
                return null;
            
            string[] criteria = docQueryString.Split(';');
            
            var docQuery = new DocQuery();
            docQuery.Collection = SearchCollections.CombinedCollection;

            foreach (string s in criteria)
            {
                try
                {
                    string[] group = s.Split(':');

                    if (@group[0] == "c")
                    {
                        docQuery.Collection = @group[1];
                    }
                    else if (@group[0] == "q")
                    {
                        docQuery.Query = @group[1];
                    }
                    else if (@group[0] == "m")
                    {
                        docQuery.MaxReturn = Int32.Parse(@group[1]);
                    }
                    else if (@group[0] == "p")
                    {
                        docQuery.Population = new string[0];
                        docQuery.Population[0] = @group[1];
                    }
                    else
                    {
                        if (@group[0] != "e") // engine
                        {
                            string value = @group[1];
                            
                            var searchItemList = new List<string>();

                            if (value.Contains('#'))
                            {
                                string[] aListe = value.Split('#');
                                searchItemList.AddRange(aListe);
                            }
                            else
                                searchItemList.Add(value);

                            docQuery.AddSearchItem(new SearchItem(@group[0], searchItemList));
                        }
                    }
                }
                catch 
                {
                    return docQuery;
                }
            }
            docQuery.SortbyDate = true;
            
            return docQuery;
        }
    }
}