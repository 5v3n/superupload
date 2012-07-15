require 'spec_helper'

describe "Super Upload" do
  describe "file upload functionality" do
    let(:upload_path) { '/uploads/new' }
    let(:full_file_path) { File.join("spec/fixtures", "upload.txt") }
    let(:successful_upload_message){ 'Upload is complete.' }
    let(:missing_file_message){ 'Bad Request'}
    before :each do
      visit upload_path
    end

    it "indicates a succesfully completed upload", :js => :true do
      #attach_file("file", full_file_path) #won't help in non-headless selenium mode...
      find("#file-upload-input").native.send_keys(File.expand_path("spec/fixtures/upload.txt", './'))
      #click_button("Upload")
      wait_until { page.has_content?(successful_upload_message) == true}
      page.should have_content(successful_upload_message)
    end
  end
end