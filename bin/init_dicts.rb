# coding: utf-8
dicts_env = ENV['ECHIDNA_DICTS_ENV'] || "development"

require "bundler"
Bundler.require(:default, dicts_env.to_sym)

require "msworddoc-extractor"

if ENV["FORCE_FLUSH"]
  Homonym.flush
  Stopword.flush
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
puts 'Dicts parsed successfuly'
