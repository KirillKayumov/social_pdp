class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if auth_data.present?
        ConnectAccount.call(auth_data: auth_data, user: resource)
        clear_session
      end
    end
  end
end
