require 'singleton'
require './app/models/persistency_manager.rb'

module SuperUpload
  class FileManager
    include PersistencyManager
    attr_accessor :upload_progress, :total_size, :path, :sid
    def initialize(options = {})
      self.sid              = options[:sid]
      self.upload_progress  = options[:upload_progress]
      self.total_size       = options[:total_size]
      self.path             = options[:path]
    end
    def self.find_path(sid)
      PersistencyManager.find_hash_value "path", sid
    end
    def self.find_upload_progress(sid)
      PersistencyManager.find_hash_value "upload_progress", sid
    end
    def save
      PersistencyManager.save_hash_value "upload_progress", @sid, @upload_progress
      PersistencyManager.save_hash_value "total_size", @sid, @total_size
      PersistencyManager.save_hash_value "path", @sid, @path
    end
  end
end