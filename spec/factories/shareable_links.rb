FactoryBot.define do
  factory :shareable_link do
    tag { Faker::Internet.slug }
    note { Faker::Lorem.paragraph }
    social_link_required { Faker::Boolean.boolean }
    job_required { Faker::Boolean.boolean }
    image_required { Faker::Boolean.boolean }

    after(:build) do |shareable_link|
      shareable_link.user = FactoryBot.build(:user)
    end

    trait :image_not_required do
      image_required { false }
    end
  end
end