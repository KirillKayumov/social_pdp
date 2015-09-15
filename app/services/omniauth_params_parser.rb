class OmniauthParamsParser
  attr_reader :params

  GENDERS = {
    0 => "",
    1 => "female",
    2 => "male"
  }

  PROFILE_ATTRIBUTES = %w(
    sex
    gender
    bdate
    birthday
    bio
    description
  )

  PROVIDERS = {
    "facebook" => "Facebook",
    "vkontakte" => "Vkontakte",
    "twitter" => "Twitter",
    "github" => "GitHub",
    "google_oauth2" => "Google"
  }

  def initialize(params = {})
    @params = params
  end

  def for_session
    new_params = params.dup
    new_params["extra"] = { "raw_info" => raw_info_for_session }
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
    info["name"]
  end

  def location
    info["location"]
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

  def url
    urls[PROVIDERS[provider]] || default_url
  end

  def urls
    info["urls"] || {}
  end

  def nickname
    info["nickname"]
  end

  private

  def info
    params["info"]
  end

  def raw_info
    params["extra"]["raw_info"] || {}
  end

  def raw_info_for_session
    raw_info.select { |key| PROFILE_ATTRIBUTES.include?(key) }
  end

  def convert_gender(gender)
    GENDERS.fetch(gender, gender)
  end

  def convert_birthday(birthday)
    return birthday if birthday.blank?

    if provider == "facebook"
      Date.strptime(birthday, "%m/%d/%Y")
    else
      Date.parse(birthday)
    end
  end

  def default_url
    "http://#{provider}.com/#{nickname}"
  end
end
