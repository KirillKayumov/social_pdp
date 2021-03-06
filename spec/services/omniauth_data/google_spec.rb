require "rails_helper"

describe OmniauthData::Google do
  let(:auth_hash) do
    {
      "info" => {
        "urls" => {
          "Google" => "my_url"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#url" do
    it { expect(parser.url).to eq("my_url") }
  end
end
