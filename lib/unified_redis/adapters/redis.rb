# encoding: utf-8
module UnifiedRedis
  module Adapter
    class Redis
      def initialize(redis)
        @redis = redis
      end

      ::Redis.instance_methods(false).each do |command|
        define_method command do |*args, &block|
          result = @redis.send(command, *args)
          block.call(result) if block
          return result
        end
      end
    end
  end
end
