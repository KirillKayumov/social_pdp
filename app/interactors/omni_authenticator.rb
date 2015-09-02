class OmniAuthenticator
  include Interactor

  def call
    if account.present?
      context.user = account.user
    elsif user.present?
      create_account(user)
      context.user = user
    else
      create_user_and_account
    end
  end

  private

  def account
    @account ||= Account.find_by(provider: context.provider, uid: context.uid)
  end

  def user
    @user ||= User.find_by(email: context.info.email)
  end

  def create_account(user)
    Account.create(provider: context.provider, uid: context.uid, user: user)
  end

  def create_user_and_account
    user = User.create(email: context.info.email, password: Devise.friendly_token)

    if user.persisted?
      create_account(user)
      context.user = user
    else
      context.fail!
    end
  end
end
