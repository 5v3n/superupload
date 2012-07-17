$LOAD_PATH << './lib'
$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'
require 'cgi'

use Rack::CommonLogger
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
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ::File.open('app/views/new.erb') ] }
  end
end

map '/' do
  run Proc.new {|env| [ 302, {'Content-Type' => 'text/html', 'Location'=> '/uploads/new' }, [] ] }
end

map '/progress' do
  run Proc.new {|env| 
    sid = 'unknown'
    query_hash = CGI.parse(env["QUERY_STRING"])
    sid = query_hash["sid"].first if query_hash["sid"]
    p sid
    progress = (1..10).collect { |e| e*10 }.shuffle.first#SuperUpload::FileManager.instance.upload_progress[sid] || 0
    p progress
    [200, {"Content-Type" => "application/json"}, ["{\"progress\": #{progress}}"] ] 
  }
end
