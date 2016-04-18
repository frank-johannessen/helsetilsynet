using System;
using EPiServer.Common.Queries;
using EPiServer.Common.Sorting;
using EPiServer.Community.Club;
using EPiServer.Community.Club.Queries;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class ClubListPage : RelateTemplatePage<Model.ClubListPage>
    {
        private const int PageSize = 50;
        private int totalItems;

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "groups-and-persons projects";

            lvClubs.DataSource = GetAllClubs();
            lvClubs.DataBind();

            btnCreateClub.Visible = ShowAddBtn();

            BindPager();
        }

        private void BindPager()
        {
            pager.BindPagerControl(PageSize, totalItems);
        }

        public ClubCollection GetAllClubs()
        {
            return QueryHandler.Instance.GetQueryResult<Club, ClubCollection>(GetAllClubsQuery(), TimeSpan.FromMinutes(1), pager.CurrentPagingNumber, PageSize, out totalItems);
        }

        private ClubQuery GetAllClubsQuery()
        {
            var clubQuery = new ClubQuery();
            var criteriaGroup = new CriteriaGroup();

            clubQuery.Header = new StringCriterion();
            clubQuery.IsHidden = new BooleanCriterion {Value = false};
            clubQuery.SecurityStatus = new SecurityStatusCriterion {Value = SecurityStatus.Open};
            criteriaGroup.AddCriterion(clubQuery.SecurityStatus);

            clubQuery.Members = new MembershipCollectionCriterion
                                    {
                                        Containing =
                                            new MembershipCriterion
                                                {User = new UserCriterion {ID = new IntegerCriterion {Value = CurrentUser.ID}}}
                                    };

            criteriaGroup.AddCriterion(LogicalOperator.Or, clubQuery.Members);
            clubQuery.AddCriteriaGroup(criteriaGroup);

            clubQuery.OrderBy.Add(new CriterionSortOrder(clubQuery.Header, SortingDirection.Ascending));
            return clubQuery;
        }

        protected void btnCreateClub_OnClick(object sender, EventArgs e)
        {
            ucAddNewClub.Visible = true;
            ucAddNewClub.DataBind();
        }

        protected bool ShowAddBtn()
        {
            return CurrentUser.IsAdmin() || CurrentPage.LetUsersAddProjectrooms;
        }
    }
}