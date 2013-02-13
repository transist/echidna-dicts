# coding: utf-8
ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
require "goliath"

%w(app/models/*.rb app/helpers/*.rb app/apis/*.rb).each do |dir|
  Dir[dir].each { |file| require_relative file }
end

RMMSeg::Dictionary.load_dictionaries

class App < Goliath::API
  def response(env)
    DictsAPI.call(env)
  end
end
