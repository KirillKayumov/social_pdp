class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted? && auth_data.present?
        ConnectAccount.call(auth_data: auth_data, user: resource)
        clear_session
      end
    end
  end

  private

  def update_resource(resource, params)
    if password_present?(params)
      resource.update_with_password(params)
    else
      resource.update_without_password(params_without_password(params))
    end
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def password_present?(params)
    params[:password].present? ||
      params[:password_confirmation].present? ||
      params[:current_password].present?
  end

  def params_without_password(params)
    params.except(
      :password,
      :password_confirmation,
      :current_password
    )
  end
end
