$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'super_upload'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/poltergeist'

RSpec.configure do |conf|
  ENV["RACK_ENV"] = 'test'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {:debug => true})
  end

  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
  
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 3
  Capybara.app = SuperUpload::App.new
  def app
    SuperUpload::App.new
  end

end