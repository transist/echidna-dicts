# coding: utf-8
class Homonym
  class <<self
    def get(text)
      $redis.smembers key(text)
    end

    def add_pinyin(char, pinyin)
      $redis.sadd char_to_pinyin_key(char), pinyin
      $redis.sadd pinyin_to_char_key(pinyin), char
    end

    def char_to_pinyin_key(char)
      "c2py/#{char}"
    end

    def pinyin_to_char_key(pinyin)
      "py2c/#{pinyin}"
    end
  end
end

