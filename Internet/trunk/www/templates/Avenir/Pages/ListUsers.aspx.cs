/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer.Core;
using EPiServer;
using System;
using System.IO;
using System.Web.Security;
using System.Collections.Generic;
using EPiServer.Personalization;

namespace Helsetilsynet.templates.Avenir.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class ListUsers : TemplatePage
    {
        protected void Write_Click(object sender, EventArgs e)
        {
            ListAllUsers();
        }

        protected void Sub_Click(object sender, EventArgs e)
        {
            ListSubscription();
        }


        protected void Delete_Click(object sender, EventArgs e)
        {
            Readfile("slett");
        }

        protected void Create_Click(object sender, EventArgs e)
        {
            Readfile("create");
        }

        protected void Change_Click(object sender, EventArgs e)
        {
            Readfile("change");
        }
 
        
        private void Readfile(string funk)
        {
            String filname = Server.MapPath("~") + "ListUsers.txt";
            StreamReader sr = new StreamReader(filname);
            sr.ReadLine();
            while (!sr.EndOfStream)
            {
                string s = sr.ReadLine();
                if (s != null)
                {
                    string[] a = s.Split('\t');
                    if (funk == "slett")
                        DeleteUser(a);
                    else if (funk == "create")
                        CreateUser(a[0],a[1]);
                    else if (funk == "change")
                        ChangeUser(a[0]);
                }
            }
            sr.Close();
        }

        private void CreateUser(string email, string interval)
        {
            try
            {
            Membership.CreateUser(email, email, email);
            string[] users = { email };
                Roles.AddUsersToRole(users, "Abonnement");
            IList<EPiServerProfile> profiles = EPiServerProfile.GetProfiles(email);

            if (profiles.Count > 1) // Specified address returned group
            {
            }
            else // Single profile, or non-existing profile
            {
                // Get the existing/new profile
                EPiServerProfile profile = profiles[0];
                profile.Email = email;
                profile.SubscriptionInfo.Interval = int.Parse(interval);
                PageReference pr = PageReference.Parse("11251");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("2134");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("11272");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("2048");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("2047");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("8721");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("2061");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("5907");
                profile.SubscriptionInfo.SubscribeTo(pr);
                pr = PageReference.Parse("10932");
                profile.SubscriptionInfo.SubscribeTo(pr);
                //profile.SubscriptionInfo.SubscribeTo(subscriptionTargetPageLink, ddLanguage.SelectedValue);
                profile.Save();
            }
            Msg.Text += email + "<br/>";
            }
            catch
            { };
        
        }

        private void ChangeUser(string email)
        {
            try
            {
                //string[] users = { email };
                IList<EPiServerProfile> profiles = EPiServerProfile.GetProfiles(email);

                if (profiles.Count > 1) // Specified address returned group
                {
                    Msg.Text += email + " count overvekt<br/>";
                }
                else // Single profile, or non-existing profile
                {
                    // Get the existing/new profile
                    EPiServerProfile profile = profiles[0];
                    profile.SubscriptionInfo.LastMessage = DateTime.Now;
                    profile.Save();
                }
            }
            catch { Msg.Text += email + "<br/>"; };
        }



        private void DeleteUser(string[] a)
        {
                string userName = a[0];
            try
            {
                Membership.DeleteUser(userName, true);
            }
            catch { Msg.Text += userName + "<br/>"; };
        }


        protected void ListAllUsers()
        {
            string msg = string.Empty;

            List<MembershipUser> users = new List<MembershipUser>();
            foreach (MembershipUser user in Membership.GetAllUsers())
            {
                EPiServerProfile prof = EPiServerProfile.Get(user.UserName);
                msg += string.Format("{0};{1};{2};{3}<br/>", user.UserName, user.Email, prof.SubscriptionInfo.Interval, prof.SubscriptionInfo.LastMessage);
            }
            Msg.Text = msg;
        }


        protected void ListSubscription()
        {
            string msg = txtGroup.Text + "<br/>";
            string username = txtGroup.Text;
            EPiServerProfile prof = EPiServerProfile.Get(username);
            //List<SubscriptionDescriptor> list = prof.SubscriptionInfo.SubscribedPages;
            //foreach (SubscriptionDescriptor item in list)
            //{
            //    msg += item.PageID.ToString() + "<br/>";
            //}
            PageReference[] subs = prof.SubscriptionInfo.ListSubscriptions();
            foreach (PageReference item in subs)
            {
                msg += string.Format("{0}<br/>", item.ID);
            }
            Msg.Text = msg;
        }
    }
}