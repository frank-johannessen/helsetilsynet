/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using EPiServer;
using EPiServer.Personalization;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// Creates a subsription, which listens for changes in the website for the current user
    /// </summary>
    /// <remarks>Pages that one can subscribe to must be activated for subscription</remarks>
    public partial class SubscriptionPage : TemplatePage
    {

        protected void Subscribe_Click(object sender, EventArgs e)
        {
            EPiServerProfile user = EPiServerProfile.Current;
            
            user.SubscriptionInfo.Interval = Int32.Parse(Interval.SelectedItem.Value);
            
            if (Email.Enabled)
            {
                user.Email = Email.Text;
            }

            user.Save();
        }
    }
}
