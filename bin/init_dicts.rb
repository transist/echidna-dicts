# coding: utf-8
dicts_env = ENV['ECHIDNA_DICTS_ENV'] || "development"
dicts_ip = ENV['ECHIDNA_DICTS_IP'] || "0.0.0.0"
dicts_port = ENV['ECHIDNA_DICTS_PORT'] || '9000'
$redis_host = ENV['ECHIDNA_REDIS_HOST'] || "127.0.0.1"
$redis_port = ENV['ECHIDNA_REDIS_PORT'] || "6379"
$redis_namespace = ENV['ECHIDNA_REDIS_NAMESPACE'] || "e:d"

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

require "bundler"
Bundler.require(:default, dicts_env.to_sym)
require "msworddoc-extractor"
require "dicts"
require_relative '../config/app'
require_relative '../config/initializers/array_hack.rb'

Dir["app/models/*.rb"].each { |file| require_relative "../#{file}" }

EM.synchrony do
  if ENV["FORCE_FLUSH"]
    Homonym.flush
    Segment.flush
    Synonym.flush
    Word.flush
    Hypernym.flush
  end
  # Dicts::Parser::ModernChineseDictParser.new.parse
  puts 'Parsing stopwords...'
  Dicts::Parser::StopwordsParser.new.parse
  puts 'Parsing synonyms...'
  Dicts::Parser::SynonymsDictParser.new.parse
  puts 'Parsing words...'
  Dicts::Parser::WordsDictParser.new.parse
  puts 'Parsing Chinese Pinyin...'
  Dicts::Parser::ChinesePinyinParser.new.parse
  Dicts::Parser::HypernymsDictParser.new.parse
  EM.stop
end
puts 'Dicts parsed successfuly'