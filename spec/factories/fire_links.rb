FactoryBot.define do
  factory :fire_link do
    tag { Faker::Internet.slug }
    note { Faker::Lorem.paragraph }
    social_link_required { Faker::Boolean.boolean }
    job_required { Faker::Boolean.boolean }
    image_required { Faker::Boolean.boolean }

    after(:build) do |fire_link|
      fire_link.user = FactoryBot.build(:user)
    end

    trait :image_not_required do
      image_required { false }
    end
  end
end