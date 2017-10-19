require "rails_helper"

RSpec.feature 'New message', type: :feature, js: true do
  let(:first_user) { User.first }
  let(:second_user) { User.second }

  background do
    create_user_with_match
    first_user.confirm
    second_user.confirm

    Capybara.using_session 'user1' do
      login_as first_user
      visit root_path
    end

    Capybara.using_session 'user2' do
      login_as second_user
      visit root_path
    end
  end

  context 'with chat closed' do
    background do
      Capybara.using_session 'user1' do
        find('.match').click
        fill_in 'new-message-box', with: 'hello'
        find('.new-message-box').native.send_keys(:return)
      end
    end

    scenario 'The modal is show' do
      Capybara.using_session 'user2' do
        expect(page).to have_content('You have a new message')
      end
    end

    scenario 'Show unread message count' do
      Capybara.using_session 'user2' do
        expect(page).to have_css('div.unread-msgs', text: '1')
      end
    end
  end
end
