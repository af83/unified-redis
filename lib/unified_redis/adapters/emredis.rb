# encoding: utf-8
module UnifiedRedis
  module Adapter
    class EMRedis
      def initialize(redis)
        @redis = redis
      end

      def method_missing(command, *args, &block)
        @redis.send(command, *args, &block)
      end
    end
  end
end
