module SuperUpload
  class Uploader
    attr_accessor :progress
    def self.process(filename, tmpfile)
      full_path = "#{SuperUpload::UPLOAD_PATH}/#{filename}"
      File.open(full_path, "wb") do |f|
        f.write(tmpfile.read)
      end
      full_path
    end
  end
end