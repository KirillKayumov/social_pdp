class OmniAuthenticator
  include Interactor

  def call
    if account.present?
      context.user = account.user
    elsif user.present?
      connect_new_account(user)
      context.user = user
    else
      create_user_and_account
    end
  end

  private

  def auth_data
    context.auth_data
  end

  def account
    @account ||= Account.find_by(provider: auth_data.provider, uid: auth_data.uid)
  end

  def user
    @user ||= context.current_user || User.find_by(email: auth_data.email)
  end

  def connect_new_account(user)
    Account.create(provider: auth_data.provider, uid: auth_data.uid, user: user)
    user.update_profile(auth_data)
  end

  def create_user_and_account
    user = User.create(email: auth_data.email, password: Devise.friendly_token)

    if user.persisted?
      connect_new_account(user)
      context.user = user
    else
      context.fail!
    end
  end
end
