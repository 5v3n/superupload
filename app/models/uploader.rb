require './app/models/file_manager.rb'
require 'cgi'
require 'webrick'

module SuperUpload
  class Uploader
    def self.process(env)
      params = CGI.parse(env["QUERY_STRING"])
      sid = params["sid"].first
      total_size = env["CONTENT_LENGTH"].to_i
      content_type = env['CONTENT_TYPE']
      path = nil
      file_manager = FileManager.new(:sid => sid, :upload_progress => 0, :total_size => total_size)
      if total_size != 0
        body = stream_read_response env["rack.input"], file_manager
        file_name = parse_for_file_name(body) 
        file_name ||= sid
        unless file_name == "" || file_name.nil?
          payload = parse_for_payload(body, content_type)
          path = "#{SuperUpload::UPLOAD_PATH}/#{file_name}"
          File.open(path, "wb") do |file|
            file.write payload
          end
          file_manager.path = path.gsub!('public','')
          file_manager.save
        end
      end
      return path
    end
private
    def self.stream_read_response(input, file_manager)
      body = ""
      current_position = 0
      total_size = file_manager.total_size
      while chunk = input.read(SuperUpload::BUFFER_SIZE)
        body << chunk
        current_position += SuperUpload::BUFFER_SIZE
        progress = (( (1.0 * current_position) / total_size) * 100).to_i
        file_manager.upload_progress = progress
        file_manager.save
        #puts "#{current_position} / #{total_size} = #{progress}"
      end
      return body
    end
    def self.parse_for_file_name(body)
      parse_result = body.match(/filename="(.*)"/)
      if parse_result && result_array = parse_result.to_a
        file_name = result_array[1]
      else
        file_name = nil
      end
      return file_name
    end
    def self.parse_for_payload(body, content_type)
      if boundary_array = content_type.match(/^multipart\/form-data; boundary=(.+)/)
        boundary = content_type.match(/^multipart\/form-data; boundary=(.+)/)[1]
        boundary = WEBrick::HTTPUtils::dequote(boundary)
        form_data =  WEBrick::HTTPUtils::parse_form_data(body, boundary) || {}
        result = form_data["file"]
      else
        result = nil
      end
      return result 
    end
  end
end