class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    result = authenticate_user(current_user)

    if result.success?
      result.user.remember_me = true
      sign_in_and_redirect(result.user)
    else
      session["auth_data"] = auth_data.for_session
      redirect_to new_user_registration_path
    end
  end

  alias_method :vkontakte, :facebook
  alias_method :twitter, :facebook
  alias_method :instagram, :facebook
  alias_method :github, :facebook
  alias_method :google_oauth2, :facebook
end
