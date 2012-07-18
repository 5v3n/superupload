require 'singleton'
require 'redis'

module SuperUpload
  class FileManager
    include Singleton
    attr_accessor :upload_progress, :path
    def upload_progress
      @upload_progress || @upload_progress = {}
    end
    def path
      @path || @path = {}
    end
    def redis
      @redis || @redis = (SuperUpload::REDIS_URI && Redis.new(:host => SuperUpload::REDIS_URI.host, :port => SuperUpload::REDIS_URI.port, :password => SuperUpload::REDIS_URI.password)) || Redis.new
    end
    def persist
      self.path.each            {|key, value| self.redis.hset("path", key, value) }
      self.upload_progress.each {|key, value| self.redis.hset("upload_progress", key, value)}
    end
    def find_path(sid)
      self.redis.hget "path", sid
    end
    def find_upload_progress(sid)
      self.redis.hget "upload_progress", sid
    end
  end
end