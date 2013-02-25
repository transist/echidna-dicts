# coding: utf-8
require "spec_helper"

describe DictsAPI do
  include Rack::Test::Methods

  def app
    DictsAPI
  end

  context "GET /dicts/segments" do
    context "without optimize param" do
      before do
        Segment.add_stopword "，"
        Segment.add_stopword "我"
        get "/dicts/segments?text=#{URI.encode('我喜欢玩，我喜欢睡觉')}"
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
        get "/dicts/segments?text=#{URI.encode('我喜欢玩，我喜欢睡觉')}&optimize=true"
      end

      it "should return status 200" do
        expect(last_response.status).to eq 200
      end

      it "should get segments as JSON" do
        expect(MultiJson.load(last_response.body)).to eq({"segments" => ["喜欢", "玩", "睡觉"]})
      end
    end
  end

  context "GET /dicts/synonyms" do
    before do
      Synonym.set("本来", "原本")
      Synonym.set("原先", "本来")
      Synonym.set("本来", "原来")
      get "/dicts/synonyms?text=#{URI.encode('本来')}"
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

  context "GET /dicts/homonyms" do
    before do
      Word.add("富裕")
      Word.add("馥郁")
      Homonym.add_pinyin("富", "fù")
      Homonym.add_pinyin("裕", "yù")
      Homonym.add_pinyin("馥", "fù")
      Homonym.add_pinyin("郁", "yù")
      Homonym.prepare_pinyin_for_words
      get "/dicts/homonyms?text=#{URI.encode('富裕')}"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get hononyms as JSON" do
      hononyms = MultiJson.load(last_response.body)["hononyms"]
      expect(hononyms).to be_include "馥郁"
    end
  end

  context "GET /dicts/hypernyms" do
    before do
      Hypernym.set("凯恩斯主义", "宏观经济学")
      Hypernym.set("凯恩斯主义", "经济自由主义")
      get "/dicts/hypernyms?text=#{URI.encode('凯恩斯主义')}"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get hypernyms as JSON" do
      hypernyms = MultiJson.load(last_response.body)["hypernyms"]
      expect(hypernyms).to be_include "宏观经济学"
      expect(hypernyms).to be_include "经济自由主义"
    end
  end
end
