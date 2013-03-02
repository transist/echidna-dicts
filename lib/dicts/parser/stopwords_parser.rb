# coding: utf-8
module Dicts
  module Parser
    class StopwordsParser
      DICT_FILENAME = 'dicts/chinese_stopwords.txt'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            Stopword.add(line.strip)
          end
        end
      end
    end
  end
end
