FactoryBot.define do
  factory :shareable_link do
    tag { Faker::Internet.slug }
    note { Faker::Lorem.paragraph }
    social_link_required { Faker::Boolean.boolean }
    job_required { Faker::Boolean.boolean }
    image_required { Faker::Boolean.boolean }

    trait :with_user do
      after(:build) do |shareable_link|
        shareable_link.user = FactoryBot.build(:user)
      end
    end

    # trait :with_user_and_testimonials do
    #   after(:build) do |shareable_link|
    #     shareable_link.user = FactoryBot.build(:user)
    #   end
    # end
    #
    # trait :with_user_and_logo do
    #   after(:build) do |shareable_link|
    #     shareable_link.user = FactoryBot.build(:user)
    #   end
    # end
  end
end