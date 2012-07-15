$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'super_upload'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

RSpec.configure do |conf|
  set :environment, :test

  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
  
  Capybara.javascript_driver = :selenium
  Capybara.default_wait_time = 10
  Capybara.app = SuperUpload::App.new

  def app
    SuperUpload::App
  end

end