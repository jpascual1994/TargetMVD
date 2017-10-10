FactoryGirl.define do
  factory :match, class: 'Match' do
    association :first_target, factory: :user_target
    association :second_target, factory: :user_target
  end
end
