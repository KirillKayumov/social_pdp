class ConnectAccount
  include Interactor

  def call
    account = user.accounts.build(account_params)

    if account.save
      user.update_profile(auth_data)
    else
      context.fail!
    end
  end

  private

  def auth_data
    context.auth_data
  end

  def user
    context.user
  end

  def account_params
    {
      provider: auth_data.provider,
      uid: auth_data.uid,
      url: auth_data.url
    }
  end
end
