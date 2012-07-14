require "sinatra"
require "./app/controllers/uploads_controller.rb"
require "./app/models/uploader.rb"

module SuperUpload
  
  UPLOAD_PATH = 'public/uploads'
  ERROR_MESSAGES = {
      :missing_parameters => 'Missing parameter(s).'
    }
  
  class App < Sinatra::Application
    post "/uploads" do
      SuperUpload::UploadsController.create params, response
    end
  end

end