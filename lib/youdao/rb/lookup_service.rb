require "faraday"
require "digest"
require "faraday_middleware"

AppID = "54011682991896b1"
Key = "txAnJPdqFhzCpaWK2aeaqMd7tKIFpQvA"
class LookupService
  def self.translate word
    salt = rand(1..100).to_s
    str = AppID + word + salt + Key
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
                                  :appKey => AppID,
                                  :salt => salt,
                                  :sign => sign }

    response.body["basic"] ? response.body["basic"]["explains"] : "没找到结果"

  end
end
