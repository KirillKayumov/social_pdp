require "rails_helper"

describe OmniauthData::Twitter do
  let(:auth_hash) do
    {
      "info" => {
        "description" => "My description",
      },
      "extra" => {
        "raw_info" => {
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#bio" do
    it { expect(parser.bio).to eq("My description") }
  end

  describe "#for_session" do
    let(:hash_for_session) do
      {
        "info" => {
          "description" => "My description"
        }
      }
    end

    it { expect(parser.for_session).to eq(hash_for_session) }
  end
end
