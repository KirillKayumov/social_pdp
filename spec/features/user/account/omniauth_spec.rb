require "rails_helper"

feature "Social accounts connection" do
  let(:user) { create :user }

  let(:twitter_data) do
    {
      provider: "twitter",
      uid: "654321",
      info: {
        name: "Name from Twitter",
        urls: { Twitter: "http://twitter.com/user" }
      },
      extra: {}
    }
  end

  background do
    OmniAuth.config.add_mock(:twitter, twitter_data)

    login_as user
    visit edit_user_registration_path
  end

  scenario "user connects new social account" do
    click_link "Sign in with Twitter"

    expect(page).to have_content("You have successfully connected social account.")
    expect(page).to have_content("Name from Twitter")
  end

  context "when social account is connected to another user" do
    let(:another_user) { create :user }
    let!(:account) { create :account, user: user, provider: "twitter", uid: "654321" }

    it "does NOT connect social account" do
      click_link "Sign in with Twitter"

      expect(page).to have_content("This social account is already connected.")
    end
  end
end
