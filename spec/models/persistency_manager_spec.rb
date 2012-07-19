require 'spec_helper'
require './app/models/persistency_manager.rb'

describe SuperUpload::PersistencyManager do
  let(:hash_name){ "hash_name" }
  let(:key){ "key" }
  let(:value){"value"}
  before :all do
    @redis = Redis.new
    @redis.flushdb
  end
  it "provides one single database connection" do
    redis_instance_one = SuperUpload::PersistencyManager.redis
    redis_instance_two = SuperUpload::PersistencyManager.redis
    redis_instance_one.should be redis_instance_two
  end
  it "saves hashes to the database" do
    SuperUpload::PersistencyManager.save_hash_value(hash_name, key, value)
    result_value = @redis.hget(hash_name, key)
    value.should == result_value
  end
  it "finds hashes in the database" do
    @redis.hset(hash_name, key, value)
    result_value = SuperUpload::PersistencyManager.find_hash_value(hash_name, key)
    value.should == result_value
  end
end