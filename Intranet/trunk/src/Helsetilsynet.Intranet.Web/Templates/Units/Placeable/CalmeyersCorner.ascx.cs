using System;
using System.Configuration;
using System.Linq;
using EPiServer.Common;
using EPiServer.Common.Content;
using EPiServer.Community.Club;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class CalmeyersCorner : RelateUserControlBase<Model.BasePage>
    {
        public static readonly Club CalmeyersCornerClub = ClubHandler.Instance.GetClub(int.Parse(ConfigurationManager.AppSettings[GlobalName.AppSettings.CalmeyersCornerClubId]));
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = CurrentUser.IsMemberOfClubGroup(CalmeyersCornerClub, Enums.ClubGroupType.MembersGroup);

            int totalNews;
            var entryCollection = CalmeyersCornerClub.NewsBlog.GetNewsWithQuery(1, 3, out totalNews);
            var calendarCollection = CalmeyersCornerClub.Calendar.GetCalendarEvents(1, 3);
            
            var returnList = entryCollection.Select(entry => new CalmayerCornerItem(entry)).ToList();
            returnList.AddRange(calendarCollection.Select(calendarEvent => new CalmayerCornerItem(calendarEvent)));
            
            lvNews.DataSource = returnList.OrderByDescending(o => o.PublicationDate).Take(3);
            lvNews.DataBind();
        }
    }
    public class CalmayerCornerItem
    {
        public string Header { get; set; }
        public string Body { get; set; }
        public DateTime PublicationDate { get; set; }
        public IAuthor Author { get; set; }
        public string Link { get; set; }

        public CalmayerCornerItem(IContent entity)
        {
            Header = entity.Header;
            Body = entity.Body;
            PublicationDate = entity.Created;
            Author = entity.Author;
            Link = string.Format("{0}#anchorNavBlogEntry{1}", CalmeyersCorner.CalmeyersCornerClub.GetClubUri(), entity.ID);
        }
    }
}