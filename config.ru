$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'

use Rack::CommonLogger
use Rack::Static, :urls => ["/stylesheets", "/javascripts", "/uploads/files"], :root => "public"

map '/uploads' do
  map '/' do
    run Proc.new { |env| 
      request = Rack::Request.new(env)
      if request.post?
        SuperUpload::UploadsController.create env
      end
    }
  end
  map '/new' do
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ::File.open('app/views/new.erb') ] }
  end
end

map '/' do
  run Proc.new { [ 302, {'Location'=> '/uploads/new' }, [] ] }
end
