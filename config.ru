$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'

use Rack::CommonLogger
use Rack::Static, :urls => ["/stylesheets", "/javascripts", "/uploads/files"], :root => "public"

map '/uploads' do
  map '/' do
    run Proc.new { |env| 
      p env
      if env["REQUEST_METHOD"] == "POST"
        SuperUpload::UploadsController.create env
      end
    }
  end
  map '/new' do
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ::File.open('app/views/new.erb') ] }
  end
end

map '/' do
  run Proc.new { [ 302, {'Content-Type' => 'text/html', 'Location'=> '/uploads/new' }, [] ] }
end

map '/progress' do
  run Proc.new {|env| [200, {"Content-Type" => "application/json"}, ["{'progress': 'mocked!!!'}"] ] }
end
