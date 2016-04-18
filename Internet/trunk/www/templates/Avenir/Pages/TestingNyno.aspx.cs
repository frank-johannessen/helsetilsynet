/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer;
using System;


namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class TestingNyno : TemplatePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (IsPostBack)
            {
                Msg.Text = string.Empty;
            }
            //else
            //{
            //    this.tillegg.Text = "/svc/rewrite";
            //}

        }

        protected void Test_Click(object sender, EventArgs e)
        {
            //Msg.Text += Lib.Nyno(query.Text);
            Msg.Text = new Nyno(query.Text, tillegg.Text, true).Query;
        }


    }
}