class CreateUser
  include Interactor

  def call
    user = User.new(email: auth_data.email, password: Devise.friendly_token)

    if user.save
      context.user = user
    else
      context.fail!
    end
  end

  private

  def auth_data
    context.auth_data
  end
end
