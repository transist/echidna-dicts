# coding: utf-8
dicts_env = ENV['ECHIDNA_DICTS_ENV'] || "development"
dicts_ip = ENV['ECHIDNA_DICTS_IP'] || "0.0.0.0"
dicts_port = ENV['ECHIDNA_DICTS_PORT'] || '9000'
dicts_daemon = ENV['ECHIDNA_DICTS_DAEMON'] == 'true'
$redis_host = ENV['ECHIDNA_REDIS_HOST'] || "127.0.0.1"
$redis_port = ENV['ECHIDNA_REDIS_PORT'] || "6379"
$redis_namespace = ENV['ECHIDNA_REDIS_NAMESPACE'] || "e:d"

ARGV.replace ["-e", dicts_env, "-a", dicts_ip, "-p", dicts_port]
ARGV << "-d" if dicts_daemon

require "bundler"
Bundler.require(:default, dicts_env.to_sym)
require "goliath"

%w(config/initializers/*.rb app/models/*.rb app/apis/*.rb).each do |dir|
  Dir[dir].each { |file| require_relative file }
end

RMMSeg::Dictionary.load_dictionaries

class App < Goliath::API
  def response(env)
    DictsAPI.call(env)
  end
end
