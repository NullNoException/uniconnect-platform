using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using StackExchange.Redis;
using System.Text.Json;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Services;

/// <summary>
/// Enhanced Redis cache service with advanced caching patterns and best practices
/// </summary>
public class EnhancedRedisCacheService : ICacheService
{
    private readonly IDistributedCache _distributedCache;
    private readonly IConnectionMultiplexer _connectionMultiplexer;
    private readonly IDatabase _database;
    private readonly ILogger<EnhancedRedisCacheService> _logger;
    private readonly DistributedCacheEntryOptions _defaultOptions;
    private readonly SemaphoreSlim _semaphore;

    public EnhancedRedisCacheService(
        IDistributedCache distributedCache,
        IConnectionMultiplexer connectionMultiplexer,
        ILogger<EnhancedRedisCacheService> logger)
    {
        _distributedCache = distributedCache;
        _connectionMultiplexer = connectionMultiplexer;
        _database = _connectionMultiplexer.GetDatabase();
        _logger = logger;
        _semaphore = new SemaphoreSlim(100, 100); // Limit concurrent operations

        _defaultOptions = new DistributedCacheEntryOptions
        {
            AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(10),
            SlidingExpiration = TimeSpan.FromMinutes(5)
        };
    }

    #region Basic Cache Operations

    public async Task<T?> GetAsync<T>(string key, CancellationToken cancellationToken = default) where T : class
    {
        try
        {
            var cachedValue = await _distributedCache.GetStringAsync(key, cancellationToken);

            if (string.IsNullOrEmpty(cachedValue))
            {
                _logger.LogDebug("Cache miss for key: {Key}", key);
                return default;
            }

            _logger.LogDebug("Cache hit for key: {Key}", key);
            return JsonSerializer.Deserialize<T>(cachedValue);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving cached value for key {Key}", key);
            return default;
        }
    }

    public async Task<T> GetOrCreateAsync<T>(string key, Func<Task<T>> factory, TimeSpan? expiration = null, CancellationToken cancellationToken = default) where T : class
    {
        var cachedValue = await GetAsync<T>(key, cancellationToken);

        if (cachedValue != null)
        {
            return cachedValue;
        }

        // Use distributed locking to prevent cache stampede
        return await GetOrCreateWithLockAsync(key, factory, expiration, cancellationToken);
    }

    public async Task SetAsync<T>(string key, T value, TimeSpan? expiration = null, CancellationToken cancellationToken = default) where T : class
    {
        try
        {
            var options = CreateCacheOptions(expiration);
            var serializedValue = JsonSerializer.Serialize(value);

            await _distributedCache.SetStringAsync(key, serializedValue, options, cancellationToken);

            // Add to cache invalidation tracking
            await AddToCacheTracking(key, GetCacheType<T>());

            _logger.LogDebug("Successfully cached value for key: {Key}", key);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error setting cached value for key {Key}", key);
            throw;
        }
    }

    public async Task RemoveAsync(string key, CancellationToken cancellationToken = default)
    {
        try
        {
            await _distributedCache.RemoveAsync(key, cancellationToken);
            await RemoveFromCacheTracking(key);
            _logger.LogDebug("Successfully removed cached value for key: {Key}", key);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error removing cached value for key {Key}", key);
            throw;
        }
    }

