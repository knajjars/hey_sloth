FactoryBot.define do
  factory :authorization do
    association :user
    token { 'token' }
    secret { 'secret' }
    provider { "twitter" }
  end
end