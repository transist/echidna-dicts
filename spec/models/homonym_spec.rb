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
end
