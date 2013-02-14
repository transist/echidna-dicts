# coding: utf-8
module Dicts
  module Parser
    class SynonymsDictParser
      DICT_FILENAME = 'dicts/10000_synonyms.txt'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            word1, word2 = line.strip.split(',')
            Synonym.set(word1, word2)
          end
        end
      end
    end
  end
end
