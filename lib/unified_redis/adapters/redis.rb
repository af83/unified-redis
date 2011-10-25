# encoding: utf-8
module UnifiedRedis
  module Adapter
    class Redis
      def initialize(redis)
        redis.class.instance_methods(false).each do |command|
          self.class.instance_eval do
            define_method command do |*args|
              result = redis.send(command, *args)
              yield result if block_given?
              return result
            end
          end
        end
      end
    end
  end
end
