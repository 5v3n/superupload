require './app/models/file_manager.rb'
require 'cgi'
require 'webrick'

module SuperUpload
  class Uploader
    def self.process(env)
      params = CGI.parse(env["QUERY_STRING"])
      sid = params["sid"].first
      total_size = env["CONTENT_LENGTH"].to_i
      SuperUpload::FileManager.instance.upload_progress[sid] = 0
      body = stream_read_response env["rack.input"], total_size, sid
      file_name = parse_for_file_name(body) || sid
      paylod = parse_for_payload(body, env['CONTENT_TYPE'])
      path = "#{SuperUpload::UPLOAD_PATH}/#{file_name}"
      File.open(path, "wb") do |file|
        file.write paylod
      end
      SuperUpload::FileManager.instance.path[sid] = path
      return path
    end
private
    def self.stream_read_response(input, total_size, sid)
      body = ""
      current_position = 0
      while chunk = input.read(SuperUpload::BUFFER_SIZE)
        body << chunk
        current_position += SuperUpload::BUFFER_SIZE
        progress = (( (1.0 * current_position) / total_size) * 100).to_i
        SuperUpload::FileManager.instance.upload_progress[sid] = progress
        SuperUpload::FileManager.instance.persist
        puts "#{current_position} / #{total_size} = #{progress}"
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
      boundary = content_type.match(/^multipart\/form-data; boundary=(.+)/)[1]
      boundary = WEBrick::HTTPUtils::dequote(boundary)
      form_data =  WEBrick::HTTPUtils::parse_form_data(body, boundary) || {}
      return form_data["file"]
    end
  end
end