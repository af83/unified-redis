module UnifiedRedis
  class Core
    def initialize(redis)
      @redis = redis
      backend = Adapter.backends[redis.class.to_s]
      raise "Adapter not found" if backend.nil?
      @backend = Adapter.const_get(backend).new(redis)
    end

    def method_missing(command, *args, &block)
      #return unless @redis.respond_to?(command.to_sym)
      @backend.call(command, *args, &block)
    end
  end
end
