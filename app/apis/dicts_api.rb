# coding: utf-8
class DictsAPI < Grape::API
  format :json

  resource 'dicts' do
    params do
      requires :text, type: String
    end
    get 'segments' do
      segments = Segment.get(params[:text], optimize: params.optimize)
      {segments: segments}
    end

    params do
      requires :text, type: String
    end
    get 'synonyms' do
      synonyms = Synonym.get(params[:text])
      {synonyms: synonyms}
    end

    params do
      requires :text, type: String
    end
    get 'homonyms' do
      hononyms = Homonym.get(params[:text])
      {hononyms: hononyms}
    end

    params do
      requires :text, type: String
    end
    get 'hypernyms' do
      hypernyms = Hypernym.get(params[:text])
      {hypernyms: hypernyms}
    end
  end
end
