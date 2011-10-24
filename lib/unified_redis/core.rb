module UnifiedRedis
  class Core
    def initialize(redis)
      @redis = redis
      @adapter = Adapter.get_adapter(redis)
    end

    def method_missing(command, *args, &block)
      #return unless @redis.respond_to?(command.to_sym)
      @adapter.call(command, *args, &block)
    end
  end
end
