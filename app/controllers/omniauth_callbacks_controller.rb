class OmniauthCallbacksController < ApplicationController
  def facebook
    result = OmniAuthenticator.call(auth_data)
    result.user.remember_me = true

    sign_in_and_redirect(result.user)
  end

  alias_method :vkontakte, :facebook

  private

  def auth_data
    request.env["omniauth.auth"]
  end
end
