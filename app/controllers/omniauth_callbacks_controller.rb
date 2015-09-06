class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    result = OmniAuthenticator.call(auth_data)

    if result.success?
      result.user.remember_me = true
      sign_in_and_redirect(result.user)
    else
      redirect_to new_user_registration_path(provider: auth_data.provider, uid: auth_data.uid)
    end
  end

  alias_method :vkontakte, :facebook
  alias_method :twitter, :facebook
  alias_method :instagram, :facebook
  alias_method :github, :facebook
  alias_method :google_oauth2, :facebook

  private

  def auth_data
    request.env["omniauth.auth"].merge(current_user: current_user)
  end
end
