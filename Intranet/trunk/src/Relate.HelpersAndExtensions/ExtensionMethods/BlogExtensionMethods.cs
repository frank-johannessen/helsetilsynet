using System;
using System.Text;
using EPiServer;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community.Blog;
using EPiServer.Community.Club;
using EPiServer.Web;
using PageTypeBuilder;
using Relate.HelpersAndExtensions.Constants;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class BlogExtensionMethods
    {
        /// <summary>
        /// Gets the presentation image for a blog and falls back on the portrait image of the user
        /// if no presentation images is set.
        /// </summary>
        /// <param name="blog">The blog to get presentation image for</param>
        /// <param name="size">The size of the image</param>
        /// <returns>The uri to the image</returns>
        public static Uri GetPresentationImageUri(this Blog blog, Enums.ImageSize size)
        {
            return blog.PresentationImage != null ? blog.PresentationImage.GetThumbnailUri(size) : blog.Author.GetActionValueFromUserOrDefault(null, user => user.GetPortraitUri(size));
        }

        /// <summary>
        /// Gets the url to a blog
        /// </summary>
        /// <param name="blog">The blog to get url for</param>
        /// <returns>The uri to the blog</returns>
        public static Uri GetBlogUri(this Blog blog)
        {
            var user = blog.Author.GetUser();
            if (blog == null || user == null)
            {
                return null;
            }

            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MyBlogPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.UserID, user.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.MyBlogPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the url to a blog entry
        /// </summary>
        /// <param name="entry">The entry to get url for</param>
        /// <returns>The uri to the entry</returns>
        public static Uri GetEntryUri(this Entry entry)
        {
            if (entry == null || entry.Blog == null)
            {
                return null;
            }

            if (entry.Blog.OwnedBy != null && entry.Blog.OwnedBy.Entity is Club && entry.Blog.OwnedBy.Context == "MessageBlog")
            {
                var club = (Club)entry.Blog.OwnedBy.Entity;
                var clubUri = club.GetClubWallUri();

                if (clubUri == null)
                    return null;

                var url = new UrlBuilder(clubUri);
                url.QueryCollection.Add(QueryStrings.EntryID, entry.ID.ToString());
                return url.Uri;
            }
            else
            {
                var blogUri = entry.Blog.GetBlogUri();

                if (blogUri == null)
                    return null;

                var url = new UrlBuilder(blogUri);
                url.QueryCollection.Add(QueryStrings.EntryID, entry.ID.ToString());
                return url.Uri;
            }
        }


        /// <summary>
        /// Determines whether entry is belong to user. 
        /// If entry is created in relateplus, its author will be used check.
        /// If entry is syndicated from RSS source, its author will be GuestAuthor, we need to check through entry.Blog.Author
        /// </summary>
        /// <param name="entry">The entry.</param>
        /// <param name="user">The user</param>
        /// <returns></returns>
        public static bool BelongsToUser(this Entry entry, IUser user)
        {
            var isOwner = false;

            IAuthor entryAuthor;
            if (entry.Author is GuestAuthor)
            {
                entryAuthor = entry.Blog.Author;
            }
            else
            {
                entryAuthor = entry.Author;
            }

            if (user.CompareUserId(entryAuthor))
            {
                isOwner = true;
            }
            return isOwner;
        }

        public static Club GetClub(this Entry entry)
        {
            if (entry.Blog.OwnedBy != null && entry.Blog.OwnedBy.Entity != null)
            {
                if (entry.Blog.OwnedBy.Entity.GetType() == typeof(Club))
                {
                    return (Club)entry.Blog.OwnedBy.Entity;
                }
            }
            return null;
        }
    }
}
