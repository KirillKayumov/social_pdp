class OmniauthData::Twitter < OmniauthData::Base
  def bio
    info["description"]
  end

  def for_session
    params.except("extra")
  end
end
