require "rails_helper"

RSpec.feature "Confirm Account", type: :feature, js: true do
  scenario "User do a valid sign up" do
    visit new_user_registration_path

    page.fill_in 'user_name', with: 'name'
    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123456'
    page.fill_in 'user_password_confirmation', with: '123456'
    page.select 'Male', from: 'user_gender'
    click_button "Sign up"

    sleep 1
    u = User.last

    visit user_confirmation_path(confirmation_token: u.confirmation_token)

    expect(page).to have_content( 'name' )

    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123456'
    click_button "Sign in"

    expect(page).to have_current_path( homepage_users_path )
  end
end
