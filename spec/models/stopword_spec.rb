# coding: utf-8
require "spec_helper"

describe Stopword do
  it "should filter stopwords" do
    Stopword.add "，"
    Stopword.add "我"

    expect(Stopword.filter(["我", "，", "中国"])).to eq ["中国"]
  end

  it "should add stopword" do
    Stopword.add "了"
    Stopword.add "在"
    expect($redis.smembers("stopwords")).to be_include "了"
    expect($redis.smembers("stopwords")).to be_include "在"
  end

  it "should check if it is a stopword" do
    Stopword.add "了"
    expect(Stopword).to be_is "了"
  end
end
