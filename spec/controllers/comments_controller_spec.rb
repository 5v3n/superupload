require 'spec_helper'

describe SuperUpload::CommentsController do
  describe "handles form submits" do
    it "with comment" do
      comment = 'yee-haw!'
      post '/comments?sid=3242225', :comment => comment
      last_response.status.should == 200
    end
    it "without comment" do
      post '/comments?sid=3242225'
      last_response.status.should == 200
    end
  end
end