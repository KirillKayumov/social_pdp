FactoryGirl.define do
  factory :account do
    provider "facebook"
    uid "123456"
    user
  end
end
