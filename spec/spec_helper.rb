$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'super_upload'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
  
  Capybara.javascript_driver = :selenium
  Capybara.default_wait_time = 10
  Capybara.app = eval "Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../config.ru') + "\n )}" 

  def app
    eval "Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../config.ru') + "\n )}"
  end

end