using MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini;
using NUnit.Framework;

namespace Helsetilsynet.Intranet.Web.Tests
{
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class ConfigurationTests
    {
        [Test]
        public void GsaClientAccess_ShouldNotReturnNull()
        {
            var clientAccess = Configuration.ClientAccess;
            Assert.NotNull(clientAccess);
        }

        [Test]
        public void GsaClientAccess_ShouldNotReturnCorrectAddressFromConfig()
        {
            var clientAccess = Configuration.ClientAccess;
            
            // Depends on settings in config
            Assert.AreEqual("http://195.225.30.29", clientAccess.GSAHostAddress);
		    
        }
    }
    // ReSharper restore InconsistentNaming
}
