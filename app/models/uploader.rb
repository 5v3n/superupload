require './app/models/file_manager.rb'
require 'cgi'

module SuperUpload
  class Uploader
    def self.process(env)
      this_way env
      #the_other_way rack_env
    end
    def self.this_way(env)
      params = CGI.parse(env["QUERY_STRING"])
      filename = params["filename"].first
      sid = params["sid"].first
      total_size = env["CONTENT_LENGTH"].to_i
      current_position = 0
      body = ""
      SuperUpload::FileManager.instance.upload_progress[sid] = 0
      while chunk = env['rack.input'].read(SuperUpload::BUFFER_SIZE)
        body << chunk
        current_position += SuperUpload::BUFFER_SIZE
        progress = (( (1.0 * current_position) / total_size) * 100).to_i
        SuperUpload::FileManager.instance.upload_progress[sid] = progress
        puts "#{current_position} / #{total_size} = #{progress}"
      end
      path = "#{SuperUpload::UPLOAD_PATH}/#{filename}"
      File.open(path, "wb") do |file|
        file.write body
      end
      SuperUpload::FileManager.instance.path[sid] = path
      p SuperUpload::FileManager.instance
      path
    end
  end
end