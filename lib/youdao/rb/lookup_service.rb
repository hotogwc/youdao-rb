require "faraday"
require "digest"
require "faraday_middleware"
require "youdao/rb/secret_service"

class YoudaoRBError < StandardError
end
class LookupService
  def self.translate word
    salt = rand(1..100).to_s
    app_id = SecretService.app_id
    key = SecretService.key
    raise YoudaoRBError, "AppID or Key is blank, please set using config command" if app_id.nil? || key.nil?
    str = app_id + word + salt + key
    sign = Digest::MD5.hexdigest(str)
    conn = Faraday.new(:url => 'http://openapi.youdao.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :json, :content_type => /\bjson$/

      faraday.adapter  Faraday.default_adapter
    end

    from = "zh-CHS"
    to = "EN"

    response = conn.get '/api', { :q => word,
                                  :from => from,
                                  :to => to,
                                  :appKey => app_id,
                                  :salt => salt,
                                  :sign => sign }

    response.body["basic"] ? response.body["basic"]["explains"] : "没找到结果"

  end
end
