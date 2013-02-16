# coding: utf-8
require "spec_helper"

describe Homonym do
  context "#add_pinyin" do
    before do
      Homonym.add_pinyin("我", "wǒ")
    end

    it "should add char_to_pinyin key" do
      expect($redis.smembers("c2py/我")).to be_include "wǒ"
    end

    it "should add pinyin_to_char key" do
      expect($redis.smembers("py2c/wǒ")).to be_include "我"
    end
  end

  context "#get" do
    before do
      Homonym.add_pinyin("富", "fù")
      Homonym.add_pinyin("裕", "yù")
      Homonym.add_pinyin("馥", "fù")
      Homonym.add_pinyin("郁", "yù")
    end

    it "should get homonyms" do
      expect(Homonym.get("富裕")).to be_include "馥郁"
      expect(Homonym.get("馥郁")).to be_include "富裕"
    end
  end
end
