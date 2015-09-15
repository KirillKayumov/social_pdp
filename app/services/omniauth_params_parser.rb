class OmniauthParamsParser
  attr_reader :params

  GENDERS = {
    0 => "",
    1 => "female",
    2 => "male"
  }

  def initialize(params)
    @params = params || {}
  end

  def for_session
    new_params = params.dup
    new_params["extra"] = raw_info
    new_params
  end

  def email
    info["email"]
  end

  def provider
    params["provider"]
  end

  def uid
    params["uid"]
  end

  def name
    params["info"]["name"]
  end

  def location
    params["info"]["location"]
  end

  def gender
    convert_gender(raw_info["sex"] || raw_info["gender"])
  end

  def birthday
    convert_birthday(raw_info["bdate"] || raw_info["birthday"])
  end

  def bio
    info["bio"] || raw_info["bio"] || raw_info["description"]
  end

  private

  def info
    params["info"]
  end

  def raw_info
    params["extra"]["raw_info"] || {}
  end

  def convert_gender(gender)
    GENDERS.key?(gender) ? GENDERS[gender] : gender
  end

  def convert_birthday(birthday)
    return birthday if birthday.blank?

    if provider == "facebook"
      Date.strptime(birthday, "%m/%d/%Y")
    else
      Date.parse(birthday)
    end
  end
end
