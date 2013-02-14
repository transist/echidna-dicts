# coding: utf-8
class DictsAPI < Grape::API
  version "v1", using: :path
  format :json

  params do
    requires :text, type: String
  end
  resource 'dicts' do
    post 'segments' do
      segments = Segment.get(params[:text])
      status 200
      {segments: segments}
    end

    params do
      requires :text, type: String
    end
    post 'synonyms' do
      synonyms = Synonym.get(params[:text])
      status 200
      {synonyms: synonyms}
    end
  end
end
