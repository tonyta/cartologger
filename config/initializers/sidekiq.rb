redis_conn = proc { Redis.new(db: 0) }

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 30, &redis_conn)
end