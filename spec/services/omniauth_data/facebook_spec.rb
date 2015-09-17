require "rails_helper"

describe OmniauthData::Facebook do
  let(:auth_hash) do
    {
      "info" => {
        "description" => "My description"
      },
      "extra" => {
        "raw_info" => {
          "birthday" => "06/09/1995"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#birthday" do
    let(:date) { Date.parse("09/06/1995") }

    it "swaps day and month" do
      expect(parser.birthday).to eq(date)
    end
  end

  describe "#bio" do
    it { expect(parser.bio).to eq("My description") }
  end
end
