module SuperUpload
  module UploadsController
    def self.create(env)
      location = SuperUpload::Uploader.process env
      if location
        [201, {"Content-Type" => "text/html", "Location" => location}, ["Upload is complete, post created..."] ]
      else
        [409, {"Content-Type" => "text/html"}, ["something went wrong..."] ] 
      end
      #TODO handle with appropriate codes to the specific situations here... like:
      #[400, {"Content-Type" => "text/html", "Warning" => "#{ERROR_MESSAGES[:missing_parameters]}: no filename given."}, ["#{ERROR_MESSAGES[:missing_parameters]}: no filename given."] ]
    end
  end
end