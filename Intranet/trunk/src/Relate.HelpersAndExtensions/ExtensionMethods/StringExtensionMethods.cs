using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using EPiServer.HtmlParsing;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class StringExtensionMethods
    {
        public static string FormatContentTextNoHtml(this string text)
        {
            if (String.IsNullOrEmpty(text))
            {
                return String.Empty;
            }

            var sb = new StringBuilder();
            var hsr = new HtmlStreamReader(text);

            foreach (var fragment in (from f in hsr where f.FragmentType == HtmlFragmentType.Text select f))
            {
                if (sb.Length > 0)
                {
                    sb.Append(" ");
                }
                sb.Append(fragment.Value);
            }

            return sb.ToString();
        }

        /// <summary>
        /// Trims the string to the supplied max lenth and adds trailing "..."
        /// </summary>
        /// <param name="text">The text to trim</param>
        /// <param name="maxLength">The max length of the string</param>
        /// <returns>The trimed string</returns>
        public static string Crop(this string text, int maxLength)
        {
            if (String.IsNullOrEmpty(text))
            {
                return String.Empty;
            }

            return text.Length <= maxLength ? text : String.Format("{0}...", text.Substring(0, maxLength));
        }

        /// <summary>
        /// Trims the text to fit in maximum, but splitting at a space (if possible)
        /// </summary>
        /// <param name="text">The input text</param>
        /// <param name="numberOfChars">The maximum length of the output</param>
        /// <param name="wasCropped">False if the input text is returned as is</param>
        /// <returns></returns>
        public static string CropText(this string text, int numberOfChars, out bool wasCropped)
        {
            wasCropped = false;

            if (string.IsNullOrEmpty(text))
                return string.Empty;

            if (text.Length <= numberOfChars)
                return text;

            wasCropped = true;

            var cropped = text.Substring(0, numberOfChars);
            if (text[cropped.Length] == ' ')
                return cropped;

            var foundSpace = cropped.LastIndexOf(' ');
            if (foundSpace > 0)
                return cropped.Substring(0, foundSpace);

            return cropped;
        }        
        
        public static string CropText(this string text, int numberOfChars)
        {
            bool wasCropped;
            return text.CropText(numberOfChars, out wasCropped);
        }
        public static bool ValidImageFile(this string filename)
        {
            string extension = Path.GetExtension(filename);
            const string validImageFormats = "jpg,png,jpeg,gif";
            return (!String.IsNullOrEmpty(extension) && validImageFormats.Contains(extension.ToLower().Trim('.')));
        }
    }
}
