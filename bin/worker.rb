# coding: utf-8
streaming_env = ENV['ECHIDNA_STREAMING_ENV'] || "development"
redis_host = ENV['ECHIDNA_REDIS_HOST'] || "127.0.0.1"
redis_port = ENV['ECHIDNA_REDIS_PORT'] || "6379"
redis_namespace = ENV['ECHIDNA_REDIS_NAMESPACE'] || "e:d"

require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../..', __FILE__))

require 'bundler'
Bundler.require(:default, streaming_env)
require 'syslog'
$logger = Syslog.open("streaming worker", Syslog::LOG_PID | Syslog::LOG_CONS, Syslog::LOG_LOCAL3)

Dir[APP_ROOT.join("lib/helpers/*.rb")].each { |file| require_relative file }
Dir[APP_ROOT.join("app/models/*.rb")].each { |file| require_relative file }

RMMSeg::Dictionary.load_dictionaries
$logger.notice("load dictionaries")

$redis = Redis::Namespace.new(redis_namespace, redis: Redis.new(host: redis_host, port: redis_port, driver: "hiredis"))
$logger.notice("connect to redis: #{redis_host}:#{redis_port}/#{redis_namespace}")

# redis-cli lpush e:d:dicts/messages '{"type":"segment","body":{"text":"我是中国人"}}'
# redis-cli lpush e:d:dicts/messages '{"type":"stopword","body":{"group_id":"group-1","user_id":"user-1","user_type":"tencent"}}'
while true
  raw_message = $redis.brpop "dicts/messages", 0
  $logger.notice("dicts receive message: #{raw_message}")
  message = MultiJson.decode raw_message.last
  case message["type"]
  when "segment"
    words = Segment.get message["body"].delete("text")
    $redis.lpush "dicts/messages", MultiJson.encode(type: "stopword", body: message["body"].merge(words: words) )
  when "stopword"
    words = Stopword.filter message["body"].delete("words")
    $redis.lpush "streaming/messages", MultiJson.encode(type: "add_words", body: message["body"].merge(words: words) )
  end
end
