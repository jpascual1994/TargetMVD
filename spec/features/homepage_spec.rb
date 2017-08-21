require "rails_helper"

RSpec.feature "Sign Up link", type: :feature, js: true do
  scenario "User clicks sign up link" do
    visit root_path
    click_link "SIGN UP"

    expect(page).to have_current_path(new_user_registration_path)
  end
end