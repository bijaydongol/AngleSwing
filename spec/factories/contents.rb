FactoryBot.define do
  factory :content do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    association :user, factory: :user
  end
end