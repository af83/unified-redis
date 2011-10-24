require 'spec_helper'
require_relative '../lib/unified_redis'

shared_examples "unified_redis_sync" do
  before do
    @r = UnifiedRedis.new(redis)
    @r.del("chuck")
  end

  it "should be able to get/set" do
    @r.get("chuck") do |value|
      value.should == nil
    end
    @r.set("chuck", "norris")
    @r.get("chuck") do |value|
      value.should == 'norris'
    end
  end
end

shared_examples "unified_redis_async" do
  around(:each) do |example|
    EM.run do
      @r = UnifiedRedis.new(redis)
      @r.del("chuck", &example)
    end
  end

  it "should be able to get/set" do
    @r.get("chuck") do |values|
      values.should == nil
      @r.set("chuck", "norris") do
        @r.get("chuck") do |value|
          value.should == 'norris'
          EM.stop
        end
      end
    end
  end
end

describe "Unified::Redis" do
  context "with redis-rb" do
    it_should_behave_like "unified_redis_sync" do
      let (:redis) { Redis.new }
    end
  end

  context "with em-redis" do
    it_should_behave_like "unified_redis_async" do
      let (:redis) {
        r = EM::Protocols::Redis.connect
        r.errback do |code|
          puts "redis error"
        end
        r
      }
    end
  end
end
