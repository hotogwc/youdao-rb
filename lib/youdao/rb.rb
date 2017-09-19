require "youdao/rb/version"
require "youdao/rb/lookup_service"
require "youdao/rb/color_service"
require "thor"
require "awesome_print"
module Youdao
  class Lookup < Thor
    desc "lookup [word]", "look up a word in youdao"
    def lookup word
      puts "\n"
      LookupService.translate(word).each { |e| puts ColorService.add_color_to_string(e) }
      puts "\n"
    end
  end
end
