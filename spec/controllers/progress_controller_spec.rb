require 'spec_helper'

describe SuperUpload::ProgressController do
  describe "handles GET requests" do
    it "with sid" do
      get '/progress?sid=3242225'
      last_response.status.should == 200
      last_response.body.should include('"progress":')
    end
    it "without sid" do
      get '/progress'
      last_response.status.should == 200
      last_response.body.should include('"progress":')
    end
  end
end