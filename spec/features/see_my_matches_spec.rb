require "rails_helper"

feature 'See my matches', js: true do
  let(:topic) { FactoryGirl.create(:topic) }

  let(:user) { FactoryGirl.create(:user) }
  let!(:target) { FactoryGirl.create(:user_target, user_id: user.id, topic_id: topic.id) }

  let(:other_user) { FactoryGirl.create(:user) }
  let!(:other_user_target) { FactoryGirl.create(:user_target, user_id: other_user.id, topic_id: topic.id) }

  background do
    user.confirm
    login_as user
  end

  context 'with matches' do
    let!(:other_user_target) { FactoryGirl.create(:user_target, user_id: other_user.id, topic_id: topic.id) }
    let(:match) { FactoryGirl.create(:match, first_target: target, second_target: other_user_target) }
    background do
      FactoryGirl.create(:user_match, user: user, match: match)
      FactoryGirl.create(:user_match, user: other_user, match: match)
      visit homepage_users_path
    end

    scenario 'show other user name' do
      expect(page).to have_content(other_user.name)
    end

    scenario 'show other target title' do
      expect(page).to have_content(other_user_target.title)
    end
  end

  context 'without matches' do
    background do
      visit homepage_users_path
    end

    scenario 'show no matches message' do
      expect(page).to have_content(I18n.t(:no_matches))
    end
  end
end
