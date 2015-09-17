class OmniauthData::Base
  attr_reader :data

  def initialize(data)
    @data = data || {}
  end

  def provider
    data["provider"]
  end

  def uid
    data["uid"]
  end

  def email
    info["email"]
  end

  def name
    info["name"]
  end

  def location
    info["location"]
  end

  def gender
    raw_info["gender"]
  end

  def nickname
    raw_info["nickname"]
  end

  def url
    urls[provider.capitalize]
  end

  def for_session
    data
  end

  def birthday
  end

  def bio
  end

  protected

  def info
    data["info"]
  end

  def raw_info
    data["extra"]["raw_info"] || {}
  end

  def urls
    info["urls"]
  end
end
