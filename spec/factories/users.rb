FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
    company_name { Faker::Company.name }
    confirmed_at { Time.now }
  end
end