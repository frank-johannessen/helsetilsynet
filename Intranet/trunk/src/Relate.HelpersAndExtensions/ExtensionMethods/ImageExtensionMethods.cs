using System;
using System.Drawing;
using System.Text;
using EPiServer;
using EPiServer.Common;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.Community.ImageGallery;
using EPiServer.Web;
using PageTypeBuilder;
using Relate.HelpersAndExtensions.Constants;
using Image = EPiServer.Community.ImageGallery.Image;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class ImageExtensionMethods
    {
        #region Image extensions
        /// <summary>
        /// Gets the url for a image thumbnail
        /// </summary>
        /// <param name="image">The image to get the url for</param>
        /// <param name="imageSize">The size of the image to get the url for</param>
        /// <returns>The uri to the image thumbnail</returns>
        public static Uri GetThumbnailUri(this Image image, Enums.ImageSize imageSize)
        {
            // Get the size from enum;
            var size = GetImageSize(imageSize);
            if (image != null)
            {
                try
                {
                    var thumb = ImageGalleryHandler.Instance.GetThumbnail(image, size.Width, size.Height, ThumbnailFormat.ReduceAndCrop, true, null, Color.White);
                    if (thumb != null)
                    {
                        return new UrlBuilder(thumb.Url).Uri;
                    }
                }
                catch (Exception)
                {

                }

            }
            var imageUrl = RelateConstants.PathToRelateImagesFolder;
            var url = new UrlBuilder(UriSupport.Combine(imageUrl, String.Format("/noThumbnail{0}.png", GetSizeName(imageSize))));
            return url.Uri;
        }

        /// <summary>
        /// Gets the URL for a proportional Image size
        /// </summary>
        /// <param name="image">The Image to get the URL for</param>
        /// <param name="width">The max width of the image to get the URL for</param>
        /// <param name="height">The max height of the image to get the URL for</param>
        /// <returns>The Uri to the image thumbnail</returns>
        public static Uri GetProportionalUri(this Image image, int width, int height)
        {
            try
            {
                return new UrlBuilder(ImageGalleryHandler.Instance.GetThumbnail(image, width, height, ThumbnailFormat.Proportional).Url).Uri;
            }
            catch (Exception)
            {
                //Image does not exist on the server
                var imageUrl = RelateConstants.PathToRelateImagesFolder+ "/noThumbnail.png";
                var url = new UrlBuilder(imageUrl);
                return url.Uri;
            }
        }


        /// <summary>
        /// Gets the view image URL.
        /// </summary>
        /// <param name="image">The img.</param>
        /// <param name="index">The index of the image in the collection</param>
        /// <returns>The Uri to the view image page</returns>
        public static Uri GetViewImageUri(this Image image, int index)
        {

            var url = new UrlBuilder("");

            var club = image.ImageGallery.GetBelongsToClub();

            // Check if the image belongs to a club
            if (club != null)
            {
                // Set the url to the club gallery 
                url = new UrlBuilder(club.GetClubImageGalleryUri());
            }
            else
            {
                // Set the URL to viewimage page
                //url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ViewImagePage.LinkURL);
            }

            url.QueryCollection.Add(QueryStrings.ImageGalleryID, image.ImageGallery.ID.ToString());
            url.QueryCollection.Add(QueryStrings.ImageID, image.ID.ToString());

            if (index != -1)
            {
                url.QueryCollection.Add(QueryStrings.Index, index.ToString());
            }

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, url.Uri, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Sets the "belongs to club" attribute
        /// </summary>
        /// <param name="imageGallery">The imagegallery.</param>
        /// <param name="club">The club.</param>
        public static void SetBelongsToClub(this ImageGallery imageGallery, Club club)
        {
            ImageGallery imageGalleryClone = (ImageGallery)imageGallery.Clone();
            try
            {
                imageGalleryClone.SetAttributeValue(AttributeNames.BelongsToClub, club);
            }
            catch (FrameworkException)
            {
                // Attribute does not exist, so we can't set it.
            }

            ImageGalleryHandler.Instance.UpdateImageGallery(imageGalleryClone);
        }

        /// <summary>
        /// Gets the "belongs to club" attribute.
        /// </summary>
        /// <param name="imageGallery">The imageGallery.</param>
        /// <returns>The club this image gallery belongs to, null if it doesn't belong to a club</returns>
        public static Club GetBelongsToClub(this ImageGallery imageGallery)
        {
            try
            {
                return imageGallery.GetAttributeValue<Club>(AttributeNames.BelongsToClub);
            }
            catch (FrameworkException)
            {
                return null;
            }
        }
        #endregion

        #region ImageGallery extensions
        /// <summary>
        /// Gets the owner for a image gallery
        /// </summary>
        /// <param name="imageGallery">The image gallery to get owner for</param>
        /// <returns>The owner attribute</returns>
        public static IUser GetOwner(this ImageGallery imageGallery)
        {
            try
            {
                return imageGallery.GetAttributeValue<IUser>(AttributeNames.Owner);
            }
            catch (FrameworkException)
            {
                return null;
            }
        }

        /// <summary>
        /// Sets the msn id for the supplied user
        /// </summary>
        /// <param name="imageGallery">The image gallery to set owner for</param>
        /// <param name="owner">The owner of the image gallery</param>
        public static void SetOwner(this ImageGallery imageGallery, IUser owner)
        {
            imageGallery.SetAttributeValue(AttributeNames.Owner, owner);
        }

        /// <summary>
        /// Determines whether the specified image gallery is public.
        /// </summary>
        /// <param name="imageGallery">The image gallery.</param>
        /// <returns>
        /// 	<c>true</c> if the specified image gallery is public; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsPublic(this ImageGallery imageGallery)
        {
            try
            {
                return imageGallery.GetAttributeValue<bool>(AttributeNames.IsPublic);
            }
            catch (FrameworkException)
            {
                // The attribute IsPublic does not exists, so let's default to false.
                return false;
            }
        }

        /// <summary>
        /// Gets the image gallery URL.
        /// </summary>
        /// <param name="imageGallery">The image gallery.</param>
        /// <returns>The Uri to image galleries</returns>
        public static Uri GetImageGalleryUri(this ImageGallery imageGallery)
        {
            // Set default URL to users imagegallery
            UrlBuilder url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MyImagesPage.LinkURL);

            Club club = imageGallery.GetBelongsToClub();
            // check if the Imagegallery belongs to club
            if (club != null)
            {
                IUser currentUser = CommunitySystem.CurrentContext.DefaultSecurity.CurrentUser;
                // Need to be authenticated to see club content
                if (currentUser != null)
                {
                    // Belongs to club, check if currentuser is member of the club or administrator
                    if (club.IsClubMember(currentUser) || currentUser.IsAdmin())
                    {
                        // Members have right to acces the imagegallery
                        // Set the URL to the club imagegallery
                        url = new UrlBuilder(club.GetClubImageGalleryUri());
                    }
                }
                else
                {
                    // Return link to the club instead
                    return club.GetClubUri();
                }
            }

            // Add image gallery id to the querycollection
            url.QueryCollection.Add(QueryStrings.ImageGalleryID, imageGallery.ID.ToString());

            if (imageGallery.GetOwner() != null)
            {
                url.QueryCollection.Add(QueryStrings.UserID, imageGallery.GetOwner().ID.ToString());
            }

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, url.Uri, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets my image gallery URL.
        /// </summary>
        /// <param name="imageGallery">The image gallery.</param>
        /// <param name="owner">The owner.</param>
        /// <returns>The Uri to My Image Galleries</returns>
        public static Uri GetMyImageGalleryUri(this ImageGallery imageGallery, IUser owner)
        {
            if (imageGallery == null)
            {
                return null;
            }
            UrlBuilder url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MyImageGalleryPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.UserID, owner.ID.ToString());
            url.QueryCollection.Add(QueryStrings.ImageGalleryID, imageGallery.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.MyImageGalleryPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the presentation image URI for an image gallery.
        /// </summary>
        /// <param name="imageGallery">The image gallery.</param>
        /// <returns>The Uri to the image</returns>
        public static Uri GetPresentationImageUri(this ImageGallery imageGallery)
        {
            // If there is at least one published image, use that one
            if (imageGallery.NumOfImagesPublished > 0)
            {
                ImageSortOrder imageSortOrder = new ImageSortOrder(ImageSortField.Created, SortingDirection.Descending);

                int totalCount;
                Image image = ImageGalleryHandler.Instance.GetImages(new ImageGalleryCollection { imageGallery },
                    1, 1, EntityStatus.Approved, out totalCount, imageSortOrder)[0];

                return image.GetThumbnailUri(Enums.ImageSize.Portrait);
            }

            UrlBuilder url = new UrlBuilder(string.Format("{0}/{1}", RelateConstants.PathToRelateImagesFolder, Enums.ImageSize.Small));

            return url.Uri;
        }
        #endregion

        public static string GetSizeName(Enums.ImageSize imgSize)
        {
            string size;
            switch (imgSize)
            {
                case Enums.ImageSize.Tiny:
                    size = "_tiny";
                    break;
                case Enums.ImageSize.NewsFeed:
                case Enums.ImageSize.Small:
                    size = "_small";
                    break;
                case Enums.ImageSize.Medium:
                    size = "_medium";
                    break;
                case Enums.ImageSize.Large:
                    size = "_large";
                    break;
                case Enums.ImageSize.Huge:
                    size = "_huge";
                    break;
                case Enums.ImageSize.Portrait:
                    size = "_portrait";
                    break;
                default:
                    size = String.Empty;
                    break;
            }
            return size;
        }

        /// <summary>
        /// Gets the size of the image.
        /// </summary>
        /// <param name="imageSize">Size of the image.</param>
        /// <returns>The image size</returns>
        public static Size GetImageSize(Enums.ImageSize imageSize)
        {
            var size = new Size();
            switch (imageSize)
            {
                case Enums.ImageSize.Tiny:
                    size = new Size(35, 35);
                    break;
                case Enums.ImageSize.Small:
                    size = new Size(50, 50);
                    break;
                case Enums.ImageSize.NewsFeed:
                    size = new Size(54, 54);
                    break;
                case Enums.ImageSize.Medium:
                    size = new Size(60, 60);
                    break;
                case Enums.ImageSize.Large:
                    size = new Size(90, 90);
                    break;
                case Enums.ImageSize.Huge:
                    size = new Size(120, 120);
                    break;
                case Enums.ImageSize.Portrait:
                    size = new Size(200, 200);
                    break;
            }

            return size;
        }
    }
}
