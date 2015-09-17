module Authentication
  extend ActiveSupport::Concern

  private

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  def auth_data
    data = request.env["omniauth.auth"] || session["auth_data"] || {}
    provider = data["provider"]

    @_auth_data ||= OmniauthDataFactory.build(provider, data)
  end

  def authenticate_user(user)
    OmniAuthenticator.call(current_user: user, auth_data: auth_data)
  end

  def use_omniauth?
    auth_data.provider.present? && auth_data.uid.present?
  end

  def clear_session
    session.delete("auth_data")
  end
end
