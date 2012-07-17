require 'singleton'

module SuperUpload
  class FileManager
    include Singleton
    attr_accessor :upload_progress, :path
    def upload_progress
      @upload_progress || @upload_progress = {}
    end
    def path
      @path || @upload_progress = {}
    end
  end
end