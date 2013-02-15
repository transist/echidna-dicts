# coding: utf-8
require "spec_helper"

describe Segment do
  it "should get segments" do
    expect(Segment.get("我在睡觉").map { |segement| segement.force_encoding("UTF-8")}).to eq ["我","在","睡觉"]
  end

  it "should add stopword" do
    Segment.add_stopword "了"
    Segment.add_stopword "在"
    expect($redis.smembers("stopwords")).to be_include "了"
    expect($redis.smembers("stopwords")).to be_include "在"
  end
end
