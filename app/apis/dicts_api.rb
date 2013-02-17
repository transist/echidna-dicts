# coding: utf-8
class DictsAPI < Grape::API
  format :json

  resource 'dicts' do
    params do
      requires :text, type: String
    end
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

    params do
      requires :text, type: String
    end
    post 'homonyms' do
      hononyms = Homonym.get(params[:text])
      status 200
      {hononyms: hononyms}
    end
  end
end
