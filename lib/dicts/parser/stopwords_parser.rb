# coding: utf-8
module Dicts
  module Parser
    class StopwordsParser
      DICT_FILENAME = 'dicts/chinese_stopwords.txt'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            Segment.add_stopword(line.strip)
          end
        end
      end
    end
  end
end
