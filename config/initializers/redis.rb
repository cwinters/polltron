location = ENV['REDISTOGO_URL'] || ENV['REDIS_URL'] || 'redis://localhost:6379/'
uri = URI.parse(location)
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
