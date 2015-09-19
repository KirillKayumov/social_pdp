class RegistrationsController < Devise::RegistrationsController
  include Authentication

  after_action :clear_session, only: :create

  def create
    super do |resource|
      ConnectAccount.call(auth_data: auth_data, user: resource) if resource.persisted? && use_omniauth?
    end
  end
end
