# coding: utf-8
echidna_env = ENV['ECHIDNA_ENV'] || "development"
dicts_ip = ENV['ECHIDNA_DICTS_IP'] || "0.0.0.0"
dicts_port = ENV['ECHIDNA_DICTS_PORT'] || '9000'
dicts_daemon = ENV['ECHIDNA_DICTS_DAEMON'] == 'true'

ARGV.replace ["-e", echidna_env, "-a", dicts_ip, "-p", dicts_port]
ARGV << "-d" if dicts_daemon
ARGV << "-sv" if echidna_env == "development"

require "bundler"
Bundler.require(:default, echidna_env)
require "goliath"

RMMSeg::Dictionary.load_dictionaries
$logger.notice("load dictionaries")

class App < Goliath::API
  def response(env)
    DictsAPI.call(env)
  end
end
