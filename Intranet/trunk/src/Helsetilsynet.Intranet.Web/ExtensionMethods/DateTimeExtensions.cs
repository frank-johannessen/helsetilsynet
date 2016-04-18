using System;
using EPiServer;
using EPiServer.Core;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class DateTimeExtensions
    {
        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToLongDateString(this DateTime? dateTime)
        {
            return FormatDateTime(dateTime, "/time/longdatepattern");
        }

        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToLongDateString(this DateTime dateTime)
        {
            return FormatDateTime(dateTime, "/time/longdatepattern");
        }

        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToShortDateString(this DateTime? dateTime)
        {
            return FormatDateTime(dateTime, "/time/shortdatepattern");
        }

        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToShortDateString(this DateTime dateTime)
        {
            return FormatDateTime(dateTime, "/time/shortdatepattern");
        }


        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToShortTimeString(this DateTime? dateTime)
        {
            return FormatDateTime(dateTime, "/time/shorttimepattern");
        }

        /// <summary>
        /// Returns date based on formatting specified in the EPiServer language file. Returns "" if dateTime is null
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static string FormatToShortTimeString(this DateTime dateTime)
        {
            return FormatDateTime(dateTime, "/time/shorttimepattern");
        }

        
        private static string FormatDateTime(DateTime? dateTime, string langKey)
        {
            var format = LanguageManager.Instance.Translate(langKey);
            return dateTime.HasValue ? dateTime.Value.ToString(format) : "";
        }

        private static string FormatDateTime(DateTime dateTime, string langKey)
        {
            var format = LanguageManager.Instance.Translate(langKey);
            return dateTime.ToString(format);
        }


        public static string ToHumanDateString(this DateTime dateTime
            , string formatWithoutYear = "dd. MMMM"
            , string formatWithYear = "dd. MMMM yyyy"
            , string yesterday = "i går, "
            , string today = "i dag, "
            , string tomorrow = "i morgen, "
            )
        {
            var prefix = string.Empty;
            var format = formatWithoutYear;

            if (dateTime.Date == DateTime.Today.Date)
                prefix = today;
            if (dateTime.Date == DateTime.Today.AddDays(-1).Date)
                prefix = yesterday;
            if (dateTime.Date == DateTime.Today.AddDays(1).Date)
                prefix = tomorrow;

            if (dateTime.Year != DateTime.Today.Year)
                format = formatWithYear;

            return prefix + dateTime.ToString(format);
        }
    }
}