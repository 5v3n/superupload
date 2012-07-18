require 'redis'

module SuperUpload
  module PersistencyManager
    def PersistencyManager.redis
      @redis || 
      @redis = (SuperUpload::REDIS_URI && Redis.new(
          :host => SuperUpload::REDIS_URI.host, 
          :port => SuperUpload::REDIS_URI.port, 
          :password => SuperUpload::REDIS_URI.password)) || 
          Redis.new
    end
    def PersistencyManager.save_hash_value(hash_name, key, value)
      self.redis.hset(hash_name, key, value)
    end
    def PersistencyManager.find_hash_value(hash_name, key)
      self.redis.hget hash_name, key
    end
  end
end