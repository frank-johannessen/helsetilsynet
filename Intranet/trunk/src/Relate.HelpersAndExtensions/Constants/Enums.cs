namespace Relate.HelpersAndExtensions.Constants
{
    public class Enums
    {
        /// <summary>
        /// Used when creating images
        /// Current implementation gives the following sizes:
        /// Tiny = 35 x 35
        /// Small = 50 x 50
        /// NewsfeedImg = 54 x 54
        /// Medium = 60 x 60
        /// Large = 90 x 90
        /// Huge = 120 x 120
        /// Portrait = 200 x 200
        /// </summary>
        public enum ImageSize : byte
        {
            Tiny,
            Small,
            NewsFeed,
            Medium,
            Large,
            Huge,
            Portrait
        }
        public enum ClubGroupType
        {
            MembersGroup,
            AdminsGroup
        }
    }
}
