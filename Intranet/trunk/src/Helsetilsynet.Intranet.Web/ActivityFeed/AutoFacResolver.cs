using Autofac;
using OpenWaves;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class AutoFacResolver : IResolver
    {
        private readonly IContainer _container;

        public AutoFacResolver(IContainer container)
        {
            _container = container;
        }

        public bool TryResolve<T>(out T service) where T : class
        {
            service = _container.ResolveOptional<T>();
            return service != null;
        }
    }
}