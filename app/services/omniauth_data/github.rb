class OmniauthData::Github < OmniauthData::Base
  def bio
    raw_info["bio"]
  end
end
