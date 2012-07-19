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
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ::File.open('app/views/new.erb') ] }
  end
end

map '/comments/' do
  run Proc.new { |env| 
    if env["REQUEST_METHOD"] == "POST"
      request = Rack::Request.new env
      query_hash = CGI.parse(env["QUERY_STRING"])
      sid = query_hash["sid"].first if query_hash["sid"]
      path = SuperUpload::FileManager.find_path(sid)
      title = path.split('/').last
      comment = request.params["comment"]
      [201, {"Content-Type" => "text/html", "Location" => path }, [%|Thanks for submitting #{title} - it's stored at <a href="#{path}">#{path}</a>. You were all like: "#{comment}"|] ]
    end
  }
end

map '/' do
  run Proc.new {|env| [ 302, {'Content-Type' => 'text/html', 'Location'=> '/uploads/new' }, [] ] }
end

map '/progress' do
  run Proc.new {|env| 
    sid = 'unknown'
    query_hash = CGI.parse(env["QUERY_STRING"])
    sid = query_hash["sid"].first if query_hash["sid"]
    progress = SuperUpload::FileManager.find_upload_progress(sid) || 0
    if path = SuperUpload::FileManager.find_path(sid)
      response = "{\"progress\": #{progress}, \"path\": \"#{path}\"}"
    else
      response = "{\"progress\": #{progress}}"
    end
    [200, {"Content-Type" => "application/json"}, [response] ] 
  }
end
