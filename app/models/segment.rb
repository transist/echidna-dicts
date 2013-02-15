# coding: utf-8
class Segment
  class <<self
    def get(text)
      algorithm = RMMSeg::Algorithm.new(text)
      segments = []
      loop do
        token = algorithm.next_token
        break if token.nil?
        segments << token.text
      end
      segments
    end

    def add_stopword(word)
      $redis.sadd stopword_key, word
    end

    def stopword_key
      "stopwords"
    end
  end
end
