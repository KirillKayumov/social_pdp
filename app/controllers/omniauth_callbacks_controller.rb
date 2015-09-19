class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    perform_callback
  end

  def vkontakte
    perform_callback
  end

  def twitter
    perform_callback
  end

  def instagram
    perform_callback
  end

  def github
    perform_callback
  end

  def google_oauth2
    perform_callback
  end

  private

  def perform_callback
    if user_signed_in?
      connect_account_to_current_user
    else
      sign_in_with_existing_account ||
      sign_in_with_new_account ||
      sign_up_with_new_account
    end
  end

  def connect_account_to_current_user
    result = ConnectAccount.call(auth_data: auth_data, user: current_user)

    if result.success?
      flash[:notice] = I18n.t("flash.omniauth.connected")
    else
      flash[:alert] = I18n.t("flash.omniauth.already_connected")
    end

    redirect_to edit_user_registration_path
  end

  def sign_in_with_existing_account
    account = Account.find_by(provider: auth_data.provider, uid: auth_data.uid)

    if account.present?
      flash[:notice] = I18n.t("flash.omniauth.signed_in")
      sign_in_and_redirect(account.user)
    end
  end

  def sign_in_with_new_account
    user = User.find_by(email: auth_data.email)

    if user.present?
      ConnectAccount.call(auth_data: auth_data, user: user)
      flash[:notice] = I18n.t("flash.omniauth.signed_in")
      sign_in_and_redirect(user)
    end
  end

  def sign_up_with_new_account
    result = AuthenticateNewUser.call(auth_data: auth_data)

    if result.success?
      flash[:notice] = I18n.t("flash.omniauth.signed_up")
      sign_in_and_redirect(result.user)
    else
      session["auth_data"] = auth_data.for_session
      flash[:alert] = I18n.t("flash.omniauth.not_linked")
      redirect_to new_user_registration_path
    end
  end
end
