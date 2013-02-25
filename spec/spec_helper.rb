# coding: utf-8
dicts_env = ENV['ECHIDNA_DICTS_ENV'] || "test"
redis_host = ENV['ECHIDNA_REDIS_HOST'] || "127.0.0.1"
redis_port = ENV['ECHIDNA_REDIS_PORT'] || "6379"
redis_namespace = ENV['ECHIDNA_REDIS_NAMESPACE'] || "e:t"

require "bundler"
Bundler.require(:default, dicts_env)

%w(config/initializers/*.rb app/models/*.rb app/apis/*.rb).each do |dir|
  Dir[dir].each { |file| require_relative "../#{file}" }
end

$redis = Redis::Namespace.new(redis_namespace, redis: Redis.new(host: redis_host, port: redis_port, driver: "hiredis"))

def flush_redis
  $redis.keys("*").each do |key|
    $redis.del key
  end
end

module RSpec::Core
  class Reporter
    alias_method :original_report, :report

    def report(expected_example_count, seed=nil, &block)
      if EM.reactor_running?
        original_report expected_example_count, seed, &block
      else
        result = nil
        EM.synchrony do
          require_relative "../config/app.rb"
          result = original_report expected_example_count, seed, &block
          EM.stop
        end
        result
      end
    end
  end
end

RMMSeg::Dictionary.load_dictionaries

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.after do
    flush_redis
  end
end
