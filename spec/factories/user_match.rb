FactoryGirl.define do
  factory :user_match, class: 'UserMatch' do
    user
    match
  end
end
