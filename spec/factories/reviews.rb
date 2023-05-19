FactoryBot.define do
  factory :review do
    stars { Faker::Number.between(from: 1, to: 5) }
    review { Faker::Lorem.paragraph }
    association :user
    association :movie
  end
end
