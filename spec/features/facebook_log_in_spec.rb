require "rails_helper"

feature 'Confirm Account', js: true do
  background do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  context 'valid login with facebook' do
    background do
      set_valid_omniauth
      visit root_path
      click_link 'Connect with facebook'
      sleep 1
      visit user_facebook_omniauth_authorize_path
    end

    scenario 'redirect to homepage' do
      expect(page).to have_current_path( homepage_users_path )
    end

    scenario 'show the user name' do
      expect(page).to have_content( User.last.name )
    end
  end

  context 'invalid login with facebook' do
    scenario 'redirect to root' do
      set_invalid_omniauth
      visit root_path
      expect(page).to have_content('CONNECT WITH FACEBOOK')
      click_link 'Connect with facebook'
      expect(page).to have_current_path( root_path )
    end
  end
end
