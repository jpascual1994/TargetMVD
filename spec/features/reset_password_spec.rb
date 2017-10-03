require 'rails_helper'

RSpec.feature 'Reset password', type: :feature, js: true do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'User want to reset his password' do
    user.confirm
    visit new_user_password_path

    page.fill_in 'user_email', with: user.email
    click_button 'Recover Password'

    expect(page).to have_current_path(home_index_path)
    expect(page).to have_content(I18n.t(:reset_email_sent))

    user.reload

    visit edit_user_password_path(reset_password_token: user.send_reset_password_instructions)

    page.fill_in 'user_password', with: '123456'
    page.fill_in 'user_password_confirmation', with: '123456'
    click_button 'Change my password'

    expect(page).to have_current_path(homepage_users_path)
  end
end
