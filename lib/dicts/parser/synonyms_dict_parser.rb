# coding: utf-8
load 'config/app.rb'

module Dicts
  module Parser
    class SynonymsDictParser
      DICT_FILENAME = 'dicts/10000_synonyms.txt'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            word, synonym = line.strip.split(',')
            $redis.sadd(word, synonym)
            $redis.sadd(synonym, word)
          end
        end
      end
    end
  end
end
