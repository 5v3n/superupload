$LOAD_PATH << './lib'
$LOAD_PATH << './app'
$LOAD_PATH << './app/models'
$LOAD_PATH << './app/controllers'

require 'super_upload'

run SuperUpload::App.new
