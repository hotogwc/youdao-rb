require 'json'
class SecretService
  @@secret_hash = {}
  def self.save_secret(app_id, key)
    File.open(File.join(ENV['HOME'] + "/.youdao-rb.json"), 'w') do |file|
      hash = {:appkey => key, :id => app_id}
      file.write hash.to_json
    end
  end

  def self.read_secret
    @@secret_hash = JSON.parse(IO.read(ENV['HOME'] + "/.youdao-rb.json"))
  end

  def self.app_id
    read_secret
    @@secret_hash["id"]
  end

  def self.key
    read_secret
    @@secret_hash["appkey"]
  end
end
