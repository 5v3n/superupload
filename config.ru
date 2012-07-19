$LOAD_PATH << './lib'
$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'
require 'cgi'

use Rack::CommonLogger unless ENV["RACK_ENV"]
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
