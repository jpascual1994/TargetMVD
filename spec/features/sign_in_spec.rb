require 'rails_helper'

RSpec.feature 'Sign In', type: :feature, js: true do
  let!(:user) { FactoryGirl.create( :user, password: '123456' ) }

  before (:each) do
    visit root_path
  end

  context 'with valid params' do
    scenario 'Sucessful sign in' do
      user.confirm
      page.fill_in 'user_email', with: user.email
      page.fill_in 'user_password', with: '123456'
      click_button  "Sign in"
      expect(page).to have_current_path(homepage_users_path)
      expect(page).to have_content( user.name )
    end

    scenario 'Unconfirmed user' do
      page.fill_in 'user_email', with: user.email
      page.fill_in 'user_password', with: '123456'
      click_button  "Sign in"
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content( 'You have to confirm your email address before continuing.' )
    end
  end

  context 'with invalid params' do
    before(:each) do
      user.confirm
    end

    after(:each) do
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content( 'Invalid Email or password' )
    end

    scenario 'Invalid Password' do
      page.fill_in 'user_email', with: user.email
      page.fill_in 'user_password', with: '654321'
      click_button  "Sign in"
    end

    scenario 'Invalid Email' do
      page.fill_in 'user_email', with: ''
      page.fill_in 'user_password', with: '123456'
      click_button  "Sign in"
    end
  end
end
