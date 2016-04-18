/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using EPiServer.Core;
using EPiServer;


namespace Avenir.Templates.Units.Placeable
{
    public partial class KeywordList : UserControlBase
    {
        private string _emne = ""; // emne and eg are returned i query string
        private string _eg = "";
        private string _menygren = "";


        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            //string gren = Request.QueryString["Menygren"];
            if (CurrentPage.Property["Menygren"] != null && CurrentPage.Property["Menygren"].ToString() != string.Empty)
                _menygren = "&Branch=" + CurrentPage.Property["Menygren"];
        }


        protected string GetKeywordList()
        {
            if (CurrentPage["KeyWordList"] == null || CurrentPage["KeyWordList"].ToString() == "")
            {
                KeyBox.Visible = false;
                return "";
            }


            string totList = ((PageBase)Page).CurrentPage["KeyWordList"].ToString();
            totList = totList.Replace("<p>", "");
            totList = totList.Replace("</p>", "");
            string[] ht = GetKeyGroupe("##ht", ref totList);
            string[] st = GetKeyGroupe("##st", ref totList);
            string[] bt = GetKeyGroupe("##bt", ref totList);
            string[] ae = GetKeyGroupe("##ae", ref totList);
            _emne = Request.QueryString["emne"];
            string show = Request.QueryString["show"];
            bool showEachMore = !(!String.IsNullOrEmpty(_emne) && String.IsNullOrEmpty(show));
            if (!String.IsNullOrEmpty(_emne)) //bare én skal vises hvis emne i querystring...
            {
                 //...unntatt hvis vi har med show i strengen.
                if (String.IsNullOrEmpty(show))
                {
                    ht = CheckKeys(ref ht, _emne, "ht");
                    st = CheckKeys(ref st, _emne, "st");
                    bt = CheckKeys(ref bt, _emne, "bt");
                    ae = CheckKeys(ref ae, _emne, "ae");
                }
            }

            PageData temp = Lib.CurrentPage;
            Lib.CurrentPage = CurrentPage;
            string html = string.Empty;
            if (_eg == "" || _eg == "ae") html = "<div class='subBox'><h3>" + Lib.KeyGroup("ae") + "</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref ae, "ae") + "</ul>"
                + ((showEachMore) ? "<p class=\"readMore\"><a href=\"#\">" + CurrentPage.Property["ShowAllHsTxt"] + "</a></p></div>" : "");
            if (_eg == "" || _eg == "bt") html += "<div class='subBox'><h3>" + Lib.KeyGroup("bt") + "</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref bt, "bt") + "</ul>"
                 + ((showEachMore) ? "<p class=\"readMore\"><a href=\"#\">" + CurrentPage.Property["ShowAllSsTxt"] + "</a></p></div>" : "");
            if (_eg == "" || _eg == "ht") html += "<div class='subBox'><h3>" + Lib.KeyGroup("ht") + "</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref ht, "ht") + "</ul>"
                 + ((showEachMore) ? "<p class=\"readMore\"><a href=\"#\">" + CurrentPage.Property["ShowAllCsTxt"] + "</a></p></div>" : "");
            if (_eg == "" || _eg == "st") html += "<div class='subBox'><h3>" + Lib.KeyGroup("st") + "</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref st, "st") + "</ul>"
                 + ((showEachMore) ? "<p class=\"readMore\"><a href=\"#\">" + CurrentPage.Property["ShowAllOtherTxt"] + "</a></p></div>" : "");
            Lib.CurrentPage = temp;
            if (!String.IsNullOrEmpty(_emne) && String.IsNullOrEmpty(show))
            {
                string url = Request.RawUrl + "&show=all";
                html += "<p class=\"readxMore\"><a href=\"" + url + "\">" + CurrentPage.Property["ShowAllTxtKeys"] + " </a></p></div>";
            }
            return html;
        }

        private string GetKeyHtml(ref string[] list, string group)
        { 
            int i = 0;
            string s = string.Empty;
            string keyName;
            int p;
            PageReference pr = new PageReference(CurrentPage.Property["KeyWordPage"].ToString());
            PageData pd = DataFactory.Instance.GetPage(pr);
            string emneordside = pd.LinkURL;            
            foreach (string keyword in list)
                {
                    i++;
                    //if (i == 6) break;
                    keyName = keyword;// vi må fjerne evt. angivelse av gruppenr
                    if (string.IsNullOrEmpty(keyName))
                        continue;
                    p = keyName.IndexOf('0');
                    if (p > 0)
                        keyName = keyName.Substring(0, p);
                    s += "<li><a href=\"" + emneordside + "&emne=" + Code(keyword) + "&eg=" + group + _menygren + "\">" + Value(keyName) + "</a></li>";
                }
            return s;
        }

        private string[] GetKeyGroupe(string groupe, ref string list)
        {
            string[] result = {""};
            string s;
            int p = list.IndexOf(groupe);
            if (p >= 0 && list.Length > p+5)
            {
                int p2 = list.IndexOf("#", p+5 );
                if (p2 == -1) //Siste del av hele listen
                    s = list.Substring(p+5);
                else
                    s = list.Substring(p+5 , p2 - p -5);
                result = s.Split(',');
            }
            return result;
        }

        //Tester om en liste inneholder valgt emne
        private string[] CheckKeys(ref string[] list, string key, string group)
        {
            string[] result = {};
            bool test = false;
            string verdi = string.Empty;
            foreach (string s in list)
                if (Code(s) == key)
                {
                    verdi = Value(s);
                    test = true;
                    _eg = group;
                    break;
                }
            if (test) { result = new string[1]; result[0] = verdi; }  //result[0] = key; }
            return result;
        }

        // returner verdi-elementet av et mulig par Kode:Verdi
        private string Value(string s)
        {
            int p = s.IndexOf(':');
            if (p == -1) return s;
            return s.Substring(p+1);
        }

        //returner kode-elementet av et mulig par Kode:Verdi
        private string Code(string s)
        {
            int p = s.IndexOf(':');
            if (p == -1) return s;
            return s.Substring(0, p);
        }
     }
}