# UnifiedRedis

A unified redis interface for `redis-rb` and `em-redis`.

## Why ?

If you have some library which is used by both asynchronous and synchronous code, you would probably the same API.

For example, we have a stats module in production. We increment values inside a code running with EventMachine, but we expose data with a web frontend.

The common denominator between asynchronous and synchronous is blocks. UnifiedRedis allows you to use the same API with either `redis-rb` and `em-redis`.

## Install

Install with Rubygems:

    gem install unified-redis

If you use bundler, add it to your Gemfile:

    gem "unified-redis", "~> 0.0.1"

## Usage

If you want to use `redis-rb`:

```ruby
require 'unified-redis'

unified = UnifiedRedis.new(Redis.new)
unified.get("chuck") do |response|
    puts response
end
```

The same API is available with `em-redis`:

```ruby
require 'unified-redis'

EM.run do
  unified = UnifiedRedis.new(EM::Protocols::Redis.connect)
  unified.get("chuck") do |response|
    puts response
  end
end
```

## TODO

* compatibility with redis-namespace

## Tests

    bundle install
    rake

## License

MIT License

Copyright (C) 2011 by af83
