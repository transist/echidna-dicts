# coding: utf-8
module Dicts
  module Parser
    class ChinesePinyinParser
      DICT_FILENAME = 'dicts/Mandarin.dat'

      def parse
        File.open(DICT_FILENAME, 'r') do |file|
          file.lines.each do |line|
            char_hex, pinyin = line.split(' ')
            char = [char_hex.hex].pack("U")
            Homonym.add_pinyin(char, pinyin)
          end
        end
      end
    end
  end
end
