# coding: utf-8
streaming_env = ENV['ECHIDNA_STREAMING_ENV'] || "development"

require 'bundler'
Bundler.require(:default, streaming_env)

RMMSeg::Dictionary.load_dictionaries
$logger.notice("load dictionaries")

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