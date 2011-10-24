# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'unified_redis/version'

Gem::Specification.new do |s|
  s.name         = "unified-redis"
  s.version      = UnifiedRedis::VERSION
  s.authors      = ["François de Metz"]
  s.email        = "fdemetz@af83.com"
  s.homepage     = "https://github.com/af83/unified-redis"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files        = `git ls-files app lib`.split("\n")
  s.require_path = 'lib'
  s.add_dependency "eventmachine", "~> 1.0.0.beta"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "redis"
  s.add_development_dependency "em-redis"
end
