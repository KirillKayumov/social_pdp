class OmniAuthenticator
  include Interactor

  def call
    context.user =
      if account.present?
        account.user
      elsif user.present?
        create_account(user)
        user
      else
        new_user = create_user
        create_account(new_user)
        new_user
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

  def create_user
    User.create(email: context.info.email, password: Devise.friendly_token)
  end
end
