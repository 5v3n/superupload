require 'spec_helper'

describe 'Super Uploader' do
  describe "accepts and stores file uploads and" do
    it "handles valid requests" do
      filename = "upload.txt"
      post '/uploads', :file => Rack::Test::UploadedFile.new("spec/fixtures/#{filename}")
      File.exists?("public/uploads/#{filename}").should be_true
      last_response.status.should == 201
      last_response.header["Location"].should == "#{SuperUpload::UPLOAD_PATH}/#{filename}"
    end
    it "handles invalid requests without paramters" do
      post '/uploads'
      last_response.status.should == 400
      last_response.header["Warning"].should == SuperUpload::ERROR_MESSAGES[:missing_parameters]
    end
  end
end