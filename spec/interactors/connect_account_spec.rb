require "rails_helper"

describe ConnectAccount do
  describe ".call" do
    def do_call
      described_class.call(auth_data: auth_data, user: user)
    end

    let(:user) { create :user }

    subject(:context) { do_call }

    before do
      allow(user).to receive(:update_profile).and_return(true)
    end

    context "when auth data is correct" do
      let(:auth_data) { double(:auth_data, provider: "facebook", uid: "123456", url: "") }

      it { is_expected.to be_success }

      it "creates account" do
        expect { do_call }.to change { user.accounts.count }.by(1)
      end

      it "updates user's profile" do
        do_call

        expect(user).to have_received(:update_profile).with(auth_data)
      end
    end

    context "when auth data is incorrect" do
      let(:auth_data) { double(:auth_data, provider: nil, uid: "123456", url: "") }

      it { is_expected.to be_failure }

      it "does NOT create account" do
        expect { do_call }.not_to change { user.accounts.count }
      end

      it "does NOT update user's profile" do
        do_call

        expect(user).not_to have_received(:update_profile)
      end
    end
  end
end
