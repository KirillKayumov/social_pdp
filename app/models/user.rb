class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :vkontakte, :twitter]

  has_many :accounts, dependent: :destroy

  accepts_nested_attributes_for :accounts

  def full_name_with_email
    "#{self[:full_name]} (#{email})"
  end
end
