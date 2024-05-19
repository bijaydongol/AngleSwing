FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    first_name { Faker::Name.initials }
    last_name { Faker::Name.last_name }
    country { Faker::Address.country }
  end
end