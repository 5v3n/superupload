require "./app/controllers/uploads_controller.rb"
require "./app/controllers/comments_controller.rb"
require "./app/controllers/progress_controller.rb"
require "./app/models/uploader.rb"
require "./app/models/progress.rb"
require "./app/models/comment.rb"
require "./app/models/file_manager.rb"
require "./lib/monkey_patches.rb"

module SuperUpload
  UPLOAD_PATH = 'public/uploads/files'
  BUFFER_SIZE = ENV["BUFFER_SIZE"] && ENV["BUFFER_SIZE"].to_i || 4096 #Smaller buffer means slower processing. Ideal for development...
  ERROR_MESSAGES = {
      :missing_parameters => 'Missing parameter(s)'
    }
  REDIS_URI = nil
  REDIS_URI = URI.parse(ENV["REDISTOGO_URL"]) if ENV["REDISTOGO_URL"]
end
