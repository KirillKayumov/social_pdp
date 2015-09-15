class RegistrationsController < Devise::RegistrationsController
  include Authentication

  after_action :clear_session, only: :create

  def create
    super do |resource|
      authenticate_user(resource) if resource.persisted? && use_omniauth?
    end
  end
end
