require 'unified_redis/adapter'

module UnifiedRedis
  def self.new(redis)
    Adapter.get_adapter(redis)
  end
end
