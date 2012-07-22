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
    let(:full_file_path) { File.join("spec/fixtures", "upload_short.txt") }
    let(:successful_upload_message){ 'Status: 100%.' }
    let(:missing_file_message){ 'Bad Request'}
    let(:upload_comment){"Woah! This rocks dude!!1!!"}
    before :each do
      visit upload_path
    end
    describe "offers a text form that", :js => true do
      it "dispays the link to the uploaded file after submit" do
        attach_file("file", full_file_path) #won't help in non-headless selenium mode...
        wait_until { page.has_content?(successful_upload_message) == true}
        fill_in 'comment', :with => upload_comment
        find('.js-comment-submit').click()
        page.should have_content upload_comment
      end
      it "dispays the title of the uploaded file after submit" do
        attach_file("file", full_file_path) #won't help in non-headless selenium mode...
        wait_until { page.has_content?(successful_upload_message) == true}
        fill_in 'comment', :with => upload_comment
        find('.js-comment-submit').click()
        page.should have_content "upload_short.txt"
      end
      it "dispays the path of the uploaded file after submit" do
        attach_file("file", full_file_path) #won't help in non-headless selenium mode...
        wait_until { page.has_content?(successful_upload_message) == true}
        fill_in 'comment', :with => upload_comment
        find('.js-comment-submit').click()
        page.should have_content "/uploads/files/upload_short.txt"
      end
      it "doesnt show itself before the upload completes" do
        find(".js-comment-form").should_not be_visible
      end
      it "shows itself when the upload completes", :js => true do
        attach_file("file", full_file_path) #won't help in non-headless selenium mode...
        find(".js-comment-form").should_not be_visible
        wait_until { page.has_content?(successful_upload_message) == true}
        find(".js-comment-form").should be_visible
      end
    end
    it "indicates a succesfully completed upload", :js => :true do
      attach_file("file", full_file_path) #won't help in non-headless selenium mode...
      #find(".js-file-upload-input").native.send_keys(File.expand_path("spec/fixtures/upload_short.txt", './'))
      wait_until { page.has_content?(successful_upload_message) == true}
      page.should have_content(successful_upload_message)
    end
    it "shows the file path after uploading", :js => true do
      attach_file("file", full_file_path) #won't help in non-headless selenium mode...
      wait_until { page.has_link?("Uploaded to here.") == true}
      page.should have_link("Uploaded to here.", :href => "/uploads/files/upload_short.txt")
    end
  end
end