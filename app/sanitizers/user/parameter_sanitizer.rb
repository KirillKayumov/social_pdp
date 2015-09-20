class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    USER_PARAMS = %i(
      name
      location
      gender
      bio
      birthday
      email
      password
      password_confirmation
    )

    def sign_up
      default_params.permit(USER_PARAMS)
    end

    def account_update
      default_params.permit(USER_PARAMS, :current_password)
    end
  end
end
