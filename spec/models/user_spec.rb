require "rails_helper"

describe User do
  let(:user) { create :user, name: "" }
  let(:auth_data) { double(:auth_data, name: "new name").as_null_object }

  describe "#update_profile" do
    before { user.update_profile(auth_data) }

    it "updates the attribute" do
      expect(user.reload.name).to eq("new name")
    end

    context "when attribute is filled" do
      let(:user) { create :user, name: "name" }

      it "does NOT update the attribute" do
        expect(user.reload.name).to eq("name")
      end
    end
  end
end