    public async Task RemoveByPatternAsync(string pattern, CancellationToken cancellationToken = default)
    {
        try
        {
            var server = _connectionMultiplexer.GetServer(_connectionMultiplexer.GetEndPoints().First());
            var keys = server.Keys(pattern: pattern).ToArray();

            if (keys.Length > 0)
            {
                await _database.KeyDeleteAsync(keys);

                // Remove from tracking
                foreach (var key in keys)
                {
                    await RemoveFromCacheTracking(key);
                }

                _logger.LogDebug("Successfully removed {Count} keys matching pattern: {Pattern}", keys.Length, pattern);
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error removing cached values by pattern {Pattern}", pattern);
            throw;
        }
    }

    #endregion

    #region Advanced Caching Patterns

    /// <summary>
    /// Cache-Aside pattern with refresh-ahead strategy
    /// </summary>
    public async Task<T> GetOrCreateWithRefreshAheadAsync<T>(
        string key,
        Func<Task<T>> factory,
        TimeSpan expiration,
        double refreshThreshold = 0.8,
        CancellationToken cancellationToken = default) where T : class
    {
        var cachedValue = await GetAsync<T>(key, cancellationToken);

        if (cachedValue != null)
        {
            // Check if we need to refresh ahead
            var ttl = await _database.KeyTimeToLiveAsync(key);
            if (ttl.HasValue && ttl.Value.TotalSeconds < expiration.TotalSeconds * refreshThreshold)
            {
                // Asynchronously refresh the cache
                _ = Task.Run(async () =>
                {
                    try
                    {
                        var freshValue = await factory();
                        await SetAsync(key, freshValue, expiration, cancellationToken);
                    }
                    catch (Exception ex)
                    {
                        _logger.LogWarning(ex, "Failed to refresh cache for key: {Key}", key);
                    }
                });
            }

            return cachedValue;
        }

        return await GetOrCreateWithLockAsync(key, factory, expiration, cancellationToken);
    }

    /// <summary>
    /// Write-Through cache pattern
    /// </summary>
    public async Task<T> WriteThrough<T>(
        string key,
        Func<Task<T>> createOrUpdateFunc,
        TimeSpan? expiration = null,
        CancellationToken cancellationToken = default) where T : class
    {
        try
        {
            // Execute the operation
            var value = await createOrUpdateFunc();

            // Immediately cache the result
            await SetAsync(key, value, expiration, cancellationToken);

            return value;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in write-through operation for key: {Key}", key);
            throw;
        }
    }

    /// <summary>
    /// Write-Behind cache pattern
    /// </summary>
    public async Task WriteBehind<T>(
        string key,
        T value,
        Func<T, Task> persistFunc,
        TimeSpan? expiration = null,
        CancellationToken cancellationToken = default) where T : class
    {
        // Immediately cache the value
        await SetAsync(key, value, expiration, cancellationToken);

        // Asynchronously persist to storage
        _ = Task.Run(async () =>
        {
            try
            {
                await persistFunc(value);
                _logger.LogDebug("Successfully persisted value for key: {Key}", key);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to persist value for key: {Key}", key);
                // Could implement retry logic or dead letter queue here
            }
        });
    }

    /// <summary>
    /// Bulk cache operations for better performance
    /// </summary>
    public async Task<Dictionary<string, T?>> GetMultipleAsync<T>(
        IEnumerable<string> keys,
        CancellationToken cancellationToken = default) where T : class
    {
        var result = new Dictionary<string, T?>();
        var keyArray = keys.ToArray();

        try
        {
            var redisKeys = keyArray.Select(k => (RedisKey)k).ToArray();
            var values = await _database.StringGetAsync(redisKeys);

            for (int i = 0; i < keyArray.Length; i++)
            {
                var key = keyArray[i];
                var value = values[i];

                if (value.HasValue)
                {
                    try
                    {
                        result[key] = JsonSerializer.Deserialize<T>(value);
                    }
                    catch (Exception ex)
                    {
                        _logger.LogWarning(ex, "Failed to deserialize cached value for key: {Key}", key);
                        result[key] = default;
                    }
                }
                else
                {
                    result[key] = default;
                }
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving multiple cached values");
            // Return dictionary with all null values
            foreach (var key in keyArray)
            {
                result[key] = default;
            }
        }

        return result;
    }

    /// <summary>
    /// Set multiple cache entries atomically
    /// </summary>
    public async Task SetMultipleAsync<T>(
        Dictionary<string, T> keyValuePairs,
        TimeSpan? expiration = null,
        CancellationToken cancellationToken = default) where T : class
    {
        try
        {
            var batch = _database.CreateBatch();
            var tasks = new List<Task>();

            foreach (var kvp in keyValuePairs)
            {
                var serializedValue = JsonSerializer.Serialize(kvp.Value);
                var task = batch.StringSetAsync(kvp.Key, serializedValue, expiration);
                tasks.Add(task);

                // Add to tracking
                tasks.Add(AddToCacheTracking(kvp.Key, GetCacheType<T>()));
            }

            batch.Execute();
            await Task.WhenAll(tasks);

            _logger.LogDebug("Successfully cached {Count} values", keyValuePairs.Count);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error setting multiple cached values");
            throw;
        }
    }

    #endregion

    #region Cache Warming and Invalidation

    /// <summary>
    /// Warm up the cache with frequently accessed data
    /// </summary>
    public async Task WarmUpCacheAsync<T>(
        Dictionary<string, Func<Task<T>>> warmUpData,
        TimeSpan? expiration = null,
        CancellationToken cancellationToken = default) where T : class
    {
        _logger.LogInformation("Starting cache warm-up for {Count} items", warmUpData.Count);

        var tasks = warmUpData.Select(async kvp =>
        {
            try
            {
                var value = await kvp.Value();
                await SetAsync(kvp.Key, value, expiration, cancellationToken);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Failed to warm up cache for key: {Key}", kvp.Key);
            }
        });

        await Task.WhenAll(tasks);

        _logger.LogInformation("Cache warm-up completed");
    }

    /// <summary>
    /// Invalidate cache based on tags/categories
    /// </summary>
    public async Task InvalidateByCategoryAsync(string category, CancellationToken cancellationToken = default)
    {
        try
        {
            var trackingKey = $"cache_tracking:{category}";
            var keys = await _database.SetMembersAsync(trackingKey);

            if (keys.Length > 0)
            {
                var redisKeys = keys.Select(k => (RedisKey)k.ToString()).ToArray();
                await _database.KeyDeleteAsync(redisKeys);
                await _database.KeyDeleteAsync(trackingKey);

                _logger.LogDebug("Invalidated {Count} cache entries for category: {Category}", keys.Length, category);
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error invalidating cache by category: {Category}", category);
            throw;
        }
    }

    #endregion

    #region Health and Metrics

    /// <summary>
    /// Get cache health metrics
    /// </summary>
    public async Task<CacheHealthMetrics> GetHealthMetricsAsync()
    {
        try
        {
            var info = await _database.ExecuteAsync("INFO", "memory");
            var keyspace = await _database.ExecuteAsync("INFO", "keyspace");

            return new CacheHealthMetrics
            {
                IsHealthy = _connectionMultiplexer.IsConnected,
                UsedMemory = ExtractMemoryUsage(info.ToString()),
                KeyCount = ExtractKeyCount(keyspace.ToString()),
                Timestamp = DateTime.UtcNow
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving cache health metrics");
            return new CacheHealthMetrics
            {
                IsHealthy = false,
                Timestamp = DateTime.UtcNow
            };
        }
    }

    #endregion

    #region Private Helper Methods

    private async Task<T> GetOrCreateWithLockAsync<T>(
        string key,
        Func<Task<T>> factory,
        TimeSpan? expiration,
        CancellationToken cancellationToken) where T : class
    {
        var lockKey = $"lock:{key}";
        var lockValue = Guid.NewGuid().ToString();
        var lockExpiry = TimeSpan.FromMinutes(2);

        await _semaphore.WaitAsync(cancellationToken);
        try
        {
            // Try to acquire distributed lock
            var lockAcquired = await _database.StringSetAsync(lockKey, lockValue, lockExpiry, When.NotExists);

            if (lockAcquired)
            {
                try
                {
                    // Double-check if value was cached while waiting for lock
                    var cachedValue = await GetAsync<T>(key, cancellationToken);
                    if (cachedValue != null)
                    {
                        return cachedValue;
                    }

                    // Generate new value
                    var value = await factory();
                    await SetAsync(key, value, expiration, cancellationToken);
                    return value;
                }
                finally
                {
                    // Release lock
                    await ReleaseLockAsync(lockKey, lockValue);
                }
            }
            else
            {
                // Wait for lock to be released and try again
                await Task.Delay(50, cancellationToken);
                var cachedValue = await GetAsync<T>(key, cancellationToken);

                if (cachedValue != null)
                {
                    return cachedValue;
                }

                // If still no value, create it (fallback)
                var value = await factory();
                await SetAsync(key, value, expiration, cancellationToken);
                return value;
            }
        }
        finally
        {
            _semaphore.Release();
        }
    }

    private async Task ReleaseLockAsync(string lockKey, string lockValue)
    {
        const string script = @"
            if redis.call('GET', KEYS[1]) == ARGV[1] then
                return redis.call('DEL', KEYS[1])
            else
                return 0
            end";

        await _database.ScriptEvaluateAsync(script, new RedisKey[] { lockKey }, new RedisValue[] { lockValue });
    }

    private DistributedCacheEntryOptions CreateCacheOptions(TimeSpan? expiration)
    {
        if (expiration.HasValue)
        {
            return new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = expiration,
                SlidingExpiration = TimeSpan.FromMinutes(Math.Min(expiration.Value.TotalMinutes / 2, 30))
            };
        }

        return _defaultOptions;
    }

    private async Task AddToCacheTracking(string key, string category)
    {
        try
        {
            var trackingKey = $"cache_tracking:{category}";
            await _database.SetAddAsync(trackingKey, key);
            await _database.KeyExpireAsync(trackingKey, TimeSpan.FromHours(24));
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to add cache tracking for key: {Key}", key);
        }
    }

    private async Task RemoveFromCacheTracking(string key)
    {
        try
        {
            var server = _connectionMultiplexer.GetServer(_connectionMultiplexer.GetEndPoints().First());
            var trackingKeys = server.Keys(pattern: "cache_tracking:*").ToArray();

            foreach (var trackingKey in trackingKeys)
            {
                await _database.SetRemoveAsync(trackingKey, key);
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to remove cache tracking for key: {Key}", key);
        }
    }

    private static string GetCacheType<T>()
    {
        var type = typeof(T);
        return type.Name.ToLowerInvariant();
    }

    private long ExtractMemoryUsage(string info)
    {
        // Parse Redis INFO memory output
        var lines = info.Split('\n');
        var memoryLine = lines.FirstOrDefault(l => l.StartsWith("used_memory:"));

        if (memoryLine != null && long.TryParse(memoryLine.Split(':')[1].Trim(), out var memory))
        {
            return memory;
        }

        return 0;
    }

    private int ExtractKeyCount(string keyspace)
    {
        // Parse Redis INFO keyspace output
        var lines = keyspace.Split('\n');
        var dbLine = lines.FirstOrDefault(l => l.StartsWith("db0:"));

        if (dbLine != null)
        {
            var keysPart = dbLine.Split(',')[0];
            var keysValue = keysPart.Split('=')[1];

            if (int.TryParse(keysValue, out var keys))
            {
                return keys;
            }
        }

        return 0;
    }

    public void Dispose()
    {
        _semaphore?.Dispose();
    }

    #endregion
}

/// <summary>
/// Cache health metrics model
/// </summary>
public class CacheHealthMetrics
{
    public bool IsHealthy { get; set; }
    public long UsedMemory { get; set; }
    public int KeyCount { get; set; }
    public DateTime Timestamp { get; set; }
}
