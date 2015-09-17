require "rails_helper"

describe OmniauthData::Github do
  let(:auth_hash) do
    {
      "extra" => {
        "raw_info" => {
          "bio" => "My bio"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#bio" do
    it { expect(parser.bio).to eq("My bio") }
  end
end
