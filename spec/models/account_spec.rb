require "rails_helper"

describe Account do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :provider }
  it { is_expected.to validate_presence_of :uid }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_uniqueness_of(:provider).scoped_to(:uid) }
end
