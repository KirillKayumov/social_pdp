class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    result = authenticate_user(current_user)

    if user_signed_in?
      flash[:notice] = "You have successfully linked social profile."
      redirect_to edit_user_registration_path
    elsif result.success?
      result.user.remember_me = true
      flash[:notice] = "You have successfully signed in using social profile."
      sign_in_and_redirect(result.user)
    else
      session["auth_data"] = auth_data.for_session
      flash[:alert] = "Social profile is not linked with any account. Sign in or sign up to link social profile with an account."
      redirect_to new_user_registration_path
    end
  end

  alias_method :vkontakte, :facebook
  alias_method :twitter, :facebook
  alias_method :instagram, :facebook
  alias_method :github, :facebook
  alias_method :google_oauth2, :facebook
end
