FactoryGirl.define do
  factory :user, class: 'User' do
    name                { Faker::Name.name }
    email               { Faker::Internet.email }
    password            { Faker::Internet.password }
    gender              { 'male' }
  end
end
