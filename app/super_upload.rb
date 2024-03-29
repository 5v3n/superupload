require "./app/controllers/uploads_controller.rb"
require "./app/controllers/comments_controller.rb"
require "./app/controllers/progress_controller.rb"
require "./app/models/uploader.rb"
require "./app/models/progress.rb"
require "./app/models/comment.rb"
require "./lib/file_manager.rb"
require "./lib/monkey_patches.rb"

require 'rack'

module SuperUpload
  UPLOAD_PATH = 'public/uploads/files'
  BUFFER_SIZE = ENV["BUFFER_SIZE"] && ENV["BUFFER_SIZE"].to_i || 4096 #Smaller buffer means slower processing. Ideal for development...
  ERROR_MESSAGES = {
      :missing_parameters => 'Missing parameter(s)'
    }

  if ENV["REDISTOGO_URL"]
    REDIS_URI = URI.parse(ENV["REDISTOGO_URL"]) 
  else
    REDIS_URI = nil
  end
  
  class App
    def initialize
      @app = Rack::Builder.new {
        use Rack::CommonLogger unless ENV["RACK_ENV"] == 'test'
        use Rack::Static, :urls => ["/stylesheets", "/javascripts", "/uploads/files"], :root => "public"

      map '/uploads' do
        map '/' do
          run Proc.new { |env| 
            if env["REQUEST_METHOD"] == "POST"
              SuperUpload::UploadsController.create env
            end
          }
        end
        map '/new' do
          run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ::File.open('app/views/upload/new.erb') ] }
        end
      end

      map '/comments/' do
        run Proc.new { |env| 
          if env["REQUEST_METHOD"] == "POST"
            SuperUpload::CommentsController.create env
          end
        }
      end

      map '/' do
        run Proc.new {|env| [ 302, {'Content-Type' => 'text/html', 'Location'=> '/uploads/new' }, [] ] }
      end

      map '/progress' do
        run Proc.new {|env| SuperUpload::ProgressController.show env  }
      end
      }
    end

    def call(env)
      @app.call(env)
    end
  end
end
