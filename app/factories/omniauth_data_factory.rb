class OmniauthDataFactory
  PROVIDERS = {
    "facebook" => OmniauthParams::Facebook,
    "vkontakte" => OmniauthParams::Vkontakte,
    "twitter" => OmniauthParams::Twitter,
    "instagram" => OmniauthParams::Instagram,
    "github" => OmniauthParams::Github,
    "google_oauth2" => OmniauthParams::Google
  }

  def self.build(provider, data)
    PROVIDERS[provider].new(data)
  end
end
