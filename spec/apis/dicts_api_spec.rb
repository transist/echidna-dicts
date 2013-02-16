# coding: utf-8
require "spec_helper"

describe DictsAPI do
  include Rack::Test::Methods

  def app
    DictsAPI
  end

  context "POST /v1/dicts/segments" do
    before do
      Segment.add_stopword "，"
      Segment.add_stopword "我"
      post "/v1/dicts/segments", text: "我喜欢玩，我喜欢睡觉"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get segments as JSON" do
      expect(MultiJson.load(last_response.body)).to eq({"segments" => ["喜欢", "玩", "睡觉"]})
    end
  end

  context "POST /v1/dicts/synonyms" do
    before do
      Synonym.set("本来", "原本")
      Synonym.set("原先", "本来")
      Synonym.set("本来", "原来")
      post "/v1/dicts/synonyms", text: "本来"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get segments as JSON" do
      synonyms = MultiJson.load(last_response.body)["synonyms"]
      expect(synonyms).to be_include "原本"
      expect(synonyms).to be_include "原先"
      expect(synonyms).to be_include "原来"
    end
  end

  context "POST /v1/dicts/homonyms" do
    before do
      Word.add("富裕")
      Word.add("馥郁")
      Homonym.add_pinyin("富", "fù")
      Homonym.add_pinyin("裕", "yù")
      Homonym.add_pinyin("馥", "fù")
      Homonym.add_pinyin("郁", "yù")
      Homonym.prepare_pinyin_for_words
      post "/v1/dicts/homonyms", text: "富裕"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get hononyms as JSON" do
      hononyms = MultiJson.load(last_response.body)["hononyms"]
      expect(hononyms).to be_include "馥郁"
    end
  end
end
