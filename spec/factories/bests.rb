FactoryBot.define do
  factory :best do
    best_name { Faker::Lorem.characters(number: 5) }
    user
  end
end
