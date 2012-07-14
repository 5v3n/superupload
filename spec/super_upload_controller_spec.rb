require 'spec_helper'

describe 'Super Uploader' do
  it "greets like sinatra" do
    get '/'
    last_response.should be_ok
    last_response.body.should == "do be do be do!"
  end
end