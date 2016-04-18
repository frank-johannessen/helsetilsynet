using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MakingWaves.Common.Caching;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util
{
    /// <summary>
    /// Wrapper of <see cref="Cache{T}"/>. Enables caching of value types
    /// </summary>
    /// <typeparam name="K">The key used to identify the cached item. ToString() is called to get the key</typeparam>
    /// <typeparam name="T">The cached item.</typeparam>
    public class SimpleCache<T>
    {
        private ICacheImplementation _cacheImplementation;

        private readonly Cache<CacheItemWrapper<T>> _cache;

        public SimpleCache(ICacheImplementation cacheImplementation, string keyPrefix, TimeSpan defaultExpiration)
        {
            _cacheImplementation = cacheImplementation;
            _cache = new Cache<CacheItemWrapper<T>>(_cacheImplementation, keyPrefix, defaultExpiration);
        }

        public T Get(string key, Func<string, T> fetchItem)
        {
            var cacheItemWrapper = _cache.Get(key, () => Fetcher(key, fetchItem));
            return cacheItemWrapper.CacheItem;
        }

        public void Evict(string key)
        {
            _cache.Evict(key);
        }

        public void Insert(string key, T value)
        {
            _cache.Insert(key, new CacheItemWrapper<T> {CacheItem = value});
        }

        private class CacheItemWrapper<T>
        {
            public T CacheItem;
        }

        private static CacheItemWrapper<T> Fetcher(string key, Func<string, T> fetchItem)
        {
            var item = fetchItem(key);
            return new CacheItemWrapper<T>() {CacheItem = item};
        }
    }

}