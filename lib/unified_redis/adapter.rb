require 'redis'
require 'em-redis'

module UnifiedRedis
  module Adapter
    def self.backends
      {
        'Redis'                                               => "Redis",
        'EventMachine::Protocols::Redis::EM_CONNECTION_CLASS' => 'EMRedis'
      }
    end

    class Redis
      def initialize(redis)
        @redis = redis
      end

      def call(command, *args)
        *result = @redis.send(command, *args)
        yield *result if block_given?
        return *result
      end
    end

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
