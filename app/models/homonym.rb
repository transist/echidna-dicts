# coding: utf-8
class Homonym
  class <<self
    def get(word)
      word.each_char.inject([]) { |result, char| result = result.multiple(chars(char)); result }
    end

    def add_pinyin(char, pinyin)
      $redis.sadd char_to_pinyin_key(char), pinyin
      $redis.sadd pinyin_to_char_key(pinyin), char
    end

    private
    def chars(char)
      chars = []
      $redis.smembers(char_to_pinyin_key(char)).each do |pinyin|
        chars += $redis.smembers(pinyin_to_char_key(pinyin)).reject { |c| c == char }
      end
      chars
    end

    def char_to_pinyin_key(char)
      "c2py/#{char}"
    end

    def pinyin_to_char_key(pinyin)
      "py2c/#{pinyin}"
    end
  end
end
