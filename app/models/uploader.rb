require 'CGI'
require 'webrick/httputils'

module SuperUpload
  class Uploader
    def self.process(params, request, response)
      # request.body.rewind  # in case someone already read it
      # filename = params[:file][:filename]
      # tmp_file = params[:tmpfile]
      # position = 0
      # total_size = request.content_length.to_i
      # path = "#{SuperUpload::UPLOAD_PATH}/#{filename}"
      # File.open(path, "wb") do |buff|
      #   while blk = request.body.read(SuperUpload::BUFFER_SIZE)
      #     buff.write(blk)
      #     position += SuperUpload::BUFFER_SIZE
      #     #puts "#{position} / #{total_size} = #{(((1.0 * position) / total_size) * 100).to_i}"
      #   end
      # end 
      # path
      # check that we've received file data to upload
    
    upload_progress = 0
    total = request.content_length.to_f
    current_position = 0
    body = String.new
    request.body.each do |chunk|
      current_position = current_position + chunk.length.to_f
      progress = ((current_position / total) * 100).to_i
      #puts progress
      upload_progress = progress
      body << chunk
    end
    # parse body of request and raise error if file data is empty
    boundary = request.env["CONTENT_TYPE"].match(/^multipart\/form-data; boundary=(.+)/)[1]
    boundary = WEBrick::HTTPUtils::dequote(boundary)
    filedata = WEBrick::HTTPUtils::parse_form_data(body, boundary)
    filename = params['file'][:filename]
    File.open(SuperUpload::UPLOAD_PATH + '/' + filename,'wb') do |f|
      f.write body
    end 
    f = File.new(SuperUpload::UPLOAD_PATH + '/' + filename,'wb')
    f.syswrite filedata['file']
    f.close
    upload_file = f.path
    end
  end
end