# coding: utf-8
class DictsAPI < Grape::API
  format :json

  resource 'dicts' do
    params do
      requires :text, type: String
    end
    get 'segments' do
      segments = Segment.get(params[:text], optimize: params.optimize)
      status 200
      {segments: segments}
    end

    params do
      requires :text, type: String
    end
    get 'synonyms' do
      synonyms = Synonym.get(params[:text])
      status 200
      {synonyms: synonyms}
    end

    params do
      requires :text, type: String
    end
    get 'homonyms' do
      hononyms = Homonym.get(params[:text])
      status 200
      {hononyms: hononyms}
    end
  end
end
