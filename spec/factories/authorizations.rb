FactoryBot.define do
  factory :authorization do
    trait :with_user do
      after(:build) do |authorization|
        authorization.user = FactoryBot.build(:user)
      end
    end
  end
end
