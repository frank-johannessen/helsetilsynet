using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login;
using NUnit.Framework;
using Relate.HelpersAndExtensions.Helpers;

namespace Helsetilsynet.Intranet.Web.Tests
{
    [TestFixture]
    public class PasswordGenerationTests
    {
        [Test]
        public void GenerateUniquePassword_Test()
        {
            var sampleString = "Test string";
            var encrypted = Encryptor.EncryptString(sampleString);

            Console.WriteLine(encrypted);

            Assert.AreNotEqual(0, string.Compare(sampleString, encrypted));

            var decrypted = Encryptor.DecryptString(encrypted);
            Assert.AreEqual(sampleString, decrypted);
        }
    }
}
