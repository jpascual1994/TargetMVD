require 'rails_helper'

RSpec.feature 'Sign Out', type: :feature, js: true do
  let(:user) { FactoryGirl.create(:user) }

  background do
    user.confirm
    login_as user
    visit homepage_users_path
    click_link 'Logout'
  end

  context 'after click sign out button' do
    scenario 'redirect to root' do
      expect(page).to have_current_path(root_path)
    end

    scenario 'show sign out message' do
      expect(page).to have_content('Signed out successfully.')
    end
  end

  context 'can\'t access to home page after log out' do
    background do
      visit homepage_users_path
    end

    scenario 'redirect to root' do
      expect(page).to have_current_path(root_path)
    end

    scenario 'show not login message' do
      expect(page).to have_content('You are not logged in.')
    end
  end
end
