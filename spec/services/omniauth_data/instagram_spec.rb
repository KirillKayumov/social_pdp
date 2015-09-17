require "rails_helper"

describe OmniauthData::Instagram do
  let(:auth_hash) do
    {
      "info" => {
        "bio" => "My bio",
      },
      "extra" => {
        "raw_info" => {
          "nickname" => "my_nickname"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#bio" do
    it { expect(parser.bio).to eq("My bio") }
  end

  describe "#url" do
    it { expect(parser.url).to eq("http://instagram.com/my_nickname") }
  end
end
