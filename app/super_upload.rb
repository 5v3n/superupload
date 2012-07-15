require "sinatra"
require "./app/controllers/uploads_controller.rb"
require "./app/models/uploader.rb"

module SuperUpload
  
  UPLOAD_PATH = 'public/uploads/files'
  ERROR_MESSAGES = {
      :missing_parameters => 'Missing parameter(s)'
    }
  
  class App < Sinatra::Application
    set :public_folder, 'public'
    set :views, settings.root + '/views'
    get '/' do
      redirect "/uploads/new"
    end
    get "/uploads/new" do
      #SuperUpload::UploadsController.new params, response
      erb :new
    end
    post "/uploads" do
      SuperUpload::UploadsController.create params, response
    end
    get "/progress" do
      SuperUpload::UploadsController.progress params, response
    end
  end

end