using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using NUnit.Framework;

namespace Helsetilsynet.Intranet.Web.Tests
{
    [TestFixture]
    public class LargeDocumentChapterRegexTests
    {

        [Test]
        public void Test1()
        {
            RunRegex("1.24.3", "xxx yyy zzz");
        }

        [Test]
        public void Test2()
        {
            RunRegex("1.4", "xxx yyy zzz");
        }
        [Test]
        public void Test3()
        {
            RunRegex("1", "xxx yyy zzz");
        }
        [Test]
        public void Test4()
        {
            RunRegex("VEDLEGG 1", "xxx yyy zzz");
        }
        [Test]
        public void Test5()
        {
            RunRegex("VEDLEgg 2", "xxx yyy zzz");
        }
        [Test]
        public void Test6()
        {
            RunRegex("1", "xxx yyy zzz");
        }
        [Test]
        public void Test7()
        {
            RunRegex("1", "xxx yyy zzz");
        }
        [Test]
        public void Test8()
        {
            RunRegex("1", "xxx yyy zzz");
        }
        private static void RunRegex(string expectedNum, string expectedTitle)
        {
            string input = expectedNum + " " + expectedTitle;

            var match = Regex.Match(input, @"(?<number>(((\d\.)*\d)+)|vedlegg\s+\d)\s+(?<title>.+)", RegexOptions.IgnoreCase);

            if (!match.Success)
            {
                Console.WriteLine("NOT SUCCESS");
                Assert.Fail("No match");
            }

            var numberPart = match.Groups["number"].Value;
            var titlePart = match.Groups["title"].Value;


            Console.WriteLine("NUMBER PART:" + numberPart);
            Console.WriteLine("TITLE PART:" + titlePart);

            Assert.AreEqual(expectedNum,numberPart);
            Assert.AreEqual(expectedTitle, titlePart);

            
        }
    }
}
