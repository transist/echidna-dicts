class Segment
  def self.get(text)
    algorithm = RMMSeg::Algorithm.new(text)
    segments = []
    loop do
      token = algorithm.next_token
      break if token.nil?
      segments << token.text
    end
    segments
  end
end
