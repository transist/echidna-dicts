# coding: utf-8
require 'bundler'
Bundler.require(:default, ENV['ECHIDNA_STREAMING_ENV'] || "development")

RMMSeg::Dictionary.load_dictionaries
$logger.notice("load dictionaries")

# redis-cli lpush e:d:dicts/messages '{"type":"segment","body":{"text":"我是中国人"}}'
# redis-cli lpush e:d:dicts/messages '{"type":"stopword","body":{"group_id":"group-1","user_id":"user-1","user_type":"tencent"}}'
while true
  $redis.incr "dicts/messages/incoming"
  raw_message = $redis.brpop "dicts/messages", 0
  $logger.notice("dicts receive message: #{raw_message.last.gsub('%', '%%')}")
  message = MultiJson.decode raw_message.last
  case message["type"]
  when "segment"
    words = Segment.get message["body"].delete("text")
    $redis.lpush "dicts/messages", MultiJson.encode(type: "stopword", body: message["body"].merge(words: words) )
  when "stopword"
    words = Stopword.filter message["body"].delete("words")
    $redis.lpush "streaming/messages", MultiJson.encode(type: "add_words", body: message["body"].merge(words: words) )
  # TODO: log error when unhandled message type
  end
  $redis.incr "dicts/messages/outgoing"
end
