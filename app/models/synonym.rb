class Synonym
  class <<self
    def get(text)
      $redis.smembers text
    end

    def set(word1, word2)
      $redis.sadd key(word1), word2
      $redis.sadd key(word2), word1
    end

    def key(text)
      "synonym/#{text}"
    end
  end
end
