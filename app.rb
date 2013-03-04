# coding: utf-8
echidna_env = ENV['ECHIDNA_ENV'] || "development"

require "bundler"
Bundler.require(:default, echidna_env)
require "goliath"

dicts_ip = ENV['ECHIDNA_DICTS_IP'] || "0.0.0.0"
dicts_port = app_port('dicts')
dicts_daemon = ENV['ECHIDNA_DICTS_DAEMON'] == 'true'

ARGV.replace ["-e", echidna_env, "-a", dicts_ip, "-p", dicts_port]
ARGV << "-d" if dicts_daemon
ARGV << "-sv" if echidna_env == "development"

RMMSeg::Dictionary.load_dictionaries
$logger.notice("load dictionaries")

class App < Goliath::API
  def response(env)
    DictsAPI.call(env)
  end
end
