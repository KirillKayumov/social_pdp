require "rails_helper"

describe OmniauthDataFactory do
  describe ".build" do
    let(:provider) { "facebook" }

    subject { described_class.build(provider, {}) }

    it { is_expected.to be_an_instance_of(OmniauthData::Facebook) }
  end
end
