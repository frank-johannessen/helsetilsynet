using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using EPiServer;

namespace Avenir.Templates.Units.Placeable
{
    public partial class RssQuery : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string v;
                string t;
                int j = 0;

                Lib.CurrentPage = CurrentPage;
                string s = "alle," + Lib.CountyList();
                string[] sF = s.Split(',');
                //Fylke.DataSource = sF;
                //Fylke.DataBind();
                foreach (string item in sF)
                {
                    ValueText(item, out v, out t);
                    Fylke.Items.Add(t);
                    Fylke.Items[j].Value = v;
                    j++;
                }

                s = "alle," + Lib.RegionList();
                string[] sR = s.Split(',');
                //Region.DataSource = sR;
                //Region.DataBind();
                j = 0;
                foreach (string item in sR)
                {
                    ValueText(item, out v, out t);
                    Region.Items.Add(t);
                    Region.Items[j].Value = v;
                    j++;
                }
                
                s = "alle," + Lib.DocTypeList();
                string[] sD = s.Split(',');
                j = 0;
                foreach (string item in sD)
                {
                    string k = item;
                    if (k.Substring(0, 1) == "@") // stikktittel
                    {
                        k = k.Substring(1);
                        int p1 = k.IndexOf('@');
                        k = k.Substring(p1 + 1);
                    }
                    ValueText(k, out v, out t);
                    Dokumenttype.Items.Add(t);
                    Dokumenttype.Items[j].Value = v;
                    j++;
                }

                Emne.Items.Add("alle");
                List<ListItem> l = emneList();
                foreach (ListItem item in l)
                {
                    Emne.Items.Add(item);
                }

                Fylke.Items[0].Selected = true;
                Region.Items[0].Selected = true;
                Dokumenttype.Items[0].Selected = true;
                Emne.Items[0].Selected = true;

                Menygren.Items.Add("alle");
                Menygren.Items.Add("Regelverk");
                Menygren.Items.Add("Tilsyn");
                Menygren.Items.Add("Rettigheter og klager");
                Menygren.Items.Add("Publikasjoner");
                Menygren.Items.Add("Presse");
                Menygren.Items.Add("Om Helsetilsynet");
            }
        }

        protected void BtnCreate_Click(object sender, EventArgs e)
        {
            string q = string.Empty;
            string alle = "alle";
            string skill = string.Empty;
            //string test = this.Fylke.Text;
            q += CheckList(Fylke, "fylke"); 
             q += CheckList(Region, "region"); 
 
            q += CheckList(Dokumenttype, "dokumenttype"); 

            if (Emne.Text != alle)
            {
                string t = Emne.Text;
                int p = t.IndexOf(":");
                if (p > 0 && t.Length > p + 2)
                {
                    t = t.Substring(p + 2);
                }
                q += skill + "emne:" + t ;
            }

            q += CheckBranch(Menygren);
            
            if(q.EndsWith(";"))
                q = q.Substring(0,q.Length-1);
            if (q == string.Empty)
                q = "kode:htil";
            q = HttpUtility.UrlEncode(q);
            //string link = EPiServer.Configuration.Settings.Instance.SiteUrl + ResolveUrl("ts/rss?g=" + q);
            string link = EPiServer.Configuration.Settings.Instance.SiteUrl + "ts/rss?g=" + q;
            string s = "<a href=\"" + link + "\" target=\"blank\">Lenke til RSS</a>";
            Resultat.Text = s;
            ResultatPanel.Visible = true;
        }


        //private string CheckEmne()
        //{
        //    string s = string.Empty;
        //    string start = "emne:";
        //    foreach (ListItem item in Emne.Items)
        //    {
        //        string value = item.ToString();
        //        if (item.Selected && value != "alle" && value != string.Empty)
        //        {
        //            int p = value.IndexOf(":");
        //            if (p > 0 && value.Length > p + 2)
        //            {
        //                value = value.Substring(p + 2);
        //            }
        //            s += start + value;
        //            start = "#";
        //        }
        //    }
        //    if (s != string.Empty)
        //        s += ";";
        //    return s;
        //}

        private string CheckBranch(ListBox liste)
        {
            string s = string.Empty;
            string start = "menugroup:";
            foreach (ListItem item in liste.Items)
            {
                string value = item.Value;
                if (value == "Rettigheter og klager")
                    value = "Rettigheter";
                if (item.Selected && value != "alle" && value != string.Empty)
                {
                    s += start + value;
                    start = "#";
                }
            }
            if (s != string.Empty)
                s += ";";
            return s;
       
        }

        private string CheckList(ListBox liste, string navn)
        {
            string s = string.Empty;
            string start = navn + ":";
            foreach (ListItem item in liste.Items)
            {
                string value = item.Value;
                if (item.Selected && value != "alle" && value != string.Empty)
                {
                    s += start + value;
                    start = "#";
                }
            }
            if (s != string.Empty)
                s += ";";
            return s;
        }


        //private string gruppeKode(string kode)
        //{
        //    switch (kode)
        //    {
        //        case "Helsetjenesten": return "ht";
        //        case "Sosialtjenesten": return "wt";
        //        case "Barneverntjenesten": return "bt";
        //        case "Andre emner": return "ae";
        //    }
        //    return string.Empty;
        //}

        private List<ListItem> emneList()
        {
            List<ListItem> l = new List<ListItem>();
            string sList = CurrentPage["KeyWordList"].ToString();
            sList = sList.Replace("<p>", "");
            sList = sList.Replace("</p>", "");
            string[] list = sList.Split(',');
            int i = 0;
            //string s = string.Empty;
            string keyName;
            //int p;
            //string skill = string.Empty;
            string gruppe = string.Empty;
            foreach (string keyword in list)
            {
                i++;
                keyName = keyword;// vi må fjerne evt. angivelse av gruppenr
                if (string.IsNullOrEmpty(keyName))
                    continue;
                if (keyName.Contains('#')) //angir gruppe
                {
                    gruppe = Lib.KeyGroup(keyName.Substring(2)) + ": ";
                    continue;
                }

                string v;
                string t;
                ValueText(keyName, out v, out t);
                int p = t.IndexOf('0');
                if (p > 0)
                    t = t.Substring(0, p);

                ListItem li = new ListItem(gruppe + t, v);
                l.Add(li);
                //s += skill + gruppe + ": " + keyName;
                //skill = ",";
            }
            return l;
        }



        //private string emneList()
        //{
        //    string sList = CurrentPage["KeyWordList"].ToString();
        //    string[] list = sList.Split(',');
        //    int i = 0;
        //    string s = string.Empty;
        //    string keyName;
        //    int p;
        //    string skill = string.Empty;
        //    string gruppe = string.Empty;
        //    foreach (string keyword in list)
        //    {
        //        i++;
        //        keyName = keyword;// vi må fjerne evt. angivelse av gruppenr
        //        if (string.IsNullOrEmpty(keyName))
        //            continue;
        //        if (keyName.Contains('#')) //angir gruppe
        //        {
        //            gruppe = Lib.KeyGroup(keyName.Substring(2));
        //            continue;
        //        }
        //        //p = keyName.IndexOf('0');
        //        //if (p > 0)
        //        //    keyName = keyName.Substring(0, p);
        //        s += skill + gruppe + ": " + keyName;
        //        skill = ",";
        //    }
        //    return s;
        //}

        private void ValueText(string inn, out string v, out string t)
        {   
            v = inn;
            t = inn;
            int p = inn.IndexOf(':');
            if (p > 0)
            {
                v = inn.Substring(0, p);
                t = inn.Substring(p+1);
            }
        }
    }
}