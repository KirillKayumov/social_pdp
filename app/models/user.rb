class User < ActiveRecord::Base
  OMNIAUTH_PROVIDERS = %i(
    facebook
    vkontakte
    twitter
    instagram
    github
    google_oauth2
  )

  PROFILE_ATTRIBUTES = %i(
    name
    location
    gender
    birthday
    bio
  )

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: OMNIAUTH_PROVIDERS

  has_many :accounts, dependent: :destroy

  def update_profile(auth_data)
    PROFILE_ATTRIBUTES.each do |attribute|
      value = auth_data.public_send(attribute)
      assign_profile_attribute(attribute, value)
    end

    save
  end

  private

  def assign_profile_attribute(attribute, value)
    self[attribute] = value if self[attribute].blank? && value.present?
  end
end
