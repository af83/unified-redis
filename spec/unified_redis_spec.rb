require 'spec_helper'


shared_examples "unified_redis" do

  it "should be able to get/set" do
    @r.del("chuck") do
      @r.get("chuck") do |value|
        value.should == nil
        @r.set("chuck", "norris") do
          @r.get("chuck") do |value|
            value.should == 'norris'
            EM.stop if EM.reactor_running?
          end
        end
      end
    end
  end

end


describe "Unified::Redis" do
  context "with redis-rb" do
    before do
      @r = UnifiedRedis.new(Redis.new)
    end

    it_should_behave_like "unified_redis"
  end


  context "with em-redis" do
    around(:each) do |example|
      EM.run do
        redis = EM::Protocols::Redis.connect
        redis.errback do |code|
          puts "redis error"
        end
        @r = UnifiedRedis.new(redis)
        example.call
      end
    end

    it_should_behave_like "unified_redis"
  end
end
