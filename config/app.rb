require "yaml"

redis_configs = YAML.load_file("config/redis.yml")[ENV["RACK_ENV"]]

$redis = EventMachine::Synchrony::ConnectionPool.new(size: redis_configs["pool"]) do
  Redis.new redis_configs.merge(driver: :synchrony)
end
