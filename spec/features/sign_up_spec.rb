require "rails_helper"

RSpec.feature "Sign Up", type: :feature, js: true do
  before(:each) do
    visit new_user_registration_path
  end

  scenario "Sucessful registration" do
    page.fill_in 'user_name', with: 'name'
    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123456'
    page.fill_in 'user_password_confirmation', with: '123456'
    page.select 'Male', from: 'user_gender'
    click_button  "Sign up"
    expect(page).to have_content( I18n.t(:only_more_step) )
    expect(page).to have_current_path(new_user_registration_path)
  end

  scenario "Empty form" do
    click_button "Sign up"
    expect(page).to have_content( 'Email can\'t be blank' )
    expect(page).to have_content( 'Password can\'t be blank' )
  end

  scenario "Email in use" do
    FactoryGirl.create( :user, email: 'mail@asd' )
    page.fill_in 'user_name', with: 'Fakeeee'
    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123456'
    page.fill_in 'user_password_confirmation', with: '123456'
    page.select 'Male', from: 'user_gender'
    click_button  "Sign up"
    expect(page).to have_content( 'Email has already been taken' )
  end

  scenario "Password too short" do
    page.fill_in 'user_name', with: 'name'
    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123'
    page.fill_in 'user_password_confirmation', with: '123'
    page.select 'Male', from: 'user_gender'
    click_button  "Sign up"
    expect(page).to have_content( 'Password is too short' )
  end

  scenario "Password confirmation fail" do
    page.fill_in 'user_name', with: 'name'
    page.fill_in 'user_email', with: 'mail@asd'
    page.fill_in 'user_password', with: '123456'
    page.fill_in 'user_password_confirmation', with: 'qwerty'
    page.select 'Male', from: 'user_gender'
    click_button  "Sign up"
    expect(page).to have_content( 'Password confirmation doesn\'t match Password' )
  end
end
