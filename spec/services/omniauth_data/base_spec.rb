require "rails_helper"

describe OmniauthData::Base do
  let(:auth_hash) do
    {
      "provider" => "vkontakte",
      "uid" => "my_uid",
      "info" => {
        "email" => "user@example.com",
        "name" => "My Name",
        "location" => "My location",
        "urls" => {
          "Vkontakte" => "http://vk.com/kirill.kayumov"
        }
      },
      "extra" => {
        "raw_info" => {
          "gender" => "male",
          "nickname" => "My nickname"
        }
      }
    }
  end
  let(:parser) { described_class.new(auth_hash) }

  describe "#provider" do
    it { expect(parser.provider).to eq("vkontakte") }
  end

  describe "#uid" do
    it { expect(parser.uid).to eq("my_uid") }
  end

  describe "#email" do
    it { expect(parser.email).to eq("user@example.com") }
  end

  describe "#name" do
    it { expect(parser.name).to eq("My Name") }
  end

  describe "#location" do
    it { expect(parser.location).to eq("My location") }
  end

  describe "#gender" do
    it { expect(parser.gender).to eq("male") }
  end

  describe "#nickname" do
    it { expect(parser.nickname).to eq("My nickname") }
  end

  describe "#url" do
    it { expect(parser.url).to eq("http://vk.com/kirill.kayumov") }
  end

  describe "#for_session" do
    it { expect(parser.for_session).to eq(auth_hash) }
  end
end
