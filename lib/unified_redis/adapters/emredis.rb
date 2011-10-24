module UnifiedRedis
  module Adapter
    class EMRedis
      def initialize(redis)
        @redis = redis
      end

      def call(command, *args, &block)
        @redis.send(command, *args, &block)
      end
    end
  end
end
