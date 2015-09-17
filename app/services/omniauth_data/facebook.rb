class OmniauthData::Facebook < OmniauthData::Base
  def birthday
    Date.strptime(raw_info["birthday"], "%m/%d/%Y")
  end

  def bio
    info["description"]
  end
end
