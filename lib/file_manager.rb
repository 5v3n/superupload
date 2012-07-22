require 'persistency_manager'

module SuperUpload
  class FileManager
    include PersistencyManager
    attr_accessor :upload_progress, :total_size, :path, :sid
    PATH = "path"
    UPLOAD_PROGRESS = "upload_progress"
    TOTAL_SIZE = "total_size"
    def initialize(options = {})
      self.sid              = options[:sid]
      self.upload_progress  = options[:upload_progress]
      self.total_size       = options[:total_size]
      self.path             = options[:path]
    end
    def self.find_path(sid)
      PersistencyManager.find_hash_value PATH, sid
    end
    def self.find_upload_progress(sid)
      PersistencyManager.find_hash_value UPLOAD_PROGRESS, sid
    end
    def self.find_total_size(sid)
      PersistencyManager.find_hash_value TOTAL_SIZE, sid
    end
    def save
      PersistencyManager.save_hash_value UPLOAD_PROGRESS, @sid, @upload_progress
      PersistencyManager.save_hash_value TOTAL_SIZE, @sid, @total_size
      PersistencyManager.save_hash_value PATH, @sid, @path
    end
  end
end