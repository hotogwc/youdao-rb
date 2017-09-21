require "youdao/rb/version"
require "youdao/rb/lookup_service"
require "youdao/rb/color_service"
require "youdao/rb/secret_service"
require "thor"
require "awesome_print"

module Youdao
  class Lookup < Thor
    desc "lookup [word]", "look up a word in youdao"
    def lookup word
      puts "\n"
      begin
        LookupService.translate(word).each { |e| puts ColorService.add_color_to_string(e) }
      rescue YoudaoRBError
        puts "AppID or Key is blank, please set using config command"
      end
      puts "\n"
    end

    desc "config [app_id] [key]", "config your youdao appid and appkey"
    def config(app_id, key)
      SecretService.save_secret(app_id, key)
      puts "your app_id #{app_id}, key #{key} have been set"
    end
  end
end
