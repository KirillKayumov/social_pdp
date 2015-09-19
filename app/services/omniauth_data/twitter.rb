class OmniauthData::Twitter < OmniauthData::Base
  def bio
    info["description"]
  end

  def for_session
    data_copy = data.dup
    data_copy["extra"] = {}
    data_copy
  end
end
