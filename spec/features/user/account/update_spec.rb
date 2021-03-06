require "rails_helper"

feature "Update Account" do
  let(:user) { create :user, :confirmed }

  background do
    login_as user
    visit edit_user_registration_path(user)
  end

  scenario "User updates profile" do
    fill_form(:user, name: "New Name")
    click_on "Update"

    expect(page).to have_field("Name", with: "New Name")
  end

  scenario "User updates password" do
    fill_form :user,
      "Enter new password" => "new_password",
      "Confirm your new password" => "new_password",
      current_password: "123456"

    click_on "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario "User updates account with invalid password" do
    fill_form(:user, name: "New Name", current_password: "wrong")
    click_on "Update"

    expect(page).to have_content("is invalid")
  end
end
