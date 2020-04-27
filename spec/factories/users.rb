FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    sex { 'male' || 'female' }
    age { '10代' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
