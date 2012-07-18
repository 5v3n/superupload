require 'spec_helper'

=begin

Specification

When a user picks a file from their computer, the upload automatically begins. 
While uploading, the percentage complete is visible on the page. 
It should update at least every 2 seconds.
While uploading, the user should be able to enter text into a description text area:
When the upload completes, the page should display the path to the saved file. 
When the user clicks save, the current value of the description text area should be posted to the server. 
The response to the form post request should display both the title and the path to the file.
  
=end

describe "Super Upload" do
  describe "file upload functionality" do
    let(:upload_path) { '/uploads/new' }
    let(:full_file_path) { File.join("spec/fixtures", "upload.txt") }
    let(:successful_upload_message){ 'Upload complete' }
    let(:missing_file_message){ 'Bad Request'}
    before :each do
      visit upload_path
    end

    it "indicates a succesfully completed upload", :js => :true do
      #attach_file("file", full_file_path) #won't help in non-headless selenium mode...
      find(".js-file-upload-input").native.send_keys(File.expand_path("spec/fixtures/upload.txt", './'))
      #click_button("Upload")
      wait_until { page.has_content?(successful_upload_message) == true}
      page.should have_content(successful_upload_message)
    end
    it "offers a text form when the upload started"
    it "shows the file path after uploading"
  end
end