using System;
using EPiServer.Common;
using EPiServer.Common.Comments;
using EPiServer.Common.Configuration;
using EPiServer.Common.Content;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Blog;
using EPiServer.Community.Blog.Security;
using EPiServer.Community.Calendar;
using EPiServer.Community.Calendar.Security;
using EPiServer.Community.Club;
using EPiServer.Community.Club.Security;
using EPiServer.Community.Contact;
using EPiServer.Community.Forum;
using EPiServer.Community.Forum.Security;
using EPiServer.Community.ImageGallery;
using EPiServer.Community.ImageGallery.Security;
using EPiServer.Community.Modules;
using EPiServer.Community.MyPage;
using EPiServer.Community.NewsFeed;
using EPiServer.Community.NewsFeed.Security;
using EPiServer.Community.VideoGallery;
using EPiServer.Community.VideoGallery.Security;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace Relate.HelpersAndExtensions
{
    [EPiServer.Common.Modules.ModuleDependency(typeof(ClubModule), typeof(MyPageModule))]
    public class CommunitySecurityModule : IModule
    {
        # region Properties

        public IGroup AnonymousGroup
        {
            get
            {
                return EPiServer.Common.Settings.DefaultSecurity.GetGroup(EPiServerCommonSection.Instance.SecurityElement.AnonymousGroupId);
            }
        }

        public IGroup AdministratorsGroup
        {
            get
            {
                return SecurityHandler.Instance.GetGroupByName(RelateConstants.AdministratorGroupName) ??
                       SecurityHandler.Instance.AddGroup(new Group(RelateConstants.AdministratorGroupName));
            }
        }

        public IGroup ModeratorsGroup
        {
            get
            {
                return SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityModeratorGroupName) ??
                       SecurityHandler.Instance.AddGroup(new Group(RelateConstants.CommunityModeratorGroupName));
            }
        }

        public IGroup CommunityAdministratorsGroup
        {
            get
            {
                return SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityAdminsGroupName) ??
                       SecurityHandler.Instance.AddGroup(new Group(RelateConstants.CommunityAdminsGroupName));
            }
        }
        public IGroup CommunityMembers
        {
            get
            {
                return SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityMembersGroupName) ??
                       SecurityHandler.Instance.AddGroup(new Group(RelateConstants.CommunityMembersGroupName));
            }
        }

        # endregion

        #region IModule Members

        public string AdministrationControl
        {
            get { return ""; }
        }

        public string Name
        {
            get { return "RelatePlusSecurityModule"; }
        }

        public string UniqueName
        {
            get { return "RelatePlusSecurityModule"; }
        }
        public void OnApplicationStart(EPiServer.Community.CommunityContext context)
        {
            // Subscribe to events where access rights needs to be set

            #region Club events.
            ClubHandler.Instance.ClubAdded += new EPiServer.Common.EPiServerCommonEventHandler(ClubHandler_ClubAdded);
            ClubHandler.Instance.MembershipAdded += new EPiServer.Common.EPiServerCommonEventHandler(ClubHandler_MembershipAdded);
            ClubHandler.Instance.MembershipRemoved += new EPiServer.Common.EPiServerCommonEventHandler(ClubHandler_MembershipRemoved);
            ClubHandler.Instance.ClubRemoved += new EPiServer.Common.EPiServerCommonEventHandler(ClubHandler_ClubRemoved);
            ClubHandler.Instance.ClubUpdated += new EPiServerCommonEventHandler(ClubHandler_ClubUpdated);

            #endregion

            #region Security events.

            CommunitySystem.CurrentContext.DefaultSecurity.CreatedUser += new EPiServer.Common.Security.UserCreateEventHandler(DefaultSecurity_CreatedUser);
            CommunitySystem.CurrentContext.DefaultSecurity.UpdatedUser += new UpdateUserEventHandler(DefaultSecurity_UpdatedUser);

            #endregion

            #region Comment events

            CommentHandler.Instance.CommentAdded += new EPiServer.Common.EPiServerCommonEventHandler(CommentHandler_AddEntry);

            #endregion

            #region MyPage events.

            MyPageHandler.Instance.Register += new EPiServer.Common.EPiServerCommonEventHandler(MyPageHandler_Register);

            #endregion

            #region Blog events.

            BlogHandler.Instance.BlogAdded += new EPiServer.Common.EPiServerCommonEventHandler(BlogHandler_BlogAdded);
            BlogHandler.Instance.EntryCommentAdded += new EPiServerCommonEventHandler(BlogHandler_EntryCommentAdded);
            BlogHandler.Instance.EntryAdded += new EPiServerCommonEventHandler(BlogHandler_AddEntry);
            BlogHandler.Instance.EntryRemoved += new EPiServerCommonEventHandler(BlogHandler_EntryRemoved);

            #endregion

            #region Image gallery events.

            ImageGalleryHandler.Instance.ImageGalleryAdded += new EPiServer.Common.EPiServerCommonEventHandler(ImageGalleryHandler_ImageGalleryAdded);
            ImageGalleryHandler.Instance.ImageAdded += new EPiServerCommonEventHandler(ImageGalleryHandler_ImageAdded);
            ImageGalleryHandler.Instance.ImageCommentAdded += new EPiServerCommonEventHandler(ImageGalleryHandler_ImageCommentAdded);

            #endregion

            #region Forum events.

            ForumHandler.Instance.RoomAdded += new EPiServerCommonEventHandler(ForumHandler_RoomAdded);
            ForumHandler.Instance.TopicAdded += new EPiServerCommonEventHandler(ForumHandler_TopicAdded);
            ForumHandler.Instance.ReplyAdded += new EPiServerCommonEventHandler(ForumHandler_ReplyAdded);

            #endregion

            #region Calendar events.

            CalendarHandler.Instance.EventAdded += new EPiServerCommonEventHandler(CalendarHandler_EventAdded);
            CalendarHandler.Instance.CalendarAdded += new EPiServerCommonEventHandler(CalendarHandler_CalendarAdded);

            #endregion

            #region Contact events.

            ContactHandler.Instance.ContactRelationUpdated += new EPiServerCommonEventHandler(ContactHandler_ContactRelationUpdated);
            ContactHandler.Instance.ContactRelationRemoved += new EPiServerCommonEventHandler(ContactHandler_ContactRelationRemoved);

            #endregion

            #region video gallery events.

            VideoGalleryHandler.Instance.VideoAdded += new EPiServerCommonEventHandler(VideoGalleryHandler_VideoAdded);
            VideoGalleryHandler.Instance.VideoGalleryAdded += new EPiServerCommonEventHandler(VideoGalleryHandler_VideoGalleryAdded);
            VideoGalleryHandler.Instance.VideoCommentAdded += new EPiServerCommonEventHandler(VideoGalleryHandler_VideoCommentAdded);

            #endregion

        }


        #endregion

        #region Event handlers

        #region Calendar Event Handlers.

        void CalendarHandler_CalendarAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Calendar)e.Object, (Calendar)e.Object);
        }

        void CalendarHandler_EventAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Event)e.Object, ((Event)e.Object).Calendar);
        }

        #endregion

        #region Forum Event Handlers.

        void ForumHandler_ReplyAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Reply)e.Object, ((Reply)e.Object).Topic);
        }

        void ForumHandler_TopicAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Topic)e.Object, (Topic)e.Object);
        }

        void ForumHandler_RoomAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((RoomBase)e.Object, (RoomBase)e.Object);
        }

        #endregion

        #region VideoGallery Event Handlers.

        void VideoGalleryHandler_VideoCommentAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((VideoComment)e.Object, ((VideoComment)e.Object).Video.VideoGallery);
        }

        void VideoGalleryHandler_VideoGalleryAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((VideoGallery)e.Object, (VideoGallery)e.Object);
        }

        void VideoGalleryHandler_VideoAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Video)e.Object, ((Video)e.Object).VideoGallery);
        }

        #endregion

        #region Contact Event Handlers.

        void ContactHandler_ContactRelationRemoved(string sender, EPiServerCommonEventArgs e)
        {
            ContactRelation cr = (ContactRelation)e.Object;

            if (cr.Status == EntityStatus.Approved)
            {
                // the user that is removing a contact.
                IUser approverUser = cr.ContactContainer.User;
                NewsFeed approverMiniFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(approverUser, NewsFeedType.MiniFeed);
                NewsFeed approverNewsFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(approverUser, NewsFeedType.NewsFeed);

                // the user that is being removed.
                IUser removedContactUser = cr.ContactUser;
                if(removedContactUser != null)
                {
                    if (approverMiniFeed != null)
                        EntitySecurityHandler.Instance.RemoveAccessRights(approverMiniFeed, removedContactUser);
                    if (approverNewsFeed != null)
                        EntitySecurityHandler.Instance.RemoveAccessRights(approverNewsFeed, removedContactUser);
                }
                

                NewsFeed removedContactMiniFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(removedContactUser, NewsFeedType.MiniFeed);
                NewsFeed removedContactNewsFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(removedContactUser, NewsFeedType.NewsFeed);

                if (removedContactMiniFeed != null)
                {
                    EntitySecurityHandler.Instance.RemoveAccessRights(removedContactMiniFeed, approverUser);
                }

                if (removedContactNewsFeed != null)
                {
                    EntitySecurityHandler.Instance.RemoveAccessRights(removedContactNewsFeed, approverUser);
                }
            }
        }

        void ContactHandler_ContactRelationUpdated(string sender, EPiServerCommonEventArgs e)
        {
            ContactRelation cr = (ContactRelation)e.Object;

            if (cr.Status == EntityStatus.Approved)
            {
                // the user that approved the friendship request.
                IUser approverUser = cr.ContactUser;
                NewsFeed approverMiniFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(approverUser, NewsFeedType.MiniFeed);
                NewsFeed approverNewsFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(approverUser, NewsFeedType.NewsFeed);

                // the user that requested the friendship.
                IUser requesterUser = cr.ContactContainer.User;
                NewsFeed requesterMiniFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(requesterUser, NewsFeedType.MiniFeed);
                NewsFeed requesterNewsFeed = NewsFeedHandler.Instance.GetNewsFeedByUser(requesterUser, NewsFeedType.NewsFeed);

                NewsFeedAccessRights miniFeedAccessRights = new NewsFeedAccessRights() { Read = true };
                NewsFeedAccessRights newsFeedAccessRights = new NewsFeedAccessRights() { Read = true };

                // set access rights for the requester user.
                EntitySecurityHandler.Instance.SetAccessRights(approverMiniFeed, requesterUser, miniFeedAccessRights);
                EntitySecurityHandler.Instance.SetAccessRights(approverNewsFeed, requesterUser, newsFeedAccessRights);

                // set access rights for the approver user
                EntitySecurityHandler.Instance.SetAccessRights(requesterMiniFeed, approverUser, miniFeedAccessRights);
                EntitySecurityHandler.Instance.SetAccessRights(requesterNewsFeed, approverUser, newsFeedAccessRights);

            }
        }

        #endregion

        #region Image Gallery Event Handlers.

        void ImageGalleryHandler_ImageAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Image)e.Object, ((Image)e.Object).ImageGallery);
        }

        void ImageGalleryHandler_ImageCommentAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((ImageComment)e.Object, ((ImageComment)e.Object).Image.ImageGallery);
        }

        void ImageGalleryHandler_ImageGalleryAdded(string sender, EPiServer.Common.EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((ImageGallery)e.Object, (ImageGallery)e.Object);
        }

        #endregion

        #region Blog Event Handlers.

        void BlogHandler_BlogAdded(string sender, EPiServer.Common.EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Blog)e.Object, (Blog)e.Object);
        }

        void BlogHandler_AddEntry(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Entry)e.Object, ((Entry)e.Object).Blog);
        }

        void BlogHandler_EntryCommentAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((EntryComment)e.Object, ((EntryComment)e.Object).Entry.Blog);
        }

        private void BlogHandler_EntryRemoved(string sender, EPiServerCommonEventArgs e)
        {

            var entry = e.Object as Entry;

            if (entry != null)
            {
                // remove from newsfeed
                int totalItems;
                NewsFeedStoryCollection newsFeedStoryCollection =
                    NewsFeedHandler.Instance.GetNewsFeedStoriesByTarget(entry, EntityStatus.Approved, null,
                                                                        DateTime.MinValue, DateTime.Now, 1, 1000,
                                                                        out totalItems);

                foreach (var story in newsFeedStoryCollection)
                {
                    NewsFeedHandler.Instance.RemoveStory(story);
                }

            }
        }

        #endregion

        #region Security Event Handlers.

        /// <summary>
        /// Adds the created user to the community group specified in Web.config
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="args">The <see cref="EPiServer.Common.Security.ICreateUserEventArgs"/> instance containing the event data.</param>
        private void DefaultSecurity_CreatedUser(ISecurityHandler sender, ICreateUserEventArgs args)
        {
            // Add user to the community members group
            IGroup group = CommunityMembers;
            IUser addedUser = args.User;
            addedUser = (IUser)addedUser.Clone();
            addedUser.Groups.Add(group);

            // Update the user
            CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(addedUser);

            // Set access rights to the newly created user
            // Access right for anonymous users
            ReadModifyRemoveAccessRights anonAccessRights = new ReadModifyRemoveAccessRights()
            {
                Read = true,
            };
            EntitySecurityHandler.Instance.SetAccessRights(addedUser, AnonymousGroup, anonAccessRights);

            // Access right for community members
            ReadModifyRemoveAccessRights communityMembersAccessRights = new ReadModifyRemoveAccessRights()
            {
                Read = true,
            };
            EntitySecurityHandler.Instance.SetAccessRights(addedUser, group, communityMembersAccessRights);

            // Access rights for administrators
            ReadModifyRemoveAccessRights adminAccessRights = new ReadModifyRemoveAccessRights()
            {
                Read = true,
                Modify = true,
                Remove = true
            };
            EntitySecurityHandler.Instance.SetAccessRights(addedUser, AdministratorsGroup, adminAccessRights);

            // Access rights for the added user
            ReadModifyRemoveAccessRights userAccessRights = new ReadModifyRemoveAccessRights()
            {
                Read = true,
                Modify = true,
                Remove = true
            };
            EntitySecurityHandler.Instance.SetAccessRights(addedUser, addedUser, userAccessRights);

            // Access rights for moderator
            ReadModifyRemoveAccessRights moderatorAccessRights = new ReadModifyRemoveAccessRights()
            {
                Read = true,
                Modify = true,
                Remove = true
            };
            EntitySecurityHandler.Instance.SetAccessRights(addedUser, ModeratorsGroup, moderatorAccessRights);
        }
        private void DefaultSecurity_UpdatedUser(ISecurityHandler sender, IUpdateUserEventArgs args)
        {
            // Add user to the community members group
            IUser addedUser = args.User;
            //addedUser = (IUser)addedUser.Clone();


            // Update the user
            //CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(addedUser);
        }
        
        #endregion

        #region Club Event Handlers.

        void ClubHandler_ClubAdded(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Club)e.Object, (Club)e.Object);
        }

        /// <summary>
        /// Removes the club member from the security group
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="EPiServer.Common.EPiServerCommonEventArgs"/> instance containing the event data.</param>
        private static void ClubHandler_MembershipRemoved(string sender, EPiServerCommonEventArgs e)
        {
            // Remove the membership user 
            Club club = ((Membership)e.Object).Club;
            IUser user = ((Membership)e.Object).User.Clone() as IUser;

            IGroup clubMembersGroup = club.GetGroup(Enums.ClubGroupType.MembersGroup);

            if (clubMembersGroup != null && user != null)
            {
                // Remove the group from user
                if (user.IsMemberOfClubGroup(club, Enums.ClubGroupType.MembersGroup))
                {
                    user.Groups.Remove(clubMembersGroup);
                    // Update the user
                    CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);
                }
            }

            // remove the user from the admin group if necessary.
            if (user != null && user.IsMemberOfClubGroup(club, Enums.ClubGroupType.AdminsGroup))
            {
                IGroup clubAdminsGroup = club.GetGroup(Enums.ClubGroupType.AdminsGroup);
                if (clubAdminsGroup != null)
                {
                    user.Groups.Remove(clubAdminsGroup);
                    CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);
                }
            }

        }

        /// <summary>
        /// Adds the club member to the club security group
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="EPiServer.Common.EPiServerCommonEventArgs"/> instance containing the event data.</param>
        private static void ClubHandler_MembershipAdded(string sender, EPiServerCommonEventArgs e)
        {
            // Add the membership user to the club group
            Club club = ((Membership)e.Object).Club;
            IUser user = (IUser)((Membership)e.Object).User.Clone();
            IGroup group = club.GetGroup(Enums.ClubGroupType.MembersGroup);

            if (group != null && user != null)
            {
                //If user not has the group, add it
                if (!user.IsMemberOfClubGroup(club, Enums.ClubGroupType.MembersGroup))
                {
                    user.Groups.Add(group);

                    // Update the user
                    CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);

                }
            }
        }

        /// <summary>
        /// Removes the security corresponding to the removed club
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="EPiServer.Common.EPiServerCommonEventArgs"/> instance containing the event data.</param>
        private static void ClubHandler_ClubRemoved(string sender, EPiServerCommonEventArgs e)
        {
            // Get club object
            Club club = e.Object as Club;

            // Find the club groups.
            IGroup clubMembersGroup = club.GetGroup(Enums.ClubGroupType.MembersGroup);
            IGroup clubAdminsGroup = club.GetGroup(Enums.ClubGroupType.AdminsGroup);

            // Remove members group.
            if (clubMembersGroup != null)
            {
                CommunitySystem.CurrentContext.DefaultSecurity.RemoveGroup(clubMembersGroup);
            }

            // Remove the admin group.
            if (clubAdminsGroup != null)
            {
                CommunitySystem.CurrentContext.DefaultSecurity.RemoveGroup(clubAdminsGroup);
            }
        }

        void ClubHandler_ClubUpdated(string sender, EPiServerCommonEventArgs e)
        {
            Club club = (Club)e.Object;
            Club oldClub = (Club)((IEntity)club).Master;

            if (club.Owner != oldClub.Owner)
            {
                // Remove the old owner from the club admin group.
                if (oldClub.Owner != null)
                {
                    IUser oldOwner = (IUser)oldClub.Owner.Clone();
                    if (oldOwner.IsMemberOfClubGroup(club, Enums.ClubGroupType.AdminsGroup))
                    {
                        oldOwner.Groups.Remove(club.GetGroup(Enums.ClubGroupType.AdminsGroup));
                        CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(oldOwner);
                    }
                }

                // Add the new owner to the club admin group.
                if (club.Owner != null)
                {
                    IUser newOwner = (IUser)club.Owner.Clone();
                    if (!newOwner.IsMemberOfClubGroup(club, Enums.ClubGroupType.AdminsGroup))
                    {
                        newOwner.Groups.Add(club.GetGroup(Enums.ClubGroupType.AdminsGroup));
                        CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(newOwner);
                    }
                }
            }
        }

        #endregion

        #region MyPage Event Handlers.

        /// <summary>
        /// Sets the owner of MyPage Galleries
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="EPiServer.Common.EPiServerCommonEventArgs"/> instance containing the event data.</param>
        private static void MyPageHandler_Register(string sender, EPiServer.Common.EPiServerCommonEventArgs e)
        {
            // Get the user
            IUser user = e.Object as IUser;

            if (user != null)
            {
                // Get the user's My Page, that will be created on first call
                MyPage myPage = MyPageHandler.Instance.GetMyPage(user);

                if (myPage != null && myPage.ImageGallery != null)
                {
                    foreach (ImageGallery imageGallery in myPage.ImageGallery.Children)
                    {
                        // Create clone, so we can alter object
                        ImageGallery imageGalleryClone = imageGallery.Clone() as ImageGallery;

                        // Set the owner
                        imageGalleryClone.SetOwner(user);

                        // Save changes
                        ImageGalleryHandler.Instance.UpdateImageGallery(imageGalleryClone);
                    }

                    // create the user's newsfeed and minifeed and set its access rights.
                    NewsFeed newsFeed = new NewsFeed(NewsFeedType.NewsFeed, user);
                    newsFeed = NewsFeedHandler.Instance.AddNewsFeed(newsFeed);

                    NewsFeedAccessRights nfAccessRights = new NewsFeedAccessRights()
                    {
                        Read = true,
                        Modify = true,
                        Remove = true,
                        Categorize = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };

                    EntitySecurityHandler.Instance.SetAccessRights(newsFeed, user, nfAccessRights);

                    NewsFeed miniFeed = new NewsFeed(NewsFeedType.MiniFeed, user);
                    miniFeed = NewsFeedHandler.Instance.AddNewsFeed(miniFeed);

                    NewsFeedAccessRights miniFeedAccessRights = new NewsFeedAccessRights()
                    {
                        Read = true,
                        Modify = true,
                        Remove = true,
                        Categorize = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };

                    EntitySecurityHandler.Instance.SetAccessRights(miniFeed, user, miniFeedAccessRights);

                }

            }
        }

        #endregion

        #region comment Event Handlers

        void CommentHandler_AddEntry(string sender, EPiServerCommonEventArgs e)
        {
            SetAccessRightsForEntity((Comment)e.Object, (Comment)e.Object);
        }

        #endregion

        #endregion

        #region Helpers

        /// <summary>
        /// Grant access rights for a <see cref="FrameworkEntityStatusBase"/>.
        /// </summary>
        /// <param name="entity">The <see cref="FrameworkEntityStatusBase"/> to set the access rights.</param>
        /// <param name="parentEntityOwner">The <see cref="IEntity"/> representing the parent of the entity that is being added.</param>
        public void SetAccessRightsForEntity(FrameworkEntityStatusBase entity, IEntity parentEntity)
        {
            Club club = null;
            MyPage mypage = null;

            IAuthor author = (entity is IContent ? ((IContent)entity).Author : null);
            IUser entityUserOwner = entity.GetEntityUserOwner(GetParentEntityOwner(parentEntity), out club, out mypage);

            if (entityUserOwner != null && club == null)
            {
                SetFullAccessRights(entity, entityUserOwner);
            }

            if (author != null && author.GetUser() != null && author.GetUser() != entityUserOwner)
            {
                SetFullAccessRights(entity, author.GetUser());
            }

            if (club != null || entity is Club)
            {
                club = (club ?? (Club)entity);

                // create a group for the club members if there isn't one created already.
                if (club.GetGroup(Enums.ClubGroupType.MembersGroup) == null)
                {
                    CreateClubGroup(club, Enums.ClubGroupType.MembersGroup);
                }

                // create a group for the club owner or admins if there isn't one created already.
                if (club.GetGroup(Enums.ClubGroupType.AdminsGroup) == null)
                {
                    IGroup clubAdminGroup = CreateClubGroup(club, Enums.ClubGroupType.AdminsGroup);
                }

                // add the club owner to the club owner's group.
                if (entity is Club)
                {
                    if (club.Owner != null && !club.Owner.IsMemberOfClubGroup(club, Enums.ClubGroupType.AdminsGroup))
                    {
                        IUser user = (IUser)club.Owner.Clone();
                        user.Groups.Add(club.GetGroup(Enums.ClubGroupType.AdminsGroup));
                        CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);
                    }
                }

                #region Access rights for the club members
                SetAccessRightsForClubMembers(entity, club);
                #endregion

                #region Access rights for the club owner (admins)
                SetFullAccessRights(entity, club.GetGroup(Enums.ClubGroupType.AdminsGroup));
                #endregion
            }
            //If entity is Blog Entry
            //If the blog entry is published on a location club, we give club admins full
            //access rights
            //else if (entity is Entry)
            //{
            //    Entry blogEntry = entity as Entry;
            //    Club location = blogEntry.GetLocation();
            //    if (location != null)
            //    {
            //        SetFullAccessRights(entity, location.GetGroup(Enums.ClubGroupType.AdminsGroup));
            //    }

            //    SetAccessRightsForCommunityMembers(entity);
            //    SetAccessRightsForAnonymousGroup(entity);

            //}
            else
            {
                #region Access rights for all the other community users.
                SetAccessRightsForCommunityMembers(entity);
                #endregion

                #region Access rights for anonymous users.
                SetAccessRightsForAnonymousGroup(entity);
                #endregion
            }

            #region Access rights for the community administrators and community moderators
            IGroup admGroup = AdministratorsGroup;
            if (admGroup != null)
            {
                SetFullAccessRights(entity, admGroup);
            }

            IGroup moderatorGroup = ModeratorsGroup;
            if (moderatorGroup != null)
            {
                SetFullAccessRights(entity, moderatorGroup);
            }

            IGroup communityAdminGroup = CommunityAdministratorsGroup;
            if (communityAdminGroup != null)
            {
                SetFullAccessRights(entity, communityAdminGroup);
            }
            #endregion

        }

        /// <summary>
        /// Set access rights for the user in the communigy members group.
        /// </summary>
        /// <param name="entity">The <see cref="FrameworkEntityStatusBase"/> to set the access rights.</param>
        private void SetAccessRightsForCommunityMembers(FrameworkEntityStatusBase entity)
        {
            #region Access rights for community members
            IGroup group = CommunityMembers;
            if (group != null)
            {
                if (entity is Blog)
                {
                    #region Set blog access rights
                    BlogAccessRights blogAccessrights = new BlogAccessRights()
                    {
                        Read = true,
                        Rate = true,
                        Comment = true,
                        CreateEntry = true

                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, blogAccessrights);
                    #endregion
                }
                else if (entity is ImageGallery)
                {
                    #region Set image gallery access rights
                    ImageGalleryAccessRights igAccessRights = new ImageGalleryAccessRights()
                    {
                        Read = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, igAccessRights);
                    #endregion
                }
                else if (entity is Video)
                {
                    #region set the video access rights
                    VideoAccessRights vAccessRights = new VideoAccessRights()
                    {
                        Read = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vAccessRights);
                    #endregion
                }
                else if (entity is VideoGallery)
                {
                    #region set the video gallery access rights
                    VideoGalleryAccessRights vAccessRights = new VideoGalleryAccessRights()
                    {
                        Read = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vAccessRights);
                    #endregion
                }
                else
                {
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, new FrameworkEntityAccessRights()
                    {
                        Read = true,
                        Rate = true,
                        Comment = true,
                        Tag = true
                    });
                }
            }
            #endregion
        }

        /// <summary>
        /// Set access rights for the club members.
        /// </summary>
        /// <param name="entity">The <see cref="FrameworkEntityStatusBase"/> to set the access rights.</param>
        /// <param name="club">The <see cref="Club"/> to grant the access rights.</param>
        private void SetAccessRightsForClubMembers(FrameworkEntityStatusBase entity, Club club)
        {
            #region Access rights for club members
            IGroup group = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(String.Format(RelateConstants.ClubGroupName, club.ID));
            if (group != null)
            {
                if (entity is Blog)
                {
                    #region Set blog access rights
                    BlogAccessRights blogAccessrights = new BlogAccessRights()
                    {
                        Read = true,
                        Tag = true,
                        Rate = true,
                        Comment = true,
                        CreateEntry = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, blogAccessrights);
                    #endregion
                }
                else if (entity is ImageGallery)
                {
                    #region Set image gallery access rights
                    ImageGalleryAccessRights igAccessRights = new ImageGalleryAccessRights()
                    {
                        Upload = true,
                        Read = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, igAccessRights);
                    #endregion
                }
                else if (entity is Video)
                {
                    #region Set video access rights
                    VideoAccessRights vAccessRights = new VideoAccessRights()
                    {
                        Read = true,
                        Comment = true,
                        Rate = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vAccessRights);
                    #endregion
                }
                else if (entity is VideoGallery)
                {
                    #region Set video gallery access rights
                    VideoGalleryAccessRights vAccessRights = new VideoGalleryAccessRights()
                    {
                        Upload = true,
                        Read = true,
                        Comment = true,
                        Rate = true,
                        Tag = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vAccessRights);
                    #endregion
                }
                else if (entity is Calendar)
                {
                    #region Set the calendar access rights
                    CalendarAccessRights calendarAccessRights = new CalendarAccessRights()
                    {
                        Read = true,
                        CreateEvent = true,
                        Rate = true,
                        Tag = true,
                        Comment = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, calendarAccessRights);
                    #endregion
                }
                else if (entity is ChildRoom)
                {
                    #region Set the forum rooom access rights.
                    RoomAccessRights roomAccessRights = new RoomAccessRights()
                    {
                        Read = true,
                        Rate = true,
                        Tag = true,
                        CreateTopic = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, roomAccessRights);
                    #endregion
                }
                else if (entity is Club)
                {
                    #region Set the club access rights
                    ClubAccessRights clubAccessRights = new ClubAccessRights()
                    {
                        Read = true,
                        Rate = true,
                        Tag = true,
                        Comment = true
                    };
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, clubAccessRights);
                    #endregion
                }
                else
                {
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, new FrameworkEntityAccessRights()
                    {
                        Read = true,
                        Rate = true,
                        Comment = true,
                        Tag = true
                    });
                }
            }
            #endregion
        }

        /// <summary>
        /// Set the access rights for the anonymous group.
        /// </summary>
        /// <param name="entity">The <see cref="FrameworkEntityStatusBase"/> to set the access rights.</param>
        public void SetAccessRightsForAnonymousGroup(FrameworkEntityStatusBase entity)
        {
            #region Set access rights for anonymous group
            if (entity is Blog)
            {
                EntitySecurityHandler.Instance.SetAccessRights(entity, this.AnonymousGroup, new BlogAccessRights()
                {
                    Read = true,
                });
            }
            else if (entity is ImageGallery)
            {
                EntitySecurityHandler.Instance.SetAccessRights(entity, this.AnonymousGroup, new ImageGalleryAccessRights()
                {
                    Read = true,
                });
            }
            else if (entity is Video)
            {
                EntitySecurityHandler.Instance.SetAccessRights(entity, this.AnonymousGroup, new VideoAccessRights()
                {
                    Read = true,
                });
            }
            else if (entity is VideoGallery)
            {
                EntitySecurityHandler.Instance.SetAccessRights(entity, this.AnonymousGroup, new VideoGalleryAccessRights()
                {
                    Read = true,
                });
            }
            else
            {
                EntitySecurityHandler.Instance.SetAccessRights(entity, this.AnonymousGroup, new FrameworkEntityAccessRights()
                {
                    Read = true,
                });
            }
            #endregion
        }

        /// <summary>
        /// Set the full access rights for user or group
        /// </summary>
        /// <remarks>
        /// The grantedEntity argument must be if time <see cref="IUser"/> or <see cref="IGroup"/>
        /// </remarks>
        /// <param name="entity">The <see cref="FrameworkEntityStatusBase"/> to set the access rights.</param>
        /// <param name="grantedEntity">The <see cref="IUser"/> or <see cref="IGroup"/> to grant access rights.</param>
        private void SetFullAccessRights(FrameworkEntityStatusBase entity, IFrameworkEntity grantedEntity)
        {
            if (!(grantedEntity is IUser) && !(grantedEntity is IGroup))
            {
                throw new FrameworkException("Access rights can only be granted to entities of type IUser and IGroup");
            }

            IUser user = (grantedEntity is IUser ? (IUser)grantedEntity : null);
            IGroup group = (grantedEntity is IGroup ? (IGroup)grantedEntity : null);

            if (user == null && group == null)
            {
                throw new FrameworkException("Couldn't find user or group to grant the access rights");
            }

            if (entity is Blog)
            {
                #region Set blog access rights
                BlogAccessRights blogAccessRights = new BlogAccessRights()
                {
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Tag = true,
                    Categorize = true,
                    Rate = true,
                    Comment = true,
                    CreateEntry = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, blogAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, blogAccessRights);
                #endregion
            }
            else if (entity is ImageGallery)
            {
                #region Set image gallery access rights
                ImageGalleryAccessRights igAccessRights = new ImageGalleryAccessRights()
                {
                    Upload = true,
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Tag = true,
                    Categorize = true,
                    Rate = true,
                    Comment = true,
                    Approve = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, igAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, igAccessRights);
                #endregion
            }
            else if (entity is Video)
            {
                #region Set video access rights
                VideoAccessRights vAccessRights = new VideoAccessRights()
                {
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Rate = true,
                    Tag = true,
                    Categorize = true,
                    Comment = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, vAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vAccessRights);
                #endregion
            }
            else if (entity is VideoGallery)
            {
                #region Set video gallery access rights
                VideoGalleryAccessRights vgAccessRights = new VideoGalleryAccessRights()
                {
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Tag = true,
                    Rate = true,
                    Comment = true,
                    Categorize = true,
                    Approve = true,
                    Upload = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, vgAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, vgAccessRights);
                #endregion
            }
            else if (entity is Club)
            {
                #region Set the club access rights
                ClubAccessRights clubAccessRights = new ClubAccessRights()
                {
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Tag = true,
                    Rate = true,
                    Comment = true,
                    Categorize = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, clubAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, clubAccessRights);
                #endregion
            }
            else if (entity is Calendar)
            {
                #region Set the Calendar access rights
                CalendarAccessRights calendarAccessRights = new CalendarAccessRights()
                {
                    Read = true,
                    ReadEvent = true,
                    Modify = true,
                    ModifyEvent = true,
                    Remove = true,
                    RemoveEvent = true,
                    Comment = true,
                    CreateEvent = true,
                    Categorize = true,
                    Rate = true,
                    Tag = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, calendarAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, calendarAccessRights);
                #endregion
            }
            else if (entity is ChildRoom)
            {
                #region Set the forum rooom access rights
                RoomAccessRights roomAccessRights = new RoomAccessRights()
                {
                    Read = true,
                    Rate = true,
                    Tag = true,
                    Announce = true,
                    Categorize = true,
                    Comment = true,
                    Lock = true,
                    Modify = true,
                    MoveTopic = true,
                    Prioritize = true,
                    Remove = true,
                    Report = true,
                    CreateTopic = true
                };
                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, roomAccessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, roomAccessRights);
                #endregion
            }
            else
            {
                FrameworkEntityAccessRights accessRights = new FrameworkEntityAccessRights()
                {
                    Read = true,
                    Modify = true,
                    Remove = true,
                    Tag = true,
                    Categorize = true,
                    Rate = true,
                    Comment = true
                };

                if (user != null)
                    EntitySecurityHandler.Instance.SetAccessRights(entity, user, accessRights);
                else
                    EntitySecurityHandler.Instance.SetAccessRights(entity, group, accessRights);
            }
        }

        /// <summary>
        /// Create a group for the club
        /// </summary>
        /// <param name="club">Created <see cref="Club"/></param>
        /// <param name="grouptype">Specify the type <see cref="Enums.ClubGroupType"/> of the group</param>
        /// <returns>The group <see cref="IGroup"/> created fot the club.</returns>
        private IGroup CreateClubGroup(Club club, Enums.ClubGroupType grouptype)
        {
            IGroup newGroup = CommunitySystem.CurrentContext.DefaultSecurity.NewGroup;
            newGroup.Name = GetClubGroupName(club, grouptype);
            return CommunitySystem.CurrentContext.DefaultSecurity.AddGroup(newGroup);
        }

        /// <summary>
        /// Get the name of the <see cref="IGroup"/> for a <see cref="Club"/>
        /// </summary>
        /// <param name="club">The <see cref="Club"/> to get the group name for.</param>
        /// <param name="groupType">The <see cref="GroupType"/> to get the club group name for</param>
        /// <returns>The group name</returns>
        public static string GetClubGroupName(Club club, Enums.ClubGroupType groupType)
        {
            String groupName = String.Empty;
            groupName = (groupType == Enums.ClubGroupType.AdminsGroup ? RelateConstants.ClubAdminGroupName: RelateConstants.ClubGroupName);
            return String.Format(groupName, club.ID);
        }

        /// <summary>
        /// Get the owner of the entity's parent
        /// </summary>
        /// <param name="parentEntity">The parent of the entity that is being created.</param>
        /// <returns>A <see cref="IEntity"/> representing the entity that owns the parent object.</returns>
        private IEntity GetParentEntityOwner(IEntity parentEntity)
        {
            IAuthor parentEntityAuthor = null;
            IEntity parentEntityOwner = null;

            if (parentEntity is Topic)
            {
                if (((Topic)parentEntity).GetBelongsToClub() != null)
                {
                    parentEntityOwner = ((Topic)parentEntity).GetBelongsToClub();
                }
                else
                {
                    parentEntityAuthor = ((Topic)parentEntity).Room.Author;
                }
            }
            else
            {
                parentEntityAuthor = (parentEntity is IContent ? ((IContent)parentEntity).Author : null);
                parentEntityOwner = ((FrameworkEntityStatusBase)parentEntity).OwnedBy.Entity;
            }

            return (parentEntityOwner != null ? parentEntityOwner : parentEntityAuthor.GetUser());
        }

        #endregion
    }
}
