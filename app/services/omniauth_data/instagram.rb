class OmniauthData::Instagram < OmniauthData::Base
  def bio
    info["bio"]
  end

  def url
    "http://instagram.com/#{nickname}"
  end
end
