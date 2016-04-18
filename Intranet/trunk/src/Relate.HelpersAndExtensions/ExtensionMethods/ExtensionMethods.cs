using System;
using System.Web.UI.WebControls;
using EPiServer.Common;
using EPiServer.Common.Data;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Common.Tags;
using EPiServer.Community.Blog;
using EPiServer.Community.Club;
using EPiServer.Community.ImageGallery;
using EPiServer.Community.MyPage;
using EPiServer.Community.VideoGallery;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;
using Image = EPiServer.Community.ImageGallery.Image;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class ExtensionMethods
    {
        #region FileUpload extensions
        /// <summary>
        /// Upload Community Images
        /// </summary>
        /// <param name="fileInput">The file input.</param>
        /// <param name="title">The title.</param>
        /// <param name="description">The description.</param>
        /// <param name="imageGallery">The image gallery.</param>
        /// <param name="publishedState">State of the published.</param>
        /// <param name="uploader">The uploader.</param>
        /// <param name="tags">The tags.</param>
        /// <returns>Image</returns>
        public static Image ImageUpload(this FileUpload fileInput, string title, string description, ImageGallery imageGallery, EntityStatus status, IUser uploader, TagCollection tags, string languageID)
        {
            using (fileInput.PostedFile.InputStream)
            {
                // Create a EPiServer.Community image and set the presentation name of the user as name of image

                var imageName = String.IsNullOrEmpty(title) ? fileInput.FileName.Substring(0, fileInput.FileName.LastIndexOf(".")) : title;

                var newImage = new Image(imageGallery, imageName, description, AuthorHandler.Instance.ChangeAuthor(null, new UserAuthor(uploader)),
                                                                                                   fileInput.PostedFile.InputStream)
                                                                      {
                                                                          Status = status,
                                                                          LanguageID = languageID
                                                                      };

                try
                {
                    // Add the image to the system
                    newImage = ImageGalleryHandler.Instance.AddImage(newImage);
                }
                catch (FrameworkException)
                {
                    // catch eventual exceptions due to incorrect formats and such
                    newImage = null;
                }

                return newImage;
            }
        }
        #endregion

        public static bool IsDepartmentGroup(this IGroup group)
        {
            return group.GetAttributeValue<bool>(AttributeNames.IsDepartmentGroup);
        }

        /// <summary>
        /// Gets the entity from GUID.
        /// </summary>
        /// <typeparam name="TEntity">The type of the Community entity.</typeparam>
        /// <param name="guid">The GUID (return from Search IndexResponseItem)</param>
        /// <returns>acutual entity in TEntity type</returns>
        public static TEntity GetEntityFromGuid<TEntity>(this Guid guid)
        {
            var entityRef = EntityProviderHandler.Instance.GetEntityReference(guid);
            if (entityRef != null)
            {
                return (TEntity)entityRef.GetEntity();
            }
            return default(TEntity);
        }
        /// <summary>
        /// Get the <see cref="IUser"/> that owns a specific <see cref="FrameworkEntityStatusBase"/> 
        /// </summary>
        /// <param name="entity">The entity to get the owner.</param>
        /// <param name="parentEntityOwner">The entity's parent object.</param>
        /// <param name="club">It will set the club if the entity is owned by a club.</param>
        /// <param name="mypage">It will set the mypage if the entity is owned by a mypage</param>
        /// <returns>A <see cref="IUser"/> that owns the entity.</returns>
        public static IUser GetEntityUserOwner(this FrameworkEntityStatusBase entity, IEntity parentEntityOwner, out Club club, out MyPage mypage)
        {
            club = null;
            mypage = null;

            if (parentEntityOwner != null && !(parentEntityOwner is IUser))
            {
                if (parentEntityOwner is MyPage)
                {
                    mypage = (MyPage)parentEntityOwner;
                    return ((MyPage)parentEntityOwner).User;
                }
                if (parentEntityOwner is Club)
                {
                    club = (Club)parentEntityOwner;
                    return club.Owner;
                }
                if (parentEntityOwner is Blog)
                {
                    if (((Blog)parentEntityOwner).OwnedBy.Entity is MyPage)
                    {
                        return ((MyPage)((Blog)parentEntityOwner).OwnedBy.Entity).User;
                    }
                    if (((Blog)parentEntityOwner).OwnedBy.Entity is Club)
                    {
                        club = (Club)((Blog)parentEntityOwner).OwnedBy.Entity;
                        return club.Owner;
                    }
                    return ((Blog)parentEntityOwner).Author.GetUser();
                }
                if (parentEntityOwner is Image)
                {
                    return ((Image)parentEntityOwner).Author.GetUser();
                }
                if (parentEntityOwner is Video)
                {
                    return ((Video)parentEntityOwner).Author.GetUser();
                }
            }

            return (parentEntityOwner is IUser ? (IUser)parentEntityOwner : null);

        }
    }
}
