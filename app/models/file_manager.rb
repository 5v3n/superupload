require 'singleton'

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
    # class << self; attr_accessor :upload_progress, :path end
    # @upload_progress = Hash.new
    # @path = Hash.new
  end
end