require "rails_helper"

describe OmniauthData::Vkontakte do
  let(:auth_hash) do
    {
      "extra" => {
        "raw_info" => {
          "sex" => 1,
          "bdate" => "1995/09/06"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#gender" do
    it { expect(parser.gender).to eq("female") }
  end

  describe "#birthday" do
    let(:date) { Date.parse("1995/09/06") }

    it { expect(parser.birthday).to eq(date) }
  end
end
