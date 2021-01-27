FactoryBot.define do
  factory :testimonial do
    name { Faker::Internet.username }
    testimonial { Faker::Lorem.paragraph }
    source { 0 }
    association :user

    after(:build) do |testimonial|
      testimonial.user = FactoryBot.create(:user)
    end

    trait :with_shareable_link do
      after(:build) do |testimonial|
        testimonial.shareable_link = FactoryBot.create(:shareable_link, image_required: false)
      end
    end

    trait :with_shareable_link_and_image_required do
      after(:build) do |testimonial|
        testimonial.shareable_link = FactoryBot.create(:shareable_link, image_required: true)
      end
    end

    trait :tweet do
      after(:build) do |testimonial|
        testimonial.tweet!
        testimonial.tweet_status_id = Faker::Twitter.status
        testimonial.tweet_url = Faker::Internet.url
        testimonial.tweet_image_url = Faker::Internet.url
        testimonial.tweet_user_id = Faker::Twitter.user
      end
    end
  end
end
