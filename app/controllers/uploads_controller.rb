module SuperUpload
  module UploadsController
    def self.create(env)
      #params = Rack::Request.new(env).params
      if true#params && params['file'] && params['file'] != ""
        begin
          location = SuperUpload::Uploader.process env
          [201, {"Content-Type" => "text/html", "Location" => location}, ["Upload is complete, post created..."] ]
        rescue => err
          p err
          [409, {"Content-Type" => "text/html"}, ["something went wrong..."] ] #TODO handle with appropriate codes to the specific situations here... 
        end
      else
        [400, {"Content-Type" => "text/html", "Warning" => "#{ERROR_MESSAGES[:missing_parameters]}: no filename given."}, ["#{ERROR_MESSAGES[:missing_parameters]}: no filename given."] ]
      end
    end
  end
end