# coding: utf-8
require "spec_helper"

describe Segment do
  it "should get segments" do
    expect(Segment.get("我在睡觉").map { |segement| segement.force_encoding("UTF-8")}).to eq ["我","在","睡觉"]
  end
end
