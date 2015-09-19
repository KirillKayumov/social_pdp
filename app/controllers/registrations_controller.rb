class RegistrationsController < Devise::RegistrationsController
  after_action :clear_session, only: :create

  def create
    super do |resource|
      ConnectAccount.call(auth_data: auth_data, user: resource) if resource.persisted? && auth_data.present?
    end
  end
end
