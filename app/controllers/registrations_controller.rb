class RegistrationsController < Devise::RegistrationsController
  after_action :clear_session, only: :create

  def create
    super do |resource|
      ConnectAccount.call(auth_data: auth_data, user: resource) if resource.persisted? && auth_data.present?
    end
  end

  private

  def after_update_path_for(_resource)
    edit_user_registration_path
  end
end
