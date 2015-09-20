require "rails_helper"

feature "Sign in using Omniauth" do
  def have_connected_provider(provider)
    have_css(".#{provider}.is-connected")
  end

  let(:facebook_data) do
    {
      provider: "facebook",
      uid: "123456",
      info: {
        name: "Name from Facebook",
        email: "user@facebook.com",
        urls: { Facebook: "http://facebook.com/user" }
      },
      extra: {
        raw_info: {
          gender: "male",
          birthday: "09/06/1995"
        }
      }
    }
  end
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
    OmniAuth.config.add_mock(:facebook, facebook_data)
    OmniAuth.config.add_mock(:twitter, twitter_data)

    visit new_user_registration_path
  end

  scenario "user signes in for the first time" do
    click_social_icon(:facebook)

    expect(page).to have_content("You have successfully signed up using social account.")
    expect(page).to have_content("Name from Facebook")
    expect(page).to have_connected_provider(:facebook)
  end

  context "when user already has account" do
    let(:user) { create :user, email: "user@facebook.com" }
    let!(:account) { create :account, user: user, provider: "facebook", uid: "123456" }

    scenario "user signes in" do
      click_social_icon(:facebook)

      expect(page).to have_content("You have successfully signed in using social account.")
      expect(page).to have_connected_provider(:facebook)
    end
  end

  context "when social account has no email" do
    background do
      click_social_icon(:twitter)
    end

    scenario "user redirects to sign up form" do
      expect(page).to have_content("Social account is not linked with any profile on the website.")
      expect(page).to have_content("Create your Social PDP site account")
    end

    scenario "user signes up to finish authentication" do
      fill_form :user,
        email: "user_from_twitter@example.com",
        password: "123456",
        password_confirmation: "123456"
      click_button "Sign up"

      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(page).to have_content("Name from Twitter")
      expect(page).to have_connected_provider(:twitter)
    end

    context "and user is already registered" do
      let!(:user) { create :user, email: "user@example.com" }

      scenario "user signs in to finish authentication" do
        visit new_user_session_path

        fill_form :user,
          email: "user@example.com",
          password: "123456"
        click_button "Sign in"

        expect(page).to have_content("Signed in successfully.")
        expect(page).to have_content("Name from Twitter")
        expect(page).to have_connected_provider(:twitter)
      end
    end
  end
end
