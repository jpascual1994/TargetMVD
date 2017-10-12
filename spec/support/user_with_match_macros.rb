module UserWithMatchMacros
  def create_user_with_match
    topic = FactoryGirl.create(:topic)

    user = FactoryGirl.create(:user)
    target = FactoryGirl.create(:user_target, user_id: user.id, topic_id: topic.id)

    other_user = FactoryGirl.create(:user)
    other_user_target = FactoryGirl.create(:user_target, user_id: other_user.id, topic_id: topic.id)

    match = FactoryGirl.create(:match, first_target: target, second_target: other_user_target)

    FactoryGirl.create(:user_match, user: user, match: match)
    FactoryGirl.create(:user_match, user: other_user, match: match)
  end
end
