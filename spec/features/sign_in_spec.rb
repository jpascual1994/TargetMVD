require 'rails_helper'

RSpec.feature 'Sign In', type: :feature, js: true do
  let!(:user) { FactoryGirl.create( :user, password: '123456' ) }

  before (:each) do
    visit root_path
  end

  context 'With valid params' do
    context 'Sucessful sing in' do
      background do
        user.confirm
        fill_form_and_click user.email, '123456'
      end

      scenario 'Redirect to homepage' do
        expect(page).to have_current_path(homepage_users_path)
      end

      scenario 'Homepage show user name' do
        expect(page).to have_content(user.name)
      end
    end

    context 'Unconfirmed user' do
      background do
        fill_form_and_click user.email, '123456'
      end

      scenario 'Show unconfirmed message' do
        expect(page).to have_content('You have to confirm your email address before continuing.')
      end

      scenario 'Unconfirmed user redirect to root' do
        expect(page).to have_current_path(root_path)
      end
    end
  end

  context 'With invalid params' do
    before(:each) do
      user.confirm
    end

    scenario 'Invalid Password' do
      fill_form_and_click user.email, '65421'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'Invalid Email' do
      fill_form_and_click '', '123456'
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end

    scenario 'Redirect to root' do
      fill_form_and_click user.email, '65421'
      expect(page).to have_current_path(root_path)
    end
  end

  def fill_form_and_click(email, password)
    page.fill_in 'user_email', with: email
    page.fill_in 'user_password', with: password
    click_button  'Sign in'
  end
end
