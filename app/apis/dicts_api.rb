# coding: utf-8
class DictsAPI < Grape::API
  format :json

  params do
    requires :text, type: String
  end
  resource 'dicts' do
    post 'segments' do
      algor = RMMSeg::Algorithm.new(params[:text])
      segments = []
      loop do
        tok = algor.next_token
        break if tok.nil?
        segments << tok.text
      end
      status 200
      {segments: segments}
    end

    params do
      requires :text, type: String
    end
    post 'synonyms' do
      $redis.smembers params[:text]
    end
  end
end
