class OmniauthData::Vkontakte < OmniauthData::Base
  GENDERS = {
    0 => "",
    1 => "female",
    2 => "male"
  }

  def gender
    GENDERS[raw_info["sex"]]
  end

  def birthday
    Date.parse(raw_info["bdate"])
  end
end
