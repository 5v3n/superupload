require 'redis'

module SuperUpload
  module PersistencyManager
    def PersistencyManager.redis
      @redis || @redis = find_or_start_database
    end
    def PersistencyManager.save_hash_value(hash_name, key, value)
      self.redis.hset(hash_name, key, value)
    end
    def PersistencyManager.find_hash_value(hash_name, key)
      self.redis.hget hash_name, key
    end
    def PersistencyManager.find_or_start_database
      # see http://reinteractive.net/posts/11-simple-strategy-for-redis-in-ruby-on-rails
      if ENV["RACK_ENV"] == "production"
        uri = URI.parse(ENV["REDISTOGO_URL"])
        @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      else #development or test:
        @redis = Redis.new
      end
    end
  end
end