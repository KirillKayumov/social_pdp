require "rails_helper"

describe CreateUser do
  describe ".call" do
    def do_call
      described_class.call(auth_data: auth_data)
    end

    subject(:context) { do_call }

    context "when auth data is correct" do
      let(:auth_data) { double(:auth_data, email: "new_user@example.com") }
      let(:user) { double(:user, save: true) }

      it { is_expected.to be_success }

      it "creates user" do
        expect { do_call }.to change { User.count }.by(1)
      end

      it "stores user in context" do
        allow(User).to receive(:new).and_return(user)

        expect(context.user).to eq(user)
      end
    end

    context "when auth data is incorrect" do
      let(:auth_data) { double(:auth_data, email: nil) }

      it { is_expected.to be_failure }

      it "does NOT create user" do
        expect { do_call }.not_to change { User.count }
      end
    end
  end
end
