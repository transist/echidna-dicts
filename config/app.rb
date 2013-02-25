$redis = EventMachine::Synchrony::ConnectionPool.new(size: 2) do
  Redis::Namespace.new($redis_namespace, redis: Redis.new(host: $redis_host, port: $redis_prot, driver: "synchrony"))
end
