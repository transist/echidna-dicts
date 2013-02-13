# coding: utf-8
module Dicts
  module Parser
    class SynonymsDictParser
      DICT_FILENAME = 'dicts/10000_synonyms.txt'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            p line.strip.split(',')
          end
        end
      end
    end
  end
end
