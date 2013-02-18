# coding: utf-8
class Segment
  class <<self
    def get(text, options={})
      algorithm = RMMSeg::Algorithm.new(text)
      segments = []
      loop do
        token = algorithm.next_token
        break if token.nil?
        if options[:optimize]
          segments << token.text unless stopword?(token.text)
        else
          segments << token.text
        end
      end
      if options[:optimize]
        segments.uniq.sort
      else
        segments
      end
    end

    def add_stopword(word)
      $redis.sadd stopword_key, word
    end

    def flush
      $redis.del stopword_key
    end

    private
    def stopword?(word)
      $redis.sismember stopword_key, word
    end

    def stopword_key
      "stopwords"
    end
  end
end
