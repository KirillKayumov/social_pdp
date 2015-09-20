require "rails_helper"

feature "Social accounts connection" do
  def have_connected_provider(provider)
    have_css(".#{provider}.is-connected")
  end

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
  end

  scenario "user connects new social account" do
    visit edit_user_registration_path
    click_social_icon(:twitter)

    expect(page).to have_content("You have successfully connected social account.")
    expect(page).to have_content("Name from Twitter")
    expect(page).to have_connected_provider(:twitter)
  end

  context "when social account is connected to another user" do
    let(:another_user) { create :user }
    let!(:account) { create :account, user: another_user, provider: "twitter", uid: "654321" }

    it "does NOT connect social account" do
      visit edit_user_registration_path
      click_social_icon(:twitter)

      expect(page).to have_content("This social account is already connected.")
      expect(page).not_to have_connected_provider(:twitter)
    end
  end

  context "when user has social account" do
    let!(:account) { create :account, user: user, provider: "twitter", uid: "654321" }

    scenario "user deletes social account" do
      visit edit_user_registration_path
      click_social_icon(:twitter)

      expect(page).to have_content("You have successfully unlinked social account.")
      expect(page).not_to have_connected_provider(:twitter)
    end
  end
end
