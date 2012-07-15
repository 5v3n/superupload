module SuperUpload
  module UploadsController
    
    def self.create(params, response)
      if params && params['file'] && params['file'] != ""
        filename = params['file'][:filename] 
        begin
          response["Location"] = SuperUpload::Uploader.process filename, params['file'][:tempfile]
          201
        rescue => err
          p err
          409 #TODO handle with appropriate codes to the specific situations here... 
        end
      else
        response["Warning"] = "#{ERROR_MESSAGES[:missing_parameters]}: no filename given."
        400
      end
    end
  end
end