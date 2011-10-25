# encoding: utf-8
module UnifiedRedis
  module Adapter
    # List of available adapters
    def self.adapters
      {
        'Redis'                                               => "Redis",
        'EventMachine::Protocols::Redis::EM_CONNECTION_CLASS' => 'EMRedis'
      }
    end

    def self.get_adapter(redis)
      adapter = self.adapters[redis.class.to_s]
      raise "Adapter not found" if adapter.nil?
      require "unified_redis/adapters/#{adapter.downcase}"
      Adapter.const_get(adapter).new(redis)
    end
  end
end
