module SuperUpload
  class Uploader
    attr_accessor :progress
    def self.process(params, request, response)
      request.body.rewind  # in case someone already read it
      filename = params[:file][:filename]
      tmp_file = params[:tmpfile]
      position = 0
      total_size = request.content_length.to_i
      path = "#{SuperUpload::UPLOAD_PATH}/#{filename}"
      File.open(path, "wb") do |buff|
        while blk = request.body.read(SuperUpload::BUFFER_SIZE)
          buff.write(blk)
          position += SuperUpload::BUFFER_SIZE
          #puts "#{position} / #{total_size} = #{(((1.0 * position) / total_size) * 100).to_i}"
        end
      end 
      path
    end
  end
end