# coding: utf-8
require "spec_helper"

describe DictsAPI do
  include Rack::Test::Methods

  def app
    DictsAPI
  end

  context "POST /dicts/segments" do
    context "without optimize param" do
      before do
        Segment.add_stopword "，"
        Segment.add_stopword "我"
        post "/dicts/segments", text: "我喜欢玩，我喜欢睡觉"
      end

      it "should return status 200" do
        expect(last_response.status).to eq 200
      end

      it "should get segments as JSON" do
        expect(MultiJson.load(last_response.body)).to eq({"segments" => ["我", "喜欢", "玩", "，", "我", "喜欢", "睡觉"]})
      end
    end

    context "with optimize param" do
      before do
        Segment.add_stopword "，"
        Segment.add_stopword "我"
        post "/dicts/segments", text: "我喜欢玩，我喜欢睡觉", optimize: true
      end

      it "should return status 200" do
        expect(last_response.status).to eq 200
      end

      it "should get segments as JSON" do
        expect(MultiJson.load(last_response.body)).to eq({"segments" => ["喜欢", "玩", "睡觉"]})
      end
    end
  end

  context "POST /dicts/synonyms" do
    before do
      Synonym.set("本来", "原本")
      Synonym.set("原先", "本来")
      Synonym.set("本来", "原来")
      post "/dicts/synonyms", text: "本来"
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

  context "POST /dicts/homonyms" do
    before do
      Word.add("富裕")
      Word.add("馥郁")
      Homonym.add_pinyin("富", "fù")
      Homonym.add_pinyin("裕", "yù")
      Homonym.add_pinyin("馥", "fù")
      Homonym.add_pinyin("郁", "yù")
      Homonym.prepare_pinyin_for_words
      post "/dicts/homonyms", text: "富裕"
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
