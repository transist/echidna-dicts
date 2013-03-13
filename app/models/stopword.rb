# coding: utf-8
class Stopword
  class <<self
    def filter(words)
      words.select { |word| !single_character?(word) && !username?(word) && !is?(word) }
    end

    def add(word)
      $redis.sadd key, word
    end

    def flush
      $redis.del key
    end

    def is?(word)
      $redis.sismember key, word
    end

    def single_character?(word)
      word.length == 1
    end

    def username?(word)
      word[0] == '@'
    end

    private
    def key
      "stopwords"
    end
  end
end
