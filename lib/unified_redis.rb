require 'unified_redis/core'
require 'unified_redis/adapter'

module UnifiedRedis
  def self.new(redis)
    Core.new(redis)
  end
end
