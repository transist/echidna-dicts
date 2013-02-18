# coding: utf-8
require 'benchmark'
require 'rmmseg'
load 'app/models/segment.rb'

RMMSeg::Dictionary.load_dictionaries

Benchmark.bm(70) do |bm|
  bm.report("Segments") do
    10.times do
      Segment.get("在此你所见的一切视觉，影像，声音，先锋和经典瞬间都是converse100年来的传奇成就，而我们正在变得更加强大。所有这 些成就都离不开我们最引以为傲得四大经典：chuck taylor all star，star chevron,jack purcell和one star，它们在音乐，体育，艺术和潮流历史上无可替代的独特地位，都在诉说converse永恒不灭的原创力和叛逆精神")
    end
  end
end
