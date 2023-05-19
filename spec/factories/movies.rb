FactoryBot.define do
  factory :movie do
    title { 'Example Movie' }
    year { 2023 }
    association :actor
    association :director
    description { Faker::Movie.quote }
    country { Faker::Address.country }
  end
end
