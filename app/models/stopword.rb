# coding: utf-8
class Stopword
  class <<self
    def filter(words)
      words.select { |word| !is?(word) }
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

    private
    def key
      "stopwords"
    end
  end
end
