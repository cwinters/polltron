location = ENV['REDISTOGO_URL'] || ENV['REDIS_URL']
uri = URI.parse(location)
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
