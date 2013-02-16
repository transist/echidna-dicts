# coding: utf-8
ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

%w(config/initializers/*.rb app/models/*.rb app/apis/*.rb).each do |dir|
  Dir[dir].each { |file| require_relative "../#{file}" }
end

module RSpec::Core
  class Reporter
    alias_method :original_report, :report

    def report(expected_example_count, seed=nil, &block)
      if EM.reactor_running?
        original_report expected_example_count, seed, &block
      else
        result = nil
        EM.synchrony do
          require_relative "../config/app.rb"
          result = original_report expected_example_count, seed, &block
          EM.stop
        end
        result
      end
    end
  end
end

RMMSeg::Dictionary.load_dictionaries

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.after do
    $redis.flushdb
  end
end
