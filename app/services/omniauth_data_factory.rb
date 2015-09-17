class OmniauthDataFactory
  DEFAULT_PROVIDER = OmniauthData::Base

  PROVIDERS = {
    "facebook" => OmniauthData::Facebook,
    "vkontakte" => OmniauthData::Vkontakte,
    "twitter" => OmniauthData::Twitter,
    "instagram" => OmniauthData::Instagram,
    "github" => OmniauthData::Github,
    "google_oauth2" => OmniauthData::Google
  }

  def self.build(provider, data)
    (PROVIDERS[provider] || DEFAULT_PROVIDER).new(data)
  end
end
