require 'spec_helper'
require './app/models/file_manager.rb'

describe SuperUpload::FileManager do
  let(:file_manager){ SuperUpload::FileManager.new(
    :sid => 'sid', 
    :upload_progress => 'upload_progress', 
    :total_size => 'total_size', 
    :path => 'path' )}
  it "initializes the parameters given in the options hash" do
    file_manager
    file_manager.sid.should             == 'sid'
    file_manager.upload_progress.should == 'upload_progress'
    file_manager.total_size.should      == 'total_size'
    file_manager.path.should            == 'path'
    file_manager = SuperUpload::FileManager.new(:sid => 'sid')
    file_manager.sid.should             == 'sid'
    file_manager.upload_progress.should == nil
    file_manager.total_size.should      == nil
    file_manager.path.should            == nil
  end
  describe "uses the given persistency and" do
    let(:path){ "dfsgfsdg4453/gfbdfg/dgtf.jpg"}
    let(:upload_progress){ "234"}
    let(:total_size){ "43543" }
    before :all do
      @redis = Redis.new
    end
    it "finds all attributes" do
      sid = "1"
      @redis.hset SuperUpload::FileManager::PATH, sid, path
      SuperUpload::FileManager.find_path(sid).should == path
      @redis.hset SuperUpload::FileManager::UPLOAD_PROGRESS, sid, upload_progress
      SuperUpload::FileManager.find_upload_progress(sid).should == upload_progress
      @redis.hset SuperUpload::FileManager::TOTAL_SIZE, sid, total_size
      SuperUpload::FileManager.find_total_size(sid).should == total_size
    end
    it "saves all attributes" do
      sid = "2"
      file_manager.sid = sid
      file_manager.save
      @redis.hget(SuperUpload::FileManager::PATH, sid).should == "path"
      @redis.hget(SuperUpload::FileManager::TOTAL_SIZE, sid).should == "total_size"
      @redis.hget(SuperUpload::FileManager::UPLOAD_PROGRESS, sid).should == "upload_progress"
      sid = "3"
      SuperUpload::FileManager.new(:sid => sid, :path => path).save
      @redis.hget(SuperUpload::FileManager::PATH, sid).should == path
      @redis.hget(SuperUpload::FileManager::TOTAL_SIZE, sid).should == ""
      @redis.hget(SuperUpload::FileManager::UPLOAD_PROGRESS, sid).should == ""
    end
  end

end