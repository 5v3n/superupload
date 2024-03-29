require 'spec_helper'

describe 'Super Uploader' do
  let(:missing_parameters_error_message){ SuperUpload::ERROR_MESSAGES[:missing_parameters] }
  let(:upload_path){ '/uploads' }
  it "redirects to the upload page" do
    get '/'
    last_response.should be_redirect
    follow_redirect!
    last_request.url.should include("/uploads/new")
  end
  describe "accepts file uploads and" do
    it "stores the files correctly" do
      filename = "upload.txt"
      post upload_path, :file => Rack::Test::UploadedFile.new("spec/fixtures/#{filename}"),
                        :content_type => 'multipart/form-data'
      full_path = "#{SuperUpload::UPLOAD_PATH}/#{filename}"
      File.exists?(full_path).should be_true
      file_content_origin = File.read("spec/fixtures/#{filename}") 
      file_content_stored = File.read(full_path)
      file_content_origin.should == file_content_stored
    end
    it "handles valid requests" do
      filename = "upload.txt"
      post upload_path, :file => Rack::Test::UploadedFile.new("spec/fixtures/#{filename}"),
                        :content_type => 'multipart/form-data'
      last_response.status.should == 201
      last_response.header["Location"].should include(filename)
    end
    it "handles invalid requests without paramters" do
      post upload_path
      last_response.status.should == 409
      #next level of restfulness:
      #last_response.status.should == 400
      #last_response.header["Warning"].should include(missing_parameters_error_message)
      post upload_path, :file => ""
      last_response.status.should == 409
      #next level of restfulness:
      #last_response.status.should == 400
      #last_response.header["Warning"].should include(missing_parameters_error_message)
    end
  end
end