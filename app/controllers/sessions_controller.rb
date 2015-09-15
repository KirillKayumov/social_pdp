class SessionsController < Devise::SessionsController
  include Authentication

  after_action :clear_session, only: :create

  def create
    super do |resource|
      authenticate_user(resource) if use_omniauth?
    end
  end
end
