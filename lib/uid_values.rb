module UidValues

  def current_uid_index
    uid_sequence_name = Rails.configuration.uid.sequence_name
    if Rails.configuration.uid.redis?
      (redis.get(uid_sequence_name) || 1).to_i
    else
      ActiveRecord::Base.connection.select_value("SELECT last_value FROM #{uid_sequence_name}").to_i
    end
  end

  #---------------------------------------------------------------------------
  private

  # Get the Redis client
  def redis
    if Rails.env.production?
      # Use Redis Cloud connection parameters.
      # https://redislabs.com/redis-ruby
      Redis.new(:host => 'localhost')
    else
      #Redis.new(:host => '192.168.1.50', :port => 6379, :db => 0)
      Redis.new(:host => 'localhost')
    end
  end
end
