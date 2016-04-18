/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using EPiServer;
using System.Web.UI.WebControls;

namespace Avenir.Templates.Units.Static
{
    /// <summary>
    /// Lists the pages visible in the main (top) menu.
    /// </summary>
    public partial class Pager : UserControlBase
    {

        public delegate void PagerDelegate(string scroll);
        public event PagerDelegate PagerEvent;  


        //protected override void OnLoad(System.EventArgs e)
        //{
        //    base.OnLoad(e);
        //}


        protected void Nav_Click(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            string scr = FindScroll(MoreResults.Text, b);
            PagerEvent(scr);
        }

        //private void NavShowNot()
        //{
        //    n0.Visible = false;
        //    n1.Visible = false;
        //    n2.Visible = false;
        //    n3.Visible = false;
        //    n4.Visible = false;
        //    n5.Visible = false;
        //    n6.Visible = false;
        //    n7.Visible = false;
        //    n8.Visible = false;
        //    n9.Visible = false;
        //}

        public void InitNav(int scroll, int count)
        {
            string pager = PagerControl("", scroll, count);
            MoreResults.Text = pager;
            string[] s = pager.Split(',');
            int ant = s.Length;
            for (int i = 0; i < 10; i++)
            {
                //string id = "n" + i.ToString();
                Button b = FindButton(i);
                if (i < ant)
                {
                    string[] k = s[i].Split(':');
                    b.Text = " " + k[0] + " ";
                    b.Enabled = (k[2] == "1") ? true : false;
                    b.Visible = true;
                }
                else b.Visible = false;
            }
        }

        private string FindScroll(string pager, Button b)
        {
            string[] s = pager.Split(',');
            //int ant = s.Length;
            string id = b.ID;
            int nr = int.Parse(id.Substring(1));
            string[] k = s[nr].Split(':');
            b.Text = k[0];
            b.Enabled = (k[2] == "1") ? true : false;
            b.Visible = true;
            return k[1];
        }

        private Button FindButton(int nr)
        {
            switch (nr)
            {
                case 0: return n0;
                case 1: return n1;
                case 2: return n2;
                case 3: return n3;
                case 4: return n4;
                case 5: return n5;
                case 6: return n6;
                case 7: return n7;
                case 8: return n8;
                case 9: return n9;
                default: return null;
            }
        }

        /// <summary>
        /// Creates one element in the pager control.
        /// </summary>
        /// <param name="no">index no in pager</param>
        /// <param name="url"></param>
        /// <param name="scroll"></param>
        /// <returns>A string containing one element in the pager</returns>
        private string NextSearchNo(int no, string url, int scroll)
        {
            int start = (no * 10) - 10;
            //if (count < start + 10) return ""; 
            string strNo = no.ToString();
            //string urlAnd = testUrl(url);
            //if (scroll == start) return strNo + "&nbsp;"; //skal egentlig være besøkt link
            if (scroll == start) return "," + strNo + ":" + start + ":0";
            //string s = "<a href=\"" + urlAnd + "scroll=" + start.ToString() + "\">" + strNo + "&nbsp;</a>";
            string s = "," + strNo + ":" + start + ":1";
            return s;
        }

        /// <summary>
        /// Creates html for pager control used under search results.
        /// </summary>
        /// <param name="url">basepart for url used in each element</param>
        /// <param name="scroll">indicates current position in the total result set</param>
        /// <param name="count">total number of rows in result</param>
        /// <returns>A string containing the html of the control</returns>
        /// format: nr : scroll : enabled (1 = enabled, 0 =unabled)
        public string PagerControl(string url, int scroll, int count)
        {
            int scrollInn = scroll;
            scroll = scroll / 80; scroll *= 80; // Scroll = 0, 80, 160, 240, 320... Vi er ikke interessert i mellomverdier
            int antElementer = 0;
            if (count > 10)
                antElementer = (count + 9) / 10;
            bool nextEl = false;
            if (count > scroll + 80) nextEl = true;
            string s;
            int start = scroll / 10 + 1;
            int scrollNext = scroll + 80;
            int scrollPrev = scroll - 80;
            //string urlAnd = testUrl(url);
            if (scroll < 80)
            {
                s = "<<:0:0";
                if (antElementer > 7) antElementer = 8;
                for (int i = 1; i <= antElementer; i++)
                    s += NextSearchNo(i, url, scrollInn);
            }
            else
            {
                int maxCount = start + 8;
                int countToo = antElementer + 1;
                if (countToo > maxCount) countToo = maxCount;
                //s = "<a href=\"" + urlAnd + "scroll=" + scrollPrev.ToString() + "\">" + "<<&nbsp;</a>";
                s = "<<:" + scrollPrev + ":1";
                for (int i = start; i < countToo; i++)
                    s += NextSearchNo(i, url, scrollInn);

            }
            //if (antElementer >= maxCount -1) nextEl = true;
            //if (nextEl) s += "<a href=\"" + urlAnd + "scroll=" + scrollNext.ToString() + "\">" + "&nbsp;>></a>";
            if (nextEl) s += ",>>:" + scrollNext + ":1";
            return s;
        }

        //private string testUrl(string url)
        //{
        //    if (url.Contains("?"))
        //        return url + "&";
        //    else
        //        return url + "?";
        //}


    }
}