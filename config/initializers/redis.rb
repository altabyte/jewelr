# Set a global variable $redis to access the Redis datasource.
#
$redis = Redis::Namespace.new("jewelr:#{Rails.env}", :redis => Redis.new(url: ENV['REDIS_URL']))
