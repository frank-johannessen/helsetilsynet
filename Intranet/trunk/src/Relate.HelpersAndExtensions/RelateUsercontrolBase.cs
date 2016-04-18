using System;
using System.Configuration;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.Web;
using PageTypeBuilder;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace Relate.HelpersAndExtensions
{
    public class RelateUserControlBase<T> : UserControlBase<T> where T : TypedPageData
    {
#region htil specific
        protected string GetErrorMessage(string languageKey)
        {
            string errorMessage = Translate(languageKey);
            //string imagePath = VirtualPathUtilityEx.ToAbsolute("~/Templates/RelatePlus/Styles/Images/icons/report.png");
            //return String.Format("<img src=\"{0}\" alt=\"{1}\" /> {2}", imagePath, errorMessage, errorMessage);
            return errorMessage;
        }
        private Club _currentClub;
        public Club CurrentClub
        {
            get
            {
                if (_currentClub == null)
                {
                    // The id 
                    int currentClubId;

                    // Get the club to display
                    int.TryParse(Request.QueryString[QueryStrings.ClubID], out currentClubId);

                    // Get the current club
                    _currentClub = ClubHandler.Instance.GetClub(currentClubId);
                }

                return _currentClub;
            }
            set
            {
                _currentClub = value;
            }
        }
#endregion

        /// <summary>
        /// The current logged in user
        /// </summary>
        private IUser _currentUser;

        /// <summary>
        /// The user that owns the page we are looking at
        /// </summary>
        private IUser _displayUser;


        /// <summary>
        /// Gets the current user in the form of a IUser interface
        /// </summary>
        public IUser CurrentUser
        {
            get
            {
                if (_currentUser != null)
                    return _currentUser;

                _currentUser = CommunitySystem.CurrentContext.DefaultSecurity.CurrentUser;

                #region Helsetilsynet specific

                if (_currentUser == null && IsGoogleMiniIP())
                {
                    var username = ConfigurationManager.AppSettings["GoogleMini.UserAccountName"];
                    var password = ConfigurationManager.AppSettings["GoogleMini.UserAccountPassword"];

                    IUser user;
                    SecurityHandler.Instance.AuthenticateUser(username, password, out user);
                    if (user != null)
                        _currentUser = user;
                }

                #endregion

                return _currentUser;
            }
        }

        #region Helsetilsynet specific
        private bool IsGoogleMiniIP()
        {
            return Request.UserHostAddress == ConfigurationManager.AppSettings["GoogleMini.HostAddress"];
        }
        #endregion

        /// <summary>
        /// Gets or sets the user to display data from
        /// </summary>
        public IUser DisplayUser
        {
            get
            {
                if (_displayUser == null)
                {
                    // Get the user id from the query string
                    int userId;
                    string s = Request.QueryString[QueryStrings.UserID];

                    bool ok = int.TryParse(s, out userId);

                    if (ok)
                        return CommunitySystem.CurrentContext.DefaultSecurity.GetUser(userId);
                    else
                        return CurrentUser;
                }

                return _displayUser;
            }
        }
        
        private IEntity _defaultTarget;
        public IEntity DefaultTarget
        {
            get {
                return _defaultTarget ??
                       (_defaultTarget =
                        SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityMembersGroupName) ??
                        SecurityHandler.Instance.AddGroup(new Group(RelateConstants.CommunityMembersGroupName)));
            }
        }

        /// <summary>
        /// Gets whether the logged in user is part of the administrator group
        /// </summary>
        public bool IsAdminOrModerator
        {
            get
            {
                // If there is user that is logged in check that user
                if (CurrentUser != null)
                {
                    // Go through the groups of the current user and see if the administrator group is among these
                    GroupCollection groups = CurrentUser.Groups;
                    foreach (Group group in groups)
                    {
                        if (group.Name == RelateConstants.AdministratorGroupName ||
                            group.Name == RelateConstants.CommunityAdminsGroupName ||
                            group.Name == RelateConstants.CommunityModeratorGroupName)
                        {
                            return true;
                        }
                    }
                }
                return false;
            }
        }
        
        /// <summary>
        /// Checks if the supplied user is the same user as the current logged in user.
        /// </summary>
        /// <param name="objectOwner">The user that owns the object</param>
        /// <returns>True if the current logged in user is owner</returns>
        protected bool IsLoggedInUser(IUser objectOwner)
        {
            var isOwner = CurrentUser != null && objectOwner != null && objectOwner.ID == CurrentUser.ID;

            // If there exists a current user

            return isOwner;
        }


        /// <summary>
        /// Checks if the supplied user is the same user as the current logged in user.
        /// </summary>
        /// <param name="objectAuthor">The author of the object</param>
        /// <returns>True if the current logged in user is author</returns>
        protected bool IsLoggedInUser(IAuthor objectAuthor)
        {
            var isOwner = false;

            var user = objectAuthor.GetUser();

            // If there exists a current user
            if (user != null && IsLoggedInUser(user))
            {
                isOwner = true;
            }

            return isOwner;
        }

        ///// <summary>
        ///// Checks if the current user is member of administrator group or
        ///// the same user as the owner
        ///// </summary>
        ///// <param name="objectOwner">The user that owns the object</param>
        ///// <returns>True if the current logged in user is admin or owner</returns>
        //protected bool IsCurrentUserAdminOrOwner(IUser objectOwner)
        //{
        //    var isAdminOrOwner = IsLoggedInUser(objectOwner) || IsAdminOrModerator;
        //    // If there exists a current user

        //    return isAdminOrOwner;
        //}

        /// <summary>
        /// Checks if the current user is member of administrator group or
        /// the same user as the owner
        /// </summary>
        /// <param name="objectOwner">The user that owns the object</param>
        /// <returns>True if the current logged in user is admin or owner</returns>
        protected bool IsCurrentUserAdminOrOwner(ISecurableEntity entity)
        {
            return CurrentUser.IsAdmin() || HasRemoveAccessRights(entity);
        }

        ///// <summary>
        ///// Checks if the current user is member of administrator group or
        ///// the same user as the owner
        ///// </summary>
        ///// <param name="objectAuthor">The author of the object</param>
        ///// <returns>True if the current logged in user is admin or author</returns>
        //protected bool IsCurrentUserAdminOrOwner(IAuthor objectAuthor)
        //{
        //    var isAdminOrOwner = false;

        //    var userAuthor = objectAuthor as UserAuthor;

        //    // If there exists a current user
        //    if (userAuthor != null && IsCurrentUserAdminOrOwner(userAuthor.User))
        //    {
        //        isAdminOrOwner = true;
        //    }

        //    return isAdminOrOwner;
        //}


        /// <summary>
        /// Check if the current user has access rights to remove an entity.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns>
        /// 	<c>true</c> if [has remove access rights] [the specified entity]; otherwise, <c>false</c>.
        /// </returns>
        protected virtual bool HasRemoveAccessRights(ISecurableEntity entity)
        {
            if (entity == null)
            {
                return false;
            }

            if (IsAdminOrModerator)
            {
                return true;
            }
            var entryAccessRights = new FrameworkEntityAccessRights {Remove = true};
            return CurrentUser.CheckAccess(entity, entryAccessRights);
        }
        
        protected virtual bool HasGlobalModerationRights()
        {
            return CurrentUser != null && CurrentUser.IsAdmin();
        }

    }
}
