$LOAD_PATH << './lib'
$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'
require 'cgi'

use Rack::CommonLogger unless ENV["RACK_ENV"]
use Rack::Static, :urls => ["/stylesheets", "/javascripts", "/uploads/files"], :root => "public"


run SuperUpload::App.new