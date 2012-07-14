module SuperUpload
  class Uploader
    def self.process(filename, tempfile)
      File.open("#{SuperUpload::UPLOAD_PATH}/#{filename}", "w") do |f|
        f.write(tempfile.read)
      end
      "#{SuperUpload::UPLOAD_PATH}/#{filename}"
    end
  end
end