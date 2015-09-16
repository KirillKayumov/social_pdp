require "rails_helper"

describe OmniauthParamsParser do
  let(:auth_hash) do
    {
      "provider" => "vkontakte",
      "uid" => "my_uid",
      "info" => {
        "email" => "user@example.com",
        "name" => "My Name",
        "location" => "My location",
        "nickname" => "kirill.kayumov",
        "urls" => {
          "Vkontakte" => "http://vk.com/kirill.kayumov"
        }
      },
      "extra" => {
        "raw_info" => {
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#email" do
    it { expect(parser.email).to eq("user@example.com") }
  end

  describe "#provider" do
    it { expect(parser.provider).to eq("vkontakte") }
  end

  describe "#uid" do
    it { expect(parser.uid).to eq("my_uid") }
  end

  describe "#name" do
    it { expect(parser.name).to eq("My Name") }
  end

  describe "#location" do
    it { expect(parser.location).to eq("My location") }
  end

  describe "#gender" do
    context "when 'sex' key is present" do
      before { auth_hash["extra"]["raw_info"]["sex"] = "male" }

      it { expect(parser.gender).to eq("male") }
    end

    context "when 'gender' key is present" do
      before { auth_hash["extra"]["raw_info"]["gender"] = "male" }

      it { expect(parser.gender).to eq("male") }
    end

    context "when gender is a number" do
      before { auth_hash["extra"]["raw_info"]["gender"] = 1 }

      it { expect(parser.gender).to eq("female") }
    end
  end

  describe "#birthday" do
    let(:date) { Date.parse("1995/09/06") }

    context "when 'bdate' key is present" do
      before { auth_hash["extra"]["raw_info"]["bdate"] = "1995/09/06" }

      it { expect(parser.birthday).to eq(date) }
    end

    context "when 'birthday' key is present" do
      before { auth_hash["extra"]["raw_info"]["birthday"] = "1995/09/06" }

      it { expect(parser.birthday).to eq(date) }
    end

    context "when provider is Facebook" do
      before do
        auth_hash["provider"] = "facebook"
        auth_hash["extra"]["raw_info"]["birthday"] = "09/06/1995"
      end

      it "swaps day and month" do
        expect(parser.birthday).to eq(date)
      end
    end
  end

  describe "#bio" do
    let(:bio) { "My bio" }

    context "when 'bio' key is present in info" do
      before { auth_hash["info"]["bio"] = bio }

      it { expect(parser.bio).to eq(bio) }
    end

    context "when 'bio' key is present in raw_info" do
      before { auth_hash["extra"]["raw_info"]["bio"] = bio }

      it { expect(parser.bio).to eq(bio) }
    end

    context "when 'description' key is present" do
      before { auth_hash["extra"]["raw_info"]["description"] = bio }

      it { expect(parser.bio).to eq(bio) }
    end
  end

  describe "#url" do
    context "when url for the provider is present" do
      it { expect(parser.url).to eq("http://vk.com/kirill.kayumov") }
    end

    context "when url for the provider is NOT present" do
      before { auth_hash["provider"] = "another_provider" }

      it "returns default url" do
        expect(parser.url).to eq("http://another_provider.com/kirill.kayumov")
      end
    end

    context "when 'urls' key is NOT present" do
      before { auth_hash["info"].delete("urls") }

      it "returns default url" do
        expect(parser.url).to eq("http://vkontakte.com/kirill.kayumov")
      end
    end
  end

  describe "#for_session" do
    let(:extra) do
      {
        "some_key" => "some_value",
        "raw_info" => {
          "another_key" => "another_value",
          "sex" => "some_value",
          "gender" => "some_value",
          "bdate" => "some_value",
          "birthday" => "some_value",
          "bio" => "some_value",
          "description" => "some_value"
        }
      }
    end

    before { auth_hash["extra"] = extra }

    it "keeps only 'raw_info' hash" do
      expect(parser.for_session["extra"].keys).to match_array(["raw_info"])
    end

    it "keeps only profile keys in 'raw_info' hash" do
      raw_info = parser.for_session["extra"]["raw_info"]

      expect(raw_info.keys).to match_array(%w(
        sex
        gender
        bdate
        birthday
        bio
        description
      ))
    end
  end
end
