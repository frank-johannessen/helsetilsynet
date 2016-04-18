/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer;
using EPiServer.DataAbstraction;


namespace Avenir.Templates.Units.Placeable
{
    public partial class CategoryList : UserControlBase
    {

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)
            {
            }
        }


        protected string GetCategoryList()
        {
            string s = string.Empty;
            Category cat = Category.GetRoot();
            //string name;
            //int p;
            foreach (Category subCat in cat.Categories)
            {
                //name = subCat.Name;
                //p = name.IndexOf('0');
                //if (p > 0)
                //    name = name.Substring(0, p - 1);
                //s += "<li><input type=\"checkbox\" value=\"" + subCat.Name + "\" />" + name + "</li>";
                s += "<li><input type=\"checkbox\" value=\"\" />" + subCat.Name + "</li>";
            }
            return s;
        }

            //string totList = ((EPiServer.PageBase)Page).CurrentPage["KeyWordList"].ToString();
            //string[] ht = GetKeyGroupe("##ht", ref totList);
            //string[] st = GetKeyGroupe("##st", ref totList);
            //string[] bt = GetKeyGroupe("##bt", ref totList);
            //string[] ae = GetKeyGroupe("##ae", ref totList);
            //string html = "<div class='subBox'><h3>Helsetjenesten</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref ht) + "</ul>";
            //html += "<p class=\"readMore\"><a href=\"#\">Se alle emner for Helsetjenesten</a></p></div>";
            //html += "<div class='subBox'><h3>Sosialtjenesten</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref st) + "</ul>";
            //html += "<p class=\"readMore\"><a href=\"#\">Se alle emner for Sosialtjenesten</a></p></div>";
            //html += "<div class='subBox'><h3>Barneverntjenesten</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref bt) + "</ul>";
            //html += "<p class=\"readMore\"><a href=\"#\">Se alle emner for Barneverntjenesten</a></p></div>";
            //html += "<div class='subBox'><h3>Andre emner</h3><ul class=\"jQtopicList\">" + GetKeyHtml(ref ae) + "</ul>";
            //html += "<p class=\"readMore\"><a href=\"#\">Se alle emner</a></p></div>";
            //return html;
        //}



        //private string GetKeyHtml(ref string[] list)
        //{ 
        //    int i = 0;
        //    string s = string.Empty;
        //    foreach (string keyword in list)
        //        {
        //            i++;
        //            //if (i == 6) break;
        //            s += "<li><a href=\"" + ResolveUrl("~/no/um/emner/") + "\">" + keyword + "</a></li>";
        //        }
        //    return s;
        //}

        //private string[] GetKeyGroupe(string groupe, ref string list)
        //{
        //    string[] result = {""};
        //    string s;
        //    int p = list.IndexOf(groupe);
        //    if (p >= 0 && list.Length > p+5)
        //    {
        //        int p2 = list.IndexOf("#", p+5 );
        //        if (p2 == -1) //Siste del av hele listen
        //            s = list.Substring(p+5);
        //        else
        //            s = list.Substring(p+5 , p2 - p -5);
        //        result = s.Split(',');
        //    }
        //    return result;
        //}


     }
}