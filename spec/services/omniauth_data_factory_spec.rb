require "rails_helper"

describe OmniauthDataFactory do
  describe ".build" do
    subject { described_class.build(provider, {}) }

    context "when provider is accessible" do
      let(:provider) { "facebook" }

      it { is_expected.to be_an_instance_of(OmniauthData::Facebook) }
    end

    context "when provider is NOT accessible" do
      let(:provider) { "another_provider" }

      it { is_expected.to be_an_instance_of(OmniauthData::Base) }
    end
  end
end
