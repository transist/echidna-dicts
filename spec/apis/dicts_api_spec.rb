# coding: utf-8
require "spec_helper"

describe DictsAPI do
  include Rack::Test::Methods

  def app
    DictsAPI
  end

  context "POST /v1/dicts/segments" do
    before do
      post "/v1/dicts/segments", text: "我在睡觉"
    end

    it "should return status 200" do
      expect(last_response.status).to eq 200
    end

    it "should get segments as JSON" do
      expect(MultiJson.load(last_response.body)).to eq({"segments" => ["我","在","睡觉"]})
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
end
